
Measurer =
{
    flow = nil,
    measureType = MeasureType.Sample,
    currentRange = 1,
    currentModel = ModelType.TC,
    addParam = {
        sampleChannel = nil,
        supplyChannel = nil,
    },
    temperatureBeforeAddReagent2 = 0,


    measureResult =
    {
        initReferenceAD =0,      		-- 初始参考AD值
        initMeasureAD =0,         		-- 初始测量AD值
        finalReferenceAD =0,    	 	-- 结果参考AD值
        finalMeasureAD =0,        		-- 结果参考AD值
        initRefrigeratorTemp =0,        -- 初始制冷模块温度
        initNDIRTemp =0,                -- 初始测量模块温度
        finalRefrigeratorTemp =0,       -- 反应制冷模块温度
        finalNDIRTemp =0,               -- 反应测量模块温度
        initThermostatTemp =0,    		-- 读初始值时的消解室温度
        initEnvironmentTemp =0,   	    -- 初始上机箱温度
        initEnvironmentTempDown =0,     -- 初始下机箱温度
        finalThermostatTemp =0,   	    -- 读反应值时的消解室温度
        finalEnvironmentTemp =0,  	    -- 反应值上机箱温度
        finalEnvironmentTempDown =0,    -- 反应值下机箱温度
        startIndex = 0,                 -- 读反应值数组开始索引
        endIndex = 0,                   -- 读反应值数组结束索引
        peakArea = 0,                   -- 结果峰面积数值
        startIndexIC = 0,               -- 读反应值数组开始索引
        endIndexIC = 0,                 -- 读反应值数组结束索引
        peakAreaIC = 0,                 -- 结果峰面积数值
        accurateArea1 = 0,              --精准测量面积1
        accurateArea2 = 0,              --精准测量面积2
        accurateArea3 = 0,              --精准测量面积3
        accurateArea4 = 0,              --精准测量面积4
        measureDate = os.time(),         --测量日期
        lastMeasureDate = os.time(),     --上一次测量日期
        lastAccurateMeasureTime = 0,
        startICMeasureTime = 0,
        startTemperature = 0,
        endTemperature = 0,
    },

    procedure = {},

    steps =
    {
        --1 机械复位
        {
            action = setting.runAction.measure.machineReset,
            execute = function()
                local startTime = os.time()
                --连续测量时间管理
                if setting.measureResult.mode == MeasureMode.Continous then
                    if setting.measureResult.continousModeParam.currentMeasureCnt == 0 then
                        Measurer.measureResult.measureDate = os.time()
                        Measurer.measureResult.lastMeasureDate = os.time()
                    else
                        Measurer.measureResult.measureDate = Measurer.measureResult.lastMeasureDate
                        Measurer.measureResult.lastMeasureDate = os.time()
                    end
                else
                    Measurer.measureResult.lastMeasureDate = os.time()
                end
                ----电机驱动初始化
                --op.IMotorControl:MotorDriverReinit()
                --App.Sleep(2000)
                if setting.measureResult.continousModeParam.currentMeasureCnt == 0 then
                    --机械臂复位
                    op:ManipulatorReset()
                    --进样复位检测
                    op:SlidersSensorCheck()
                    --移动至水样杯
                    op:AutoMove(setting.component.xPos.sampleMixer, setting.component.zPos.side)
                else
                    --进样复位检测
                    op:SlidersSensorCheck()
                    --移动至废液杯
                    op:AutoMove(setting.component.xPos.standardCell, setting.component.zPos.side)
                end
                --注射器复位排空
                op:SyringeReset()
                --零点校准液检测
                op:BlankCheck()
                --试剂检测
                op:ReagentCheck()
                --if Measurer.currentRange == 1 then
                --    --注射器抽空气
                    op:SyringeUpdateAir(1)
                --end
                --注射器更新
                --op:SyringeUpdate(1)

                --非连续测量模式测量前排一次冷凝水
                if setting.measureResult.continousModeParam.currentMeasureCnt == 0 then
                    --排空曝气池
                    if Measurer.currentModel == ModelType.IC or Measurer.currentModel == ModelType.TOC or Measurer.currentModel == ModelType.CODT then
                        --排空IC池
                        op:DrainFromICRoom(5)
                    end
                    op:DrainFromRefrigerator()
                    --排空混匀池
                    op:WasteRoomOutStart(config.measureParam.sampleWasteVol)
                end

                if Measurer.flow.ResultHandle then
                    Measurer:ContinousModeCheckResult() --检查测量是否完成
                end

                log:debug("机械复位时间 = " .. os.time() - startTime)
            end
        },
        --2 等待气路稳定
        {
            action = setting.runAction.measure.airFlowCheck,
            execute = function()
                local startTime = os.time()

                --检测是否达到反应温度
                --op:IsReactTemperature(Measurer.flow)
                --检测总阀压力
                op:WaitAirFlow(Measurer.flow)

                if Measurer.currentModel == ModelType.IC then
                    setting.measureResult.isMeasureIC = true
                    --开LED
                    dc:GetIOpticalAcquire():TurnOnLED(setting.LED.SMeaIndex)
                    --关LED
                    dc:GetIOpticalAcquire():TurnOffLED(setting.LED.LMeaIndex)
                    --使能总阀曝气阀常开
                    local map = ValveMap.new(setting.liquidType.exposureIC.valve | setting.liquidType.master.valve)
                    dc:GetISolenoidValve():SetValveMapNormalOpen(map)
                    --检测曝气压力
                    op:ConfirmExposureFlow(true)
                elseif Measurer.currentModel == ModelType.TOC or Measurer.currentModel == ModelType.CODT then
                    setting.measureResult.isMeasureIC = true
                    --开LED
                    dc:GetIOpticalAcquire():TurnOnLED(setting.LED.SMeaIndex)
                    --开LED
                    dc:GetIOpticalAcquire():TurnOnLED(setting.LED.LMeaIndex)
                    --使能总阀曝气阀常开
                    local map = ValveMap.new(setting.liquidType.exposureIC.valve | setting.liquidType.master.valve)
                    dc:GetISolenoidValve():SetValveMapNormalOpen(map)
                else
                    setting.measureResult.isMeasureIC = false
                    --使能总阀
                    local map = ValveMap.new(setting.liquidType.master.valve)
                    dc:GetISolenoidValve():SetValveMapNormalOpen(map)
                    --开LED
                    dc:GetIOpticalAcquire():TurnOnLED(setting.LED.LMeaIndex)
                    --检测载气压力
                    op:ConfirmAirFlow(true)
                end

                Measurer.measureResult.initRefrigeratorTemp = dc:GetReportThermostatTemp(setting.temperature.temperatureRefrigerator)
                Measurer.measureResult.initNDIRTemp = dc:GetReportThermostatTemp(setting.temperature.temperatureLNDIR)
                Measurer.measureResult.initThermostatTemp = dc:GetCurrentTemperature():GetThermostatTemp()
                Measurer.measureResult.initEnvironmentTemp = dc:GetEnvironmentTemperature()
                Measurer.measureResult.initEnvironmentTempDown = dc:GetReportThermostatTemp(setting.temperature.temperatureInsideBox)
                log:debug("检测载气时间 = " .. os.time() - startTime);
            end
        },
        --2 DrainBeforeMeasure 测量前排液
        {
            action = setting.runAction.measure.drainBeforeMeasure,
            execute = function()
                local startTime = os.time()

                if setting.measureResult.continousModeParam.currentMeasureCnt == 0 then
                    --停止排空混匀池
                    op:WasteRoomOutStop(true)
                end

                if Measurer.flow.ResultHandle then
                    Measurer:ContinousModeCheckResult() --检查测量是否完成
                end

                --稀释量程
                if Measurer.currentRange > 1 then
                    if config.measureParam.cleanBefDilute then
                        --移动至稀释杯
                        op:AutoMove(setting.component.xPos.diluteCell, setting.component.zPos.side)
                        --注射器清洗
                        op:SyringeReset()
                        --注射器清洗
                        op:SyringeUpdate(1)
                        --注射器抽空气
                        op:SyringeUpdateAir(1)
                        if Measurer.currentModel == ModelType.TC or Measurer.currentModel == ModelType.NPOC then
                            op:Exposure(setting.liquidType.exposureDilute, 10, true)
                            op:ExposureTurnOff()
                        else
                            --稀释池混匀
                            op:AirToDilute(setting.liquidType.exposureDilute, 10)
                        end
                    end
                    --排空稀释池
                    --op:DrainFromDiluteRoom(5)
                end

                if Measurer.flow.ResultHandle then
                    Measurer:ContinousModeCheckResult() --检查测量是否完成
                end

                log:debug("测量前排液时间 = " .. os.time() - startTime);
            end
        },
        --4 Rinse 润洗
        {
            action = setting.runAction.measure.rinse,
            execute = function()
                local startTime = os.time()
                local renewTime = config.measureParam.renewTime

                if renewTime > 0 then
                    for i = 1,renewTime do

                        local map = ValveMap.new(setting.liquidType.master.valve | setting.liquidType.exposureSampleMixer.valve)
                        dc:GetISolenoidValve():SetValveMapNormalOpen(map)
                        op:ExposureTurnOn()
                        dc:GetISolenoidValve():SetValveMap(map)
                        --op:ConfirmExposureFlow()

                        op:Pump(setting.liquidType.reagent1ToMixer, 0.1, 0.15)

                        if Measurer.currentRange > 1 then
                            local map = ValveMap.new(setting.liquidType.wasteDilute.valve | setting.liquidType.master.valve | setting.liquidType.exposureSampleMixer.valve)
                            dc:GetISolenoidValve():SetValveMapNormalOpen(map)
                            --排空稀释池
                            op:DrainDiluteStart()
                        end

                        --加水样
                        if Measurer.addParam.sampleVolume > 0 then
                            if config.measureParam.sampleSupplyVolume > 0 then
                                op:Pump(Measurer.addParam.sampleChannel, config.measureParam.sampleRenewVolume, setting.liquid.addLiquidSpeed) --水样管路更新
                            end
                            if Measurer.flow.ResultHandle then
                                Measurer:ContinousModeCheckResult() --检查测量是否完成
                            end
                            ----水样检测
                            --op:SampleCheck(Measurer.addParam.sampleChannel)
                        end

                        --加量程校准液
                        if Measurer.addParam.standardVolume > 0 then
                            if config.measureParam.sampleSupplyVolume > 0 then
                                op:Pump(setting.liquidType.standard, config.measureParam.sampleRenewVolume, setting.liquid.addLiquidSpeed) --水样管路更新
                            end
                            if Measurer.flow.ResultHandle then
                                Measurer:ContinousModeCheckResult() --检查测量是否完成
                            end
                            ----标样检测
                            --op:StandardCheck()
                        end

                        --加标样核查液
                        if Measurer.addParam.rangeCheckVolume > 0 then
                            if config.measureParam.sampleSupplyVolume > 0 then
                                op:Pump(setting.liquidType.rangeCheck, config.measureParam.sampleRenewVolume, setting.liquid.addLiquidSpeed) --水样管路更新
                            end
                            if Measurer.flow.ResultHandle then
                                Measurer:ContinousModeCheckResult() --检查测量是否完成
                            end
                            ----标样检测
                            --op:RangeCheck()
                        end

                        if Measurer.currentRange > 1 then
                            if Measurer.currentModel == ModelType.IC or  Measurer.currentModel == ModelType.TOC or  Measurer.currentModel == ModelType.CODT then
                                local map = ValveMap.new(setting.liquidType.exposureIC.valve | setting.liquidType.master.valve)
                                dc:GetISolenoidValve():SetValveMapNormalOpen(map)
                            else
                                local map = ValveMap.new(setting.liquidType.master.valve)
                                dc:GetISolenoidValve():SetValveMapNormalOpen(map)
                            end
                            --停止排稀释池
                            op:DrainDiluteStop()
                        end


                        if Measurer.flow.ResultHandle then
                            Measurer:ContinousModeCheckResult() --检查测量是否完成
                        end

                        op:ExposureTurnOff()
                        local map = ValveMap.new(setting.liquidType.master.valve)
                        dc:GetISolenoidValve():SetValveMapNormalOpen(map)

                        --排空混匀池
                        op:WasteRoomOutStart(config.measureParam.sampleWasteVol)

                        --停止排空混匀池
                        op:WasteRoomOutStop(true)

                        if Measurer.flow.ResultHandle then
                            Measurer:ContinousModeCheckResult() --检查测量是否完成
                        end
                    end


                end


                log:debug("润洗时间 = " .. os.time() - startTime);
            end
        },
        --4 SampleUpdate 水样更新
        {
            action = setting.runAction.measure.addSample,
            execute = function()
                local startTime = os.time()

                -- 根据测量类型获取对应的润洗体积，其中包括判断上次测量间隔时间是否超过36h
                --local RinseVolume = Measurer:GetRinseVol()
                local supplySpeed = 1

                --加水样
                if Measurer.addParam.sampleVolume > 0 then
                    if config.measureParam.sampleUpdateVolume > 0 then
                        op:Pump(Measurer.addParam.sampleChannel, config.measureParam.sampleUpdateVolume, supplySpeed) --水样管路更新
                    end
                    --水样检测
                    op:SampleCheck(Measurer.addParam.sampleChannel)
                end

                --加量程校准液
                if Measurer.addParam.standardVolume > 0 then
                    if config.measureParam.sampleUpdateVolume > 0 then
                        op:Pump(setting.liquidType.standard, config.measureParam.sampleUpdateVolume, supplySpeed) --水样管路更新
                    end
                    --标样检测
                    op:StandardCheck()
                end

                --加标样核查液
                if Measurer.addParam.rangeCheckVolume > 0 then
                    if config.measureParam.sampleUpdateVolume > 0 then
                        op:Pump(setting.liquidType.rangeCheck, config.measureParam.sampleUpdateVolume, supplySpeed) --水样管路更新
                    end
                    --标样检测
                    op:RangeCheck()
                end

                if Measurer.flow.ResultHandle then
                    Measurer:ContinousModeCheckResult() --检查测量是否完成
                end

                if Measurer.flow.ResultHandle then
                    Measurer:ContinousModeCheckResult() --检查测量是否完成
                end

                log:debug("加待测样时间 = " .. os.time() - startTime);
            end
        },
        --6 AddReagent1 加试剂一
        {
            action = setting.runAction.measure.addReagent1,
            execute = function()
                local startTime = os.time()
                local measureMode = MeasureMode.Trigger
                if Measurer.measureType == MeasureType.Sample then
                    measureMode = Measurer:GetMeasureModel(Measurer.addParam.sampleChannel)
                end
                if measureMode == MeasureMode.Continous
                    and setting.measureResult.continousModeParam.currentMeasureCnt ~= 0
                    and Measurer.currentModel == ModelType.IC
                    and  setting.measureResult.continousModeParam.isfinishContinousMeasure == true then

                    local reactTime = config.measureParam.addAfterTime

                    local restTime = os.time() - Measurer.measureResult.lastAccurateMeasureTime
                    log:debug("restTime: " .. (reactTime - restTime) .. ", done: " .. restTime)

                    if restTime < reactTime or setting.measureResult.immediatelyResultHandle == false then
                        if not Measurer.flow:Wait((reactTime - restTime)/2) then
                            error(UserStopException:new())
                        end
                        Measurer:CalibrateMeasureEndJudge((reactTime - restTime)/2)
                    end

                    Measurer:Handle(Measurer.measureResult, Measurer.currentModel)

                    if Measurer.flow.ResultHandle then
                        Measurer.flow:ResultHandle(Measurer.measureResult)
                        log:info("测量完成")
                        log:info("测量流程总时间 = ".. os.time() - Measurer.measureResult.measureDate)
                    end
                    --排空IC池
                    op:DrainFromICRoom(8)

                    setting.measureResult.continousModeParam.isfinishContinousMeasure = false
                elseif Measurer.currentModel == ModelType.IC then
                    --排空IC池
                    op:DrainFromICRoom(8)
                end

                if (Measurer.currentModel == ModelType.NPOC or Measurer.currentModel == ModelType.CODN) and Measurer.measureType ~= MeasureType.Blank then
                    local map = ValveMap.new(setting.liquidType.exposureSampleMixer.valve | setting.liquidType.reagent1ToMixer.valve)
                    dc:GetISolenoidValve():SetValveMapNormalOpen(map)

                    --op:Exposure(setting.liquidType.exposureSampleMixer, 0, true)
                    op:ExposureTurnOn()

                    --op:Pump(setting.liquidType.reagent1ToMixer,
                    --        1000,
                    --        setting.liquid.addReagentSpeed,
                    --        false)
                elseif Measurer.currentModel == ModelType.IC or Measurer.currentModel == ModelType.TOC or Measurer.currentModel == ModelType.CODT then
                    local map = ValveMap.new(setting.liquidType.exposureIC.valve | setting.liquidType.master.valve)
                    dc:GetISolenoidValve():SetValveMapNormalOpen(map)

                    --op:Exposure(setting.liquidType.exposureIC, 0, true)

                    op:Pump(setting.liquidType.reagent1ToExposure, 0.2 + config.measureParam.reagentRenewVolume, 0.15)

                    --移动至标样杯
                    op:AutoMove(setting.component.xPos.standardCell, setting.component.zPos.side)
                    --注射器清洗
                    op:SyringeReset()
                    op:SyringeSuck(setting.liquidType.syringeBlank, setting.liquid.syringeMaxVolume)
                    --移动至IC池
                    op:AutoMove(setting.component.xPos.exposureCell, setting.component.zPos.side)
                    --稀释IC池试剂一
                    op:SyringToWaste(2, setting.liquid.addDiluteSampleSpeed)

                    ----移动至标液杯
                    --op:AutoMove(setting.component.xPos.standardCell, setting.component.zPos.side)
                    ----注射器清洗
                    --op:SyringeReset()
                    ----注射器清洗
                    --op:SyringeSuck(setting.liquidType.syringeBlank, setting.liquid.syringeMaxVolume)
                    --op:SyringToWaste(1, setting.liquid.addDiluteSampleSpeed)
                    --op:SyringToWaste(setting.liquid.syringeUndoVolume)
                end

                if Measurer.flow.ResultHandle then
                    Measurer:ContinousModeCheckResult() --检查测量是否完成
                end

                log:debug("加试剂一时间 = " .. os.time() - startTime);
            end
        },
        --4 AddSample 加待测样
        {
            action = setting.runAction.measure.addSample,
            execute = function()
                local startTime = os.time()

                -- 根据测量类型获取对应的润洗体积，其中包括判断上次测量间隔时间是否超过36h
                --local RinseVolume = Measurer:GetRinseVol()
                local sampleVolume = setting.unitVolume * 12
                --加水样
                if Measurer.addParam.sampleVolume > 0
                or Measurer.addParam.standardVolume > 0
                or Measurer.addParam.rangeCheckVolume > 0
                or Measurer.addParam.zeroCheckVolume > 0  then
                    --if config.measureParam.sampleRenewVolume > 0 then
                    --    op:Pump(setting.liquidType.standard, config.measureParam.sampleRenewVolume, setting.liquid.addLiquidSpeed) --水样管路更新
                    --end
                    --op:Pump(setting.liquidType.standard, sampleVolume, setting.liquid.addLiquidSpeed)
                    if config.measureParam.sampleReduceVolume > 0 then
                        if Measurer.currentModel == ModelType.NPOC or Measurer.currentModel == ModelType.CODN then
                            local map = ValveMap.new(setting.liquidType.none.valve)
                            dc:GetISolenoidValve():SetValveMapNormalOpen(map)
                        end
                        --op:Drain(setting.liquidType.standard, config.measureParam.sampleReduceVolume, setting.liquid.addLiquidSpeed)
                        if Measurer.currentModel == ModelType.NPOC or Measurer.currentModel == ModelType.CODN then
                            local map = ValveMap.new(setting.liquidType.master.valve | setting.liquidType.exposureSampleMixer.valve)
                            dc:GetISolenoidValve():SetValveMapNormalOpen(map)
                        end
                    end
                    --停止试剂泵
                    --op:StopReagentPump()
                    if Measurer.currentModel ~= ModelType.IC and Measurer.currentModel ~= ModelType.TOC and Measurer.currentModel ~= ModelType.CODT then
                        local map = ValveMap.new(setting.liquidType.master.valve)
                        dc:GetISolenoidValve():SetValveMapNormalOpen(map)
                    end

                    if Measurer.currentModel == ModelType.NPOC or Measurer.currentModel == ModelType.CODN then
                        local map = ValveMap.new(setting.liquidType.master.valve | setting.liquidType.exposureSampleMixer.valve)
                        dc:GetISolenoidValve():SetValveMapNormalOpen(map)

                        op:Pump(setting.liquidType.reagent1ToMixer,
                                0.5 + config.measureParam.reagentRenewVolume,
                                setting.liquid.addReagentSpeed,
                                true)
                        if Measurer.currentRange > 1 then
                            if not Measurer.flow:Wait(20) then
                                error(UserStopException:new())
                            end
                        end
                    end
                end

                --稀释量程
                if Measurer.currentRange > 1 and Measurer.measureType ~= MeasureType.Blank then
                    --NPOC稀释前先曝气
                    if Measurer.currentModel == ModelType.NPOC or Measurer.currentModel == ModelType.CODN then
                        op:Exposure(setting.liquidType.exposureSampleMixer, config.measureParam.exposureTime)
                    end

                    if Measurer.addParam.standardVolume > 0 then
                        Measurer.addParam.sampleVolume = Measurer.addParam.standardVolume
                    elseif Measurer.addParam.rangeCheckVolume > 0 then
                        Measurer.addParam.sampleVolume = Measurer.addParam.rangeCheckVolume
                    elseif Measurer.addParam.zeroCheckVolume > 0 then
                        Measurer.addParam.sampleVolume = Measurer.addParam.zeroCheckVolume
                    end

                    --预先加空白水体积
                    local preAddBlankVol = 1

                    --第1次稀释抽取水样体积至稀释杯
                    if Measurer.addParam.sampleVolume > 0 then
                        --消除注射器换向误差
                        local preSuckVol = 0.1
                        --移动至废液杯
                        op:AutoMove(setting.component.xPos.standardCell, setting.component.zPos.side)
                        --注射器清洗
                        op:SyringeReset()
                        op:SyringeSuck(setting.liquidType.syringeBlank,1.5 - preSuckVol)
                        if preAddBlankVol > 0 then
                            --移动至稀释杯
                            op:AutoMove(setting.component.xPos.diluteCell, setting.component.zPos.side)
                            --预加1ml空白水
                            op:SyringToWaste(preAddBlankVol, setting.liquid.addDiluteSampleSpeed)
                        else
                            op:SyringToWaste(1, setting.liquid.addDiluteSampleSpeed)
                        end
                        op:SyringeSuck(setting.liquidType.syringeBlank, preSuckVol)
                        if Measurer.currentRange == 2 or Measurer.currentRange == 3 then
                            --移动至水样杯
                            op:AutoMove(setting.component.xPos.sampleMixer, setting.component.zPos.bottom)
                            op:SyringeSuck(setting.liquidType.syringeNone,  Measurer.addParam.sampleVolume + setting.liquid.syringeUndoVolume)
                            op:AutoMove(setting.component.xPos.sampleMixer, setting.component.zPos.side)
                            op:SyringToWaste(setting.liquid.syringeUndoVolume)
                            --移动至稀释杯
                            op:AutoMove(setting.component.xPos.diluteCell, setting.component.zPos.side)
                            op:SyringToWaste(Measurer.addParam.sampleVolume, setting.liquid.addDiluteSampleSpeed)

                            op:ExposureTurnOn(20)
                            local map = ValveMap.new(setting.liquidType.exposureDilute.valve | setting.liquidType.master.valve)
                            if map ~= nil then
                                dc:GetISolenoidValve():SetValveMapNormalOpen(map)
                            end
                        else
                            --移动至水样杯
                            op:AutoMove(setting.component.xPos.sampleMixer, setting.component.zPos.bottom)  --syringeMaxVolume
                            op:SyringeSuck(setting.liquidType.syringeNone, Measurer.addParam.sampleVolume + setting.liquid.syringeUndoVolume)
                            op:AutoMove(setting.component.xPos.sampleMixer, setting.component.zPos.side)
                            op:SyringToWaste(setting.liquid.syringeUndoVolume)
                            --移动至稀释杯
                            op:AutoMove(setting.component.xPos.diluteCell, setting.component.zPos.side)
                            op:SyringToWaste(Measurer.addParam.sampleVolume, setting.liquid.addDiluteSampleSpeed) --10000量程先不加水样和空白水一起加
                            --op:SyringToWaste(preAddBlankVol, setting.liquid.addDiluteSampleSpeed)

                            op:ExposureTurnOn(20)
                            local map = ValveMap.new(setting.liquidType.exposureDilute.valve | setting.liquidType.master.valve)
                            if map ~= nil then
                                dc:GetISolenoidValve():SetValveMapNormalOpen(map)
                            end
                        end
                    end

                    --第1次稀释加零点校准液体积
                    if Measurer.addParam.blankVolume > 0 then
                        --第一次填充空白水
                        op:SyringeSuck(setting.liquidType.syringeBlank, 2)
                        --移动至稀释杯
                        op:AutoMove(setting.component.xPos.diluteCell, setting.component.zPos.side)
                        --高量程分三次加空白水
                        if Measurer.addParam.blankVolume > 4.5 then
                            local volTable = {2, Measurer.addParam.blankVolume - 2 - preAddBlankVol}
                            --第一次加空白水
                            op:SyringToWaste(volTable[1],setting.liquid.addDiluteSampleSpeed)
                            --第二次填充空白水
                            op:SyringeSuck(setting.liquidType.syringeBlank, volTable[2])
                            --第二次加空白水
                            op:SyringToWaste(volTable[2],setting.liquid.addDiluteSampleSpeed)
                        elseif Measurer.addParam.blankVolume > 3.5 then
                            local volTable = {2,Measurer.addParam.blankVolume - 2 - preAddBlankVol}
                            --第一次加空白水
                            op:SyringToWaste(volTable[1],setting.liquid.addDiluteSampleSpeed)
                            --第二次填充空白水
                            op:SyringeSuck(setting.liquidType.syringeBlank, volTable[2])
                            --第二次加空白水
                            op:SyringToWaste(volTable[2],setting.liquid.addDiluteSampleSpeed)
                        elseif Measurer.addParam.blankVolume >= 2 then
                            local volTable = {Measurer.addParam.blankVolume - preAddBlankVol}
                            --第一次加空白水
                            op:SyringToWaste(volTable[1],setting.liquid.addDiluteSampleSpeed)
                        else
                            op:SyringToWaste(Measurer.addParam.blankVolume,setting.liquid.addDiluteSampleSpeed)
                        end
                    end

                    --第2次稀释抽取水样体积
                    if Measurer.addParam.dilutionExtractVolume2 > 0 then
                    end

                    --第2次稀释加零点校准液体积
                    if Measurer.addParam.dilutionAddBlankVolume2 > 0 then
                    end

                    if Measurer.currentModel == ModelType.TC or Measurer.currentModel == ModelType.NPOC or Measurer.currentModel == ModelType.CODN then
                        --op:ExposureTurnOn(20)
                        --local map = ValveMap.new(setting.liquidType.exposureDilute.valve | setting.liquidType.master.valve)
                        --if map ~= nil then
                        --    dc:GetISolenoidValve():SetValveMap(map)
                        --end
                        --op:ConfirmExposureFlow(false,20)
                        if not Measurer.flow:Wait(5) then
                            error(UserStopException:new())
                        end
                        local map = ValveMap.new(setting.liquidType.master.valve)
                        if map ~= nil then
                            dc:GetISolenoidValve():SetValveMapNormalOpen(map)
                        end
                        --op:Exposure(setting.liquidType.exposureDilute, 15, true)
                        op:ExposureTurnOff()
                    else
                        local map = ValveMap.new(setting.liquidType.master.valve)
                        if map ~= nil then
                            dc:GetISolenoidValve():SetValveMapNormalOpen(map)
                        end
                        --稀释池混匀
                        op:AirToDilute(setting.liquidType.exposureDilute, 15)
                        local map = ValveMap.new(setting.liquidType.exposureIC.valve | setting.liquidType.master.valve)
                        if map ~= nil then
                            dc:GetISolenoidValve():SetValveMapNormalOpen(map)
                        end
                        op:ExposureTurnOn()
                    end

                elseif Measurer.measureType == MeasureType.Blank then
                    --测零点校准液
                    if Measurer.currentModel == ModelType.NPOC or Measurer.currentModel == ModelType.CODN then
                        local map = ValveMap.new(setting.liquidType.exposureDilute.valve | setting.liquidType.master.valve)
                        dc:GetISolenoidValve():SetValveMapNormalOpen(map)
                        --排空稀释池
                        op:DrainFromDiluteRoom(5)
                        --注射器清洗
                        op:SyringeReset()
                        --移动至稀释杯
                        op:AutoMove(setting.component.xPos.diluteCell, setting.component.zPos.side)
                        op:SyringeSuck(setting.liquidType.syringeBlank, 2)
                        op:SyringToWaste(0, setting.liquid.addDiluteSampleSpeed)
                        op:SyringeSuck(setting.liquidType.syringeBlank, 2)
                        op:SyringToWaste(0, setting.liquid.addDiluteSampleSpeed)

                        op:Exposure(setting.liquidType.exposureDilute, 15,true)
                        local map = ValveMap.new(setting.liquidType.master.valve)
                        dc:GetISolenoidValve():SetValveMapNormalOpen(map)
                        --排空稀释池
                        op:DrainFromDiluteRoom(5)
                        local map = ValveMap.new(setting.liquidType.exposureDilute.valve | setting.liquidType.master.valve)
                        dc:GetISolenoidValve():SetValveMapNormalOpen(map)
                        --注射器清洗
                        op:SyringeReset()
                        --移动至稀释杯
                        op:AutoMove(setting.component.xPos.diluteCell, setting.component.zPos.side)
                        op:SyringeSuck(setting.liquidType.syringeBlank, 2)
                        op:SyringToWaste(0, setting.liquid.addDiluteSampleSpeed)
                        op:SyringeSuck(setting.liquidType.syringeBlank, 2)
                        op:SyringToWaste(0, setting.liquid.addDiluteSampleSpeed)
                        op:SyringeSuck(setting.liquidType.syringeBlank, setting.liquid.syringeAddMaxVloume)
                    else
                        --op:SyringeSuck(setting.liquidType.syringeBlank, setting.liquid.syringeAddMaxVloume)
                    end
                end

                if Measurer.flow.ResultHandle then
                    Measurer:ContinousModeCheckResult() --检查测量是否完成
                end

                log:debug("加待测样时间 = " .. os.time() - startTime);
            end
        },
        --7 exposure 曝气
        {
            action = setting.runAction.measure.exposureNirtrogen,
            execute = function()
                local startTime = os.time()
                if (Measurer.currentModel == ModelType.NPOC or Measurer.currentModel == ModelType.CODN)
                    and Measurer.currentRange == 1 then
                    if Measurer.measureType == MeasureType.Blank then
                        op:Exposure(setting.liquidType.exposureDilute, config.measureParam.exposureTime,false)
                    else
                        op:Exposure(setting.liquidType.exposureSampleMixer, config.measureParam.exposureTime)
                    end
                end

                if Measurer.flow.ResultHandle then
                    Measurer:ContinousModeCheckResult() --检查测量是否完成
                end

                log:debug("曝气时间 = " .. os.time() - startTime)
            end
        },
        --8 管路更新
        {
            action = setting.runAction.measure.updateTime,
            execute = function()
                local startTime = os.time()

                if Measurer.currentModel == ModelType.TC or Measurer.currentModel == ModelType.NPOC or Measurer.currentModel == ModelType.CODN then
                    --基本量程
                    if Measurer.currentRange == 1 then
                        --测量NPOC空白水
                        if Measurer.measureType == MeasureType.Blank then
                            if (Measurer.currentModel == ModelType.NPOC or Measurer.currentModel == ModelType.CODN) then
                                --移动至稀释杯
                                op:AutoMove(setting.component.xPos.diluteCell, setting.component.zPos.bottom)
                                op:SyringeSuck(setting.liquidType.syringeNone, setting.liquid.syringeAddMaxVloume)
                                op:AutoMove(setting.component.xPos.diluteCell, setting.component.zPos.side)
                            end
                        else
                            --移动至水样杯
                            op:AutoMove(setting.component.xPos.sampleMixer, setting.component.zPos.bottom)
                            op:SyringeSuck(setting.liquidType.syringeNone, setting.liquid.syringeAddMaxVloume)
                            op:AutoMove(setting.component.xPos.sampleMixer, setting.component.zPos.side)
                        end
                    else
                        --移动至稀释杯
                        op:AutoMove(setting.component.xPos.diluteCell, setting.component.zPos.bottom)
                        op:SyringeSuck(setting.liquidType.syringeNone, setting.liquid.syringeAddMaxVloume)
                        op:AutoMove(setting.component.xPos.diluteCell, setting.component.zPos.side)
                    end
                    op:SyringToWaste(setting.liquid.syringeUndoVolume * 4)
                    App.Sleep(500);
                    op:SyringToWaste(setting.liquid.syringeUndoVolume)
                    --移动至燃烧炉
                    op:AutoMove(setting.component.xPos.stoveCell, setting.component.zPos.top)
                elseif Measurer.currentModel == ModelType.IC or Measurer.currentModel == ModelType.TOC or Measurer.currentModel == ModelType.CODT then

                    if Measurer.measureType == MeasureType.Blank then

                    elseif Measurer.currentRange == 1 then
                        --移动至水样池
                        op:AutoMove(setting.component.xPos.sampleMixer, setting.component.zPos.bottom)
                        op:SyringeSuck(setting.liquidType.syringeNone, setting.liquid.syringeAddMaxVloume)
                        op:AutoMove(setting.component.xPos.sampleMixer, setting.component.zPos.side)
                    else
                        --移动至稀释杯
                        op:AutoMove(setting.component.xPos.diluteCell, setting.component.zPos.bottom)
                        op:SyringeSuck(setting.liquidType.syringeNone, setting.liquid.syringeAddMaxVloume)
                        op:AutoMove(setting.component.xPos.diluteCell, setting.component.zPos.side)
                    end

                    op:SyringToWaste(setting.liquid.syringeUndoVolume)
                    if Measurer.currentModel == ModelType.IC then
                        --移动至曝气池，准备将水样喷入IC池
                        op:AutoMove(setting.component.xPos.exposureCell, setting.component.zPos.top)
                    end

                end

                log:debug("管路更新时间 = " .. os.time() - startTime)
            end
        },
        --9 加样等待
        {
            action = setting.runAction.measure.baseLineCheck,
            execute = function()

                if setting.measureResult.continousModeParam.isfinishContinousMeasure == true then
                    local startTime = os.time()
                    --连续测量的第二次开始，每次都在此处等待剩余的时长
                    if setting.measureResult.continousModeParam.currentMeasureCnt ~= 0 then
                        local runAction = Helper.Status.SetAction(setting.runAction.measure.waittingResult)
                        StatusManager.Instance():SetAction(runAction)
                        log:debug("currentMeasureCnt: " .. setting.measureResult.continousModeParam.currentMeasureCnt)
                        log:debug("lastStartIndex: " .. setting.measureResult.continousModeParam.lastStartIndex)

                        Measurer.measureResult.endIndex = 0
                        Measurer.measureResult.startIndex = setting.measureResult.continousModeParam.lastStartIndex

                        local reactTime = config.measureParam.addAfterTime

                        local restTime = os.time() - Measurer.measureResult.lastAccurateMeasureTime
                        log:debug("restTime: " .. (reactTime - restTime) .. ", done: " .. restTime)

                        if restTime < reactTime or setting.measureResult.immediatelyResultHandle == false then
                            if not Measurer.flow:Wait(reactTime - restTime) then
                                error(UserStopException:new())
                            end
                        end

                        Measurer:Handle(Measurer.measureResult, Measurer.currentModel)

                        if Measurer.flow.ResultHandle then
                            Measurer.flow:ResultHandle(Measurer.measureResult)
                            log:info("测量完成")
                            log:info("测量流程总时间 = ".. os.time() - Measurer.measureResult.measureDate)
                        end

                    end

                    log:debug("加样等待时间 = " .. os.time() - startTime)
                end
            end
        },
        --10 加样
        {
            action = setting.runAction.measure.addSampleTime,
            execute = function()
                local startTime = os.time()
                if Measurer.currentModel == ModelType.TC or Measurer.currentModel == ModelType.NPOC or Measurer.currentModel == ModelType.CODN then
                    --检测载气压力
                    --op:ConfirmAirFlow(true)
                    --检测LED信号
                    --op:ConfirmLED()
                    --燃烧炉加水样
                    op:AddDosingToStove(Measurer.measureResult)
                elseif Measurer.currentModel == ModelType.IC then
                    --检测曝气压力
                    --op:ConfirmExposureFlow(true)
                    --移动至IC池
                    op:AutoMove(setting.component.xPos.exposureCell, setting.component.zPos.side)
                    --测IC后排液
                    Measurer:DrainAfterMeasureIC()
                    --曝气池加水样
                    op:AddSampleToExposure(Measurer.measureResult)
                    --等待反应结果
                    Measurer:WaitResult()
                elseif Measurer.currentModel == ModelType.TOC or Measurer.currentModel == ModelType.CODT then
                    --检测曝气压力
                    --op:ConfirmExposureFlow(true)
                    status.measure.isCheckBaseLine = false
                    --移动至燃烧炉
                    op:AutoMove(setting.component.xPos.stoveCell, setting.component.zPos.top)
                    --燃烧炉加水样
                    op:AddDosingToStove(Measurer.measureResult)
                    --移动至IC池
                    op:AutoMove(setting.component.xPos.exposureCell, setting.component.zPos.side)
                    --测IC后排液
                    Measurer:DrainAfterMeasureIC()
                    --曝气池加水样
                    op:AddSampleToExposure(Measurer.measureResult)
                    --等待反应结果
                    Measurer:WaitResult()
                end
                log:debug("加样时间 = " .. os.time() - startTime)

            end
        },
        --11 drainAfterMeasure 测量后排液
        {
            action = setting.runAction.measure.drainAfterMeasure,
            execute = function()
                local startTime = os.time()

                if Measurer.currentModel == ModelType.TC
                        or Measurer.currentModel == ModelType.NPOC
                        or Measurer.currentModel == ModelType.CODN then
                    --移动至废液杯
                    op:AutoMove(setting.component.xPos.standardCell, setting.component.zPos.side)
                    if Measurer.currentRange > 1 then
                        local map = ValveMap.new(setting.liquidType.wasteDilute.valve | setting.liquidType.master.valve)
                        dc:GetISolenoidValve():SetValveMapNormalOpen(map)
                        --排空稀释池
                        op:DrainDiluteStart()
                    end

                    --注射器复位
                    op:SyringeReset()
                    if Measurer.measureType == MeasureType.Sample then
                        --排空混匀池
                        op:WasteRoomOutStart()--config.measureParam.sampleWasteVol
                        --排空均质池
                        op:DrainExtendSampleStart(Measurer.addParam.supplyChannel, config.measureParam.drainFromMixerVol, 1)
                        --停止均质器排空
                        op:DrainExtendSampleStop(Measurer.addParam.supplyChannel, true)
                        --停止排空混匀池
                        op:WasteRoomOutStop()
                    else
                        --排空混匀池
                        op:WasteRoomOutStart(config.measureParam.sampleWasteVol)
                        --停止排空混匀池
                        op:WasteRoomOutStop(true)
                    end

                    if Measurer.currentRange > 1 then
                        if Measurer.currentModel == ModelType.IC or  Measurer.currentModel == ModelType.TOC or  Measurer.currentModel == ModelType.CODT then
                            local map = ValveMap.new(setting.liquidType.exposureIC.valve | setting.liquidType.master.valve)
                            dc:GetISolenoidValve():SetValveMapNormalOpen(map)
                        else
                            local map = ValveMap.new(setting.liquidType.master.valve)
                            dc:GetISolenoidValve():SetValveMapNormalOpen(map)
                        end
                        --停止排稀释池
                        op:DrainDiluteStop()
                    end
                    if  Measurer.measureType == MeasureType.Sample then
                        log:debug("水样管回退")
                        --回退
                        op:Drain(Measurer.addParam.sampleChannel, 1  + config.measureParam.extendSamplePipeVolume, setting.liquid.addLiquidSpeed)
                    end
                    ----稀释量程
                    --if Measurer.currentRange > 1 and Measurer.measureType ~= MeasureType.Blank then
                    --    --排空稀释池
                    --    op:DrainFromDiluteRoom(8)
                    --end

                    log:debug("测量后排液时间 = " .. os.time() - startTime);
                end
            end
        },
        --12 反应
        {
            action = setting.runAction.measure.waittingResult,
            execute = function()
                local startTime = os.time()

                --TOC测量模式下直接等测量结果
                if Measurer.currentModel == ModelType.TOC or Measurer.currentModel == ModelType.CODT then
                    ----机械臂复位
                    --op:ManipulatorReset()

                    setting.measureResult.isMeasureIC = false
                    local reactTime = config.measureParam.addAfterTime
                    local restTime = os.time() - Measurer.measureResult.lastAccurateMeasureTime
                    log:debug("TC restTime: " .. (reactTime - restTime) .. ", done: " .. restTime)

                    if restTime < reactTime or setting.measureResult.immediatelyResultHandle == false then
                        if not Measurer.flow:Wait((reactTime - restTime)/2) then
                            error(UserStopException:new())
                        end
                        Measurer:CalibrateMeasureEndJudge((reactTime - restTime)/2)
                    end
                    Measurer:Handle(Measurer.measureResult, ModelType.TC)

                    setting.measureResult.continousModeParam.isfinishContinousMeasure = false
                    setting.measureResult.continousModeParam.currentMeasureCnt = setting.measureResult.continousModeParam.currentMeasureCnt + 1
                elseif Measurer.currentModel == ModelType.IC then
                    local measureMode = MeasureMode.Trigger
                    if Measurer.measureType == MeasureType.Sample then
                        measureMode = Measurer:GetMeasureModel(Measurer.addParam.sampleChannel)
                    end
                    --非连续IC模式下进行机械复位
                    if measureMode ~= MeasureMode.Continous or setting.measureResult.isStartCalibrate == true then
                        --移动至废液杯
                        op:AutoMove(setting.component.xPos.standardCell, setting.component.zPos.side)
                        --注射器复位
                        op:SyringeReset()
                        --机械臂复位
                        op:ManipulatorReset()
                    end
                    setting.measureResult.continousModeParam.isfinishContinousMeasure = false
                else
                    local measureMode = MeasureMode.Trigger
                    if Measurer.measureType == MeasureType.Sample then
                        measureMode = Measurer:GetMeasureModel(Measurer.addParam.sampleChannel)
                    end
                    --非连续模式下等待出测量结果
                    if measureMode ~= MeasureMode.Continous or setting.measureResult.isStartCalibrate == true then
                        --机械臂复位
                        op:ManipulatorReset()

                        local reactTime = config.measureParam.addAfterTime

                        local restTime = os.time() - Measurer.measureResult.lastAccurateMeasureTime
                        log:debug("restTime: " .. (reactTime - restTime) .. ", done: " .. restTime)

                        if restTime < reactTime or setting.measureResult.immediatelyResultHandle == false then
                            if not Measurer.flow:Wait((reactTime - restTime)/2) then
                                error(UserStopException:new())
                            end
                            Measurer:CalibrateMeasureEndJudge((reactTime - restTime)/2)
                        end

                        Measurer:Handle(Measurer.measureResult, Measurer.currentModel)

                        setting.measureResult.continousModeParam.isfinishContinousMeasure = false
                    else --连续模式下跳过等待直接下一个流程
                        setting.measureResult.continousModeParam.isfinishContinousMeasure = true
                    end
                end

                log:debug("反应时间 = " .. os.time() - startTime);
            end
        },
        --13 返回结果
        {
            action = nil,
            execute = function()
                status.measure.lastMeasureEndTime = os.time()

                if setting.measureResult.continousModeParam.isfinishContinousMeasure == false then
                    --非0-10量程： 非连续模式>>连续测量
                    --需判定是否完成精准测量动作，并直接在当前流程出测量结果
                    if setting.measureResult.isFinishAccurateMeasure == true then
                        setting.measureResult.isFinishAccurateMeasure = false
                    end

                    if Measurer.flow.ResultHandle then
                        Measurer.flow:ResultHandle(Measurer.measureResult)
                    end

                    if Measurer.currentModel == ModelType.IC or Measurer.currentModel == ModelType.TOC or Measurer.currentModel == ModelType.CODT then
                        --排空IC池
                        op:DrainFromICRoom(8)
                    else
                        setting.measureResult.continousModeParam.currentMeasureCnt = 0
                    end

                else
                    setting.measureResult.continousModeParam.isfinishContinousMeasure = true  --连续测量标志位
                    setting.measureResult.continousModeParam.lastAccuratePeakArea = Measurer.measureResult.peakArea
                    setting.measureResult.continousModeParam.lastStartIndex = Measurer.measureResult.startIndex
                    setting.measureResult.continousModeParam.currentMeasureCnt = setting.measureResult.continousModeParam.currentMeasureCnt + 1
                    log:debug("流程执行次数 = " .. setting.measureResult.continousModeParam.currentMeasureCnt);
                end
            end
        },
    },
}

function Measurer:SkipFlow()
    status.measure.lastMeasureEndTime = os.time()
    if Measurer.flow.ResultHandle then
        Measurer.flow:ResultHandle(Measurer.measureResult)
    end
end

function Measurer:Measure()
    if nil ~= setting.common.skipFlow and true == setting.common.skipFlow then
        Measurer:SkipFlow()
        return Measurer.measureResult
    end
    if #self.procedure ~= 0  then
        print("--------------Execute configuration procedure--------------")
        for i, index in pairs(self.procedure) do
            print("index = ".. index)
            local step = self.steps[index]
            if step.action then
                local runAction = Helper.Status.SetAction(step.action)
                StatusManager.Instance():SetAction(runAction)
                log:info(step.action.text)
            end

            step.execute()
        end
    else
        print("--------------Execute default procedure--------------")
        for i, step in pairs(self.steps) do
            print("i = ".. i)
            if step.action then
                local runAction = Helper.Status.SetAction(step.action)
                StatusManager.Instance():SetAction(runAction)
                log:info(step.action.text)
            end

            step.execute()
        end
    end

    return Measurer.measureResult
end

--[[
 * @brief 校准测量终点判断
 * @details
--]]
function Measurer:CalibrateMeasureEndJudge(time)
    local startTime = os.time()
    local timeout = 0
    if time ~= nil and time > 0 then
        timeout = time
    end

    while true do
        local currentTime = os.time()
        if currentTime - startTime > timeout then
            break
        elseif op:IsReachSteady(setting.measureResult.baseLineNum*2, setting.measureResult.validCnt) == false then
            if not Measurer.flow:Wait(2) then
                break
            end
        else
            break
        end
    end
end

function Measurer:Reset()
    Measurer.flow = nil
    Measurer.measureType = MeasureType.Sample
    Measurer.currentRange = 1
    Measurer.procedure = {}

    for k, v in pairs(Measurer.addParam) do
        Measurer.addParam[k] = nil
    end

    for k, v in pairs(Measurer.measureResult) do
        v = 0
    end
end

function Measurer:GetMeasureResult()
    local dstTable = {}
    for k, v in pairs(Measurer.measureResult) do
        dstTable[k] = v
    end
    return dstTable
end

function Measurer:GetZeroMeasureResult()
    local dstTable = {}
    for k, v in pairs(Measurer.measureResult) do
        dstTable[k] = 0
    end
    return dstTable
end


function Measurer:TimeCheck()
    local currentTime = os.time()
    local lastTime
    local temp
    local MeasurerIntervalMaxTime = 36*60*60        --距离上次测量允许度最大间隔时间，超过则进行额外清洗

    temp = status.measure.lastMeasureEndTime

    if temp  == 0 then
        log:debug("出厂首次流程测量")
        return true
    end

    lastTime = temp + MeasurerIntervalMaxTime
    if lastTime - currentTime < 0 then
        log:debug("距离上次测量已超36小时")
        return true
    else
        return false
    end
end

function Measurer:GetRinseVol()
    local rinseVol = 0

    if Measurer:TimeCheck() then
        rinseVol = setting.unitVolume * 2
    else
        if Measurer.addParam.rinseSampleVolume > 0 then
            rinseVol = Measurer.addParam.rinseSampleVolume
        elseif Measurer.addParam.rinseStandardVolume > 0 then
            rinseVol = Measurer.addParam.rinseStandardVolume
        elseif Measurer.addParam.rinseZeroCheckVolume > 0 then
            rinseVol = Measurer.addParam.rinseZeroCheckVolume
        elseif Measurer.addParam.rinseRangeCheckVolume > 0 then
            rinseVol = Measurer.addParam.rinseRangeCheckVolume
        elseif Measurer.addParam.rinseBlankVolume > 0 then
            rinseVol = Measurer.addParam.rinseBlankVolume
        end
    end


    return rinseVol
end

function Measurer:GetMeasureModel(channel)

    if channel == setting.liquidType.exSampleOut1 then
        setting.measureResult.mode = config.scheduler.measure.mode
    elseif channel == setting.liquidType.exSampleOut2 then
        setting.measureResult.mode = config.scheduler.measureChannelTwo.mode
    elseif channel == setting.liquidType.exSampleOut3 then
        setting.measureResult.mode = config.scheduler.measureChannelThree.mode
    elseif channel == setting.liquidType.exSampleOut4 then
        setting.measureResult.mode = config.scheduler.measureChannelFour.mode
    elseif channel == setting.liquidType.exSampleOut5 then
        setting.measureResult.mode = config.scheduler.measureChannelFive.mode
    elseif channel == setting.liquidType.exSampleOut6 then
        setting.measureResult.mode = config.scheduler.measureChannelSix.mode
    else
        log:debug("Invalid Channel Input")
        return MeasureMode.Trigger
    end
    return setting.measureResult.mode
end


--[[
 * @brief 生成测量数据
 * @details 该函数应当用于连续模式切换导致其他模式此类情形
--]]
function Measurer:ContinousMeasureSafetyStop()
    if setting.measureResult.continousModeParam.currentMeasureCnt ~= 0 then

        log:debug("safe currentMeasureCnt: " .. setting.measureResult.continousModeParam.currentMeasureCnt)
        log:debug("safe lastStartIndex: " .. setting.measureResult.continousModeParam.lastStartIndex)

        Measurer.measureResult.endIndex = 0
        Measurer.measureResult.startIndex = setting.measureResult.continousModeParam.lastStartIndex
        local reactTime = config.measureParam.addAfterTime

        local restTime = os.time() - Measurer.measureResult.lastAccurateMeasureTime
        log:debug("restTime: " .. (reactTime - restTime) .. ", done: " .. restTime)

        if restTime < reactTime or setting.measureResult.immediatelyResultHandle == false then
            if not Measurer.flow:Wait((reactTime - restTime)/2) then
                error(UserStopException:new())
            end
            Measurer:CalibrateMeasureEndJudge((reactTime - restTime)/2)
            --if not Measurer.flow:Wait(40) then
            --    error(UserStopException:new())
            --end
        end

        Measurer:Handle(Measurer.measureResult, Measurer.currentModel)

        --连续测量中时间排冷凝液抢占
        Measurer.measureResult.measureDate = Measurer.measureResult.lastMeasureDate
        if Measurer.flow.ResultHandle then
            Measurer.flow:ResultHandle(Measurer.measureResult)
            log:info("测量完成")
            log:info("测量流程总时间 = ".. os.time() - Measurer.measureResult.measureDate)
        end
    end
end


--[[
 * @brief 检测连续模式测量结果
 * @details 用于检测反应时间是否超时
--]]
function Measurer:ContinousModeCheckResult()
    if setting.measureResult.continousModeParam.isfinishContinousMeasure == true then

        Measurer.measureResult.endIndex = 0
        Measurer.measureResult.startIndex = setting.measureResult.continousModeParam.lastStartIndex
        local restTime = os.time() -  Measurer.measureResult.lastAccurateMeasureTime

        if op:IsReachSteady(setting.measureResult.baseLineNum*2, setting.measureResult.validCnt) == true or
                setting.measureResult.immediatelyResultHandle == true or restTime > config.measureParam.addAfterTime   then

            if restTime < config.measureParam.addAfterTime/2 then
                return
            end
            --if not Measurer.flow:Wait(20) then
            --    error(UserStopException:new())
            --end
            Measurer:Handle(Measurer.measureResult, Measurer.currentModel)

            if Measurer.flow.ResultHandle then
                Measurer.flow:ResultHandle(Measurer.measureResult)
                log:info("测量完成")
                log:info("测量流程总时间 = ".. os.time() - Measurer.measureResult.measureDate)
            end
            setting.measureResult.continousModeParam.isfinishContinousMeasure = false
            --op:DrainFromRefrigerator()
        end
    end
end

--[[
 * @brief 结果处理
 * @details
--]]
function Measurer:Handle(measureResult, modelType)
    measureResult.finalRefrigeratorTemp = dc:GetReportThermostatTemp(setting.temperature.temperatureRefrigerator)
    measureResult.finalNDIRTemp = dc:GetReportThermostatTemp(setting.temperature.temperatureLNDIR)
    measureResult.finalThermostatTemp = dc:GetCurrentTemperature():GetThermostatTemp()
    measureResult.finalEnvironmentTemp = dc:GetEnvironmentTemperature()
    measureResult.finalEnvironmentTempDown = dc:GetReportThermostatTemp(setting.temperature.temperatureInsideBox)

    local num = 0
    print("type " .. modelType)

    if modelType == ModelType.IC then
        num = dc:GetExScanLen()
        if num ~= nil then
            measureResult.endIndexIC = num
            log:debug("IC标记结束： " .. num);
        end
    else
        num = dc:GetScanLen()
        if num ~= nil then
            measureResult.endIndex = num
            log:debug("标记结束： " .. num);
        end
    end

    if config.measureParam.accurateMeasure == false and setting.measureResult.isFinishAccurateMeasure == false then
        if modelType == ModelType.IC then
            measureResult.peakAreaIC = op:CalculatePeakArea(measureResult.startIndexIC, measureResult.endIndexIC, nil, false, Measurer.measureType)
            log:debug("IC普通测量： " .. measureResult.peakAreaIC)
        else
            measureResult.peakArea = op:CalculatePeakArea(measureResult.startIndex, measureResult.endIndex, nil, false, Measurer.measureType)
            log:debug("普通测量： " .. measureResult.peakArea)
        end

    elseif config.measureParam.accurateMeasure == true or setting.measureResult.isFinishAccurateMeasure == true then
        --清精准定量动作完成标志位
        setting.measureResult.isFinishAccurateMeasure = false
        if setting.measureResult.immediatelyResultHandle == true then
            --完成精准测量无需赋值
            setting.measureResult.immediatelyResultHandle = false
        else
            measureResult.accurateArea4 = op:CalculatePeakArea(measureResult.startIndex, measureResult.endIndex, nil, false, Measurer.measureType)
            if measureResult.accurateArea4 == -1 then
                error(UserStopException:new())
            end
            if measureResult.accurateArea1 == 0 and
                    measureResult.accurateArea2 == 0 and
                    measureResult.accurateArea3 == 0 then
                measureResult.peakArea = measureResult.accurateArea4
            else
                local deviation12 = math.abs(measureResult.accurateArea2 - measureResult.accurateArea1)/
                        ((measureResult.accurateArea2 + measureResult.accurateArea1)/2)
                local deviation23 = math.abs(measureResult.accurateArea3 - measureResult.accurateArea2)/
                        ((measureResult.accurateArea3 + measureResult.accurateArea2)/2)
                local deviation34 = math.abs(measureResult.accurateArea4 - measureResult.accurateArea3)/
                        ((measureResult.accurateArea4 + measureResult.accurateArea3)/2)
                local deviation14 = math.abs(measureResult.accurateArea4 - measureResult.accurateArea1)/
                        ((measureResult.accurateArea4 + measureResult.accurateArea1)/2)
                local deviation13 = math.abs(measureResult.accurateArea3 - measureResult.accurateArea1)/
                        ((measureResult.accurateArea3 + measureResult.accurateArea1)/2)
                local deviation24 = math.abs(measureResult.accurateArea4 - measureResult.accurateArea2)/
                        ((measureResult.accurateArea4 + measureResult.accurateArea2)/2)
                local minDeviation = math.min(deviation12, deviation23, deviation34, deviation14, deviation13, deviation24)
                log:debug("deviation12 " .. deviation12 .. ", deviation23 " .. deviation23 .. ", deviation34 " .. deviation34)
                log:debug("deviation14 " .. deviation14 .. ", deviation13 " .. deviation13 .. ", deviation24 " .. deviation24)
                log:debug("minDeviation " .. minDeviation)
                if measureResult.accurateArea1 ~= 0 and
                        measureResult.accurateArea2 ~= 0 and
                        measureResult.accurateArea3 ~= 0 and
                        measureResult.accurateArea4 ~= 0 then
                    local maxValue = math.max(measureResult.accurateArea1,
                            measureResult.accurateArea2,
                            measureResult.accurateArea3,
                            measureResult.accurateArea4)
                    local minValue = math.min(measureResult.accurateArea1,
                            measureResult.accurateArea2,
                            measureResult.accurateArea3,
                            measureResult.accurateArea4)
                    measureResult.peakArea = (measureResult.accurateArea1+measureResult.accurateArea2
                            +measureResult.accurateArea3+measureResult.accurateArea4
                            - maxValue - minValue)/2
                else
                    if minDeviation == deviation12 then
                        measureResult.peakArea = (measureResult.accurateArea2 + measureResult.accurateArea1)/2
                    elseif minDeviation == deviation23 then
                        measureResult.peakArea = (measureResult.accurateArea3 + measureResult.accurateArea2)/2
                    elseif minDeviation == deviation34 then
                        measureResult.peakArea = (measureResult.accurateArea4 + measureResult.accurateArea3)/2
                    elseif  minDeviation == deviation14 then
                        measureResult.peakArea = (measureResult.accurateArea4 + measureResult.accurateArea1)/2
                    elseif  minDeviation == deviation13 then
                        measureResult.peakArea = (measureResult.accurateArea3 + measureResult.accurateArea1)/2
                    elseif  minDeviation == deviation24 then
                        measureResult.peakArea = (measureResult.accurateArea4 + measureResult.accurateArea2)/2
                    end
                end
            end
        end
        log:debug("精准测量： " .. string.format("%.3f", measureResult.accurateArea1) .. ", " .. string.format("%.3f", measureResult.accurateArea2) .. ", " ..
                string.format("%.3f", measureResult.accurateArea3) .. ", " .. string.format("%.3f", measureResult.accurateArea4))
        log:debug("精准模式平均面积： " .. measureResult.peakArea)
        log:debug("精准测量： " .. measureResult.peakArea)
    end
    measureResult.accurateArea1 = 0
    measureResult.accurateArea2 = 0
    measureResult.accurateArea3 = 0
    measureResult.accurateArea4 = 0
    --停止峰形图数据更新
    UpdateWidgetManager.Instance():Update(UpdateEvent.PeakStatusChanged, "Stop")

    --开始更新基线状态
    status.measure.isCheckBaseLine = true
    ConfigLists.SaveMeasureStatus()
end

function Measurer:DrainAfterMeasureIC()
    local startTime = os.time()
    local runAction = Helper.Status.SetAction(setting.runAction.measure.drainAfterMeasure)
    StatusManager.Instance():SetAction(runAction)
    --移动至废液杯
    --op:AutoMove(setting.component.xPos.standardCell, setting.component.zPos.side)
    --排空混匀池
    op:WasteRoomOutStart(config.measureParam.sampleWasteVol)
    --注射器复位
    --op:SyringeReset()
    --停止排空混匀池
    op:WasteRoomOutStop(true)
    --稀释量程
    if Measurer.currentRange > 1 and Measurer.measureType ~= MeasureType.Blank then
        --排空稀释池
        op:DrainFromDiluteRoom(8)
    end

    log:debug("测量后排液时间 = " .. os.time() - startTime);
end

function Measurer:WaitResult()
    local startTime = os.time()
    --设置IC测量标志
    setting.measureResult.isMeasureIC = true

    local reactTime = config.measureParam.addAfterTime
    local restTime = os.time() - Measurer.measureResult.startICMeasureTime
    log:debug("IC restTime: " .. (reactTime - restTime) .. ", done: " .. restTime)

    if restTime < reactTime or setting.measureResult.immediatelyResultHandle == false then
        if not Measurer.flow:Wait((reactTime - restTime)/2) then
            error(UserStopException:new())
        end
        Measurer:CalibrateMeasureEndJudge((reactTime - restTime)/2)
    end
    Measurer:Handle(Measurer.measureResult, ModelType.IC)

    --设置IC测量标志
    setting.measureResult.isMeasureIC = false

    log:debug("反应时间 = " .. os.time() - startTime);
end