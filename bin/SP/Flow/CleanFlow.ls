--[[
 * @brief 清洗类型
--]]
cleanType =
{
    cleanDeeply = 0,     --深度清洗
    cleanAll = 1,       	--清洗所有管路
    oneKeyRenew = 2,      --一键填充试剂
    drainFromRefrigerator = 3,      --排卤素液
}

--[[
 * @brief 清洗流程。
--]]
CleanFlow = Flow:new
{
}

function CleanFlow:new(o, target)
    o = o or {}
    setmetatable(o, self)
    self.__index = self

    o.cleanDateTime = os.time()
    o.cleanType = target
    o.reactTemperature = config.measureParam.reactTemperature
    o.carryingPressure = config.measureParam.carryingPressure

    return o
end

function CleanFlow:GetRuntime()
    local runtime = 0

    if self.cleanType == cleanType.cleanDeeply then
        runtime = setting.runStatus.cleanDeeply.GetTime()
    elseif self.cleanType == cleanType.cleanAll then
        runtime = setting.runStatus.cleanAll.GetTime()
    elseif self.cleanType == cleanType.oneKeyRenew then
        runtime = setting.runStatus.oneKeyRenew.GetTime()
    elseif self.cleanType == cleanType.drainFromRefrigerator then
        runtime = setting.runStatus.drainFromRefrigerator.GetTime()
    end

    return runtime
end

function CleanFlow:OnStart()
    --组合流程需要重新加载时间
    self.measureDateTime = os.time()
    -- 初始化下位机
    dc:GetIDeviceStatus():Initialize()
    -- 初始化液路板
    lc:GetIDeviceStatus():Initialize()

    --检测消解室是否为安全温度
    -- op:CheckDigestSafety()

    --继电器指示
    Helper.Result.RelayOutOperate(setting.mode.relayOut.cleanInstruct, true)

    --设置运行状态
    local runStatus = Helper.Status.SetStatus(setting.runStatus.cleanDeeply)
    if self.cleanType == cleanType.cleanDeeply then
        runStatus = Helper.Status.SetStatus(setting.runStatus.cleanDeeply)
    elseif self.cleanType == cleanType.cleanAll then
        runStatus = Helper.Status.SetStatus(setting.runStatus.cleanAll)
    elseif self.cleanType == cleanType.oneKeyRenew then
        runStatus = Helper.Status.SetStatus(setting.runStatus.oneKeyRenew)
    elseif self.cleanType == cleanType.drainFromRefrigerator then
        runStatus = Helper.Status.SetStatus(setting.runStatus.drainFromRefrigerator)
    end
    StatusManager.Instance():SetStatus(runStatus)
end

function CleanFlow:OnProcess()
    self.isUserStop = false
    self.isFinish = false

    --清洗流程执行
    local err,result = pcall
    (
        function()
            if self.cleanType == cleanType.cleanDeeply then
                return self:CleanDeeply()
            elseif self.cleanType == cleanType.cleanAll then
                return self:CleanAll()
            elseif self.cleanType == cleanType.oneKeyRenew then
                return self:OneKeyRenew()
            elseif self.cleanType == cleanType.drainFromRefrigerator then
                return self:DrainFromRefrigerator()
            end
        end
    )
    if not err then      -- 出现异常
        if type(result) == "table" then
            if getmetatable(result) == PumpStoppedException then 			--泵操作被停止异常。
                self.isUserStop = true
                error(result)
            elseif getmetatable(result)== MeterStoppedException then			--定量被停止异常。
                self.isUserStop = true
                error(result)
            elseif getmetatable(result) == ThermostatStoppedException then  	--恒温被停止异常。
                self.isUserStop = true
                error(result)
            elseif getmetatable(result)== UserStopException then 				--用户停止测量流程
                self.isUserStop = true
                error(result)
	        else
	    	    error(result)
            end
        else
            error(result)
        end
    end

    self.isFinish = true
end

function CleanFlow:OnStop()

    --继电器指示
    Helper.Result.RelayOutOperate(setting.mode.relayOut.cleanInstruct, false)

    if self.cleanType == cleanType.cleanDeeply then
        status.measure.schedule.autoClean.dateTime = self.cleanDateTime

        ConfigLists.SaveMeasureStatus()
    elseif self.cleanType == cleanType.drainFromRefrigerator then
        status.measure.schedule.autoDrainFromRefrigerator.dateTime = self.cleanDateTime

        ConfigLists.SaveMeasureStatus()
    end

    if setting.sensor.isValid == true then
        op:SlidersSensorCheck()
    end

    -- 初始化下位机
    dc:GetIDeviceStatus():Initialize()
    -- 初始化液路板
    lc:GetIDeviceStatus():Initialize()
    --关闭氮气气路
    op:TurnOffNirtrogen(setting.pressure.delayTime)
    --关闭曝气
    op:ExposureTurnOff()
    --关LED
    dc:GetIOpticalAcquire():TurnOffLED(setting.LED.LMeaIndex)
    dc:GetIOpticalAcquire():TurnOffLED(setting.LED.SMeaIndex)	--关LED
    if not self.isFinish then
        if self.isUserStop then
            self.result = "用户终止"
            log:info("用户终止")
        else
            self.result = "故障终止"
            log:warn("故障终止")
        end
    else
        if self.cleanType == cleanType.drainFromRefrigerator then
            self.result = "气体置换完成"
            log:info("气体置换完成")
            log:info("气体置换流程总时间 = "..os.time()-self.cleanDateTime)
        else
            self.result = "清洗完成"
            log:info("清洗完成")
            log:info("清洗流程总时间 = "..os.time()-self.cleanDateTime)
        end
    end

    --保存试剂余量表
    ReagentRemainManager.SaveRemainStatus()

    --检测消解室是否为安全温度
    op:CheckDigestSafety()

end

--[[
 * @brief 深度清洗流程
--]]
function CleanFlow:CleanDeeply(flow)
    if nil ~= flow then
        self = flow
    end
    local runAction = Helper.Status.SetAction(setting.runAction.cleanDeeply)
    StatusManager.Instance():SetAction(runAction)

    while true do
         op:AC30Test()
        -- if not self:Wait(1) then
        --   error(UserStopException:new())
        -- end
        App.Sleep(1000);
    end

    -- --机械臂复位
    -- op:ManipulatorReset()
    -- --移动至废液杯
    -- op:AutoMove(setting.component.xPos.standardCell, setting.component.zPos.side)
    -- --注射器复位排空
    -- op:SyringeReset()

    -- --排空混匀池
    -- op:WasteRoomOutStart()

    -- --排空稀释池
    -- op:DrainFromDiluteRoom(5)

    -- --排空IC池 && 打开曝气
    -- op:DrainFromICRoom(5)

    -- --停止排空混匀池
    -- op:WasteRoomOutStop()

    -- --关闭曝气
    -- op:ExposureTurnOn()

    -- --使能总阀曝气阀常开
    -- local map = ValveMap.new(setting.liquidType.master.valve | setting.liquidType.exposureDilute.valve)
    -- dc:GetISolenoidValve():SetValveMapNormalOpen(map)

    -- --移动至稀释杯
    -- op:AutoMove(setting.component.xPos.diluteCell, setting.component.zPos.side)
    -- --注射器清洗 5ml
    -- op:SyringeUpdate(2)

    -- --使能总阀曝气阀常开
    -- map = ValveMap.new(setting.liquidType.master.valve | setting.liquidType.exposureIC.valve)
    -- dc:GetISolenoidValve():SetValveMapNormalOpen(map)

    -- --移动至IC池
    -- op:AutoMove(setting.component.xPos.exposureCell, setting.component.zPos.side)
    -- --注射器清洗 5ml
    -- op:SyringeUpdate(2)

    -- local map = ValveMap.new(setting.liquidType.master.valve | setting.liquidType.exposureSampleMixer.valve)
    -- dc:GetISolenoidValve():SetValveMapNormalOpen(map)

    -- --移动至水样杯
    -- op:AutoMove(setting.component.xPos.sampleMixer, setting.component.zPos.side)
    -- --注射器清洗 25ml
    -- op:SyringeUpdate(4)

    -- --关闭常开阀
    -- local map = ValveMap.new(setting.liquidType.none.valve)
    -- dc:GetISolenoidValve():SetValveMapNormalOpen(map)

    -- --关闭曝气
    -- op:ExposureTurnOff()

    -- --排空混匀池
    -- op:WasteRoomOutStart(nil)

    -- --排空稀释池
    -- op:DrainFromDiluteRoom(5)

    -- --排空IC池 && 打开曝气
    -- op:DrainFromICRoom(5, 0.8)

    -- --停止排空混匀池
    -- op:WasteRoomOutStop()

    -- ----开启均质器
    -- --op:StirOn()
    -- --if not self:Wait(30) then
    -- --    error(UserStopException:new())
    -- --end
    -- ----关闭均质器
    -- --op:StirOff()


    self.isFinish = true

    return true
end

--[[
 * @brief 清洗所有管路
--]]
function CleanFlow:CleanAll()
    --local runAction
    ---- 清洗消解室(包含排空定量管和消解室)
    --runAction = Helper.Status.SetAction(setting.runAction.cleanAll.cleanDigestionRoom)
    --StatusManager.Instance():SetAction(runAction)
    ---- 排空水样管
    --runAction = Helper.Status.SetAction(setting.runAction.cleanAll.drainSamplePipe)
    --StatusManager.Instance():SetAction(runAction)
    --op:Drain(setting.liquidType.sample, setting.liquid.samplePipeVolume + config.measureParam.extendSamplePipeVolume, 0)
    --
    ---- 排空量程校准液管
    --runAction = Helper.Status.SetAction(setting.runAction.cleanAll.drainStandardPipe)
    --StatusManager.Instance():SetAction(runAction)
    --op:Drain(setting.liquidType.standard, setting.liquid.standardPipeVolume, 0)
    --
    ----开启扩展功能
    ----if config.system.targetMap.EXTEND.enable == true then
    --     --排空零点核查液管
    --runAction = Helper.Status.SetAction(setting.runAction.cleanAll.drainZeroCheckPipe)
    --StatusManager.Instance():SetAction(runAction)
    --op:Drain(setting.liquidType.zeroCheck, setting.liquid.zeroCheckPipeVolume, 0)
    --
    -- --排空量程核查液管
    --runAction = Helper.Status.SetAction(setting.runAction.cleanAll.drainRangeCheckPipe)
    --StatusManager.Instance():SetAction(runAction)
    --op:Drain(setting.liquidType.rangeCheck, setting.liquid.rangeCheckPipeVolume, 0)
    ----end
    --
    ---- 排空试剂一管
    --runAction = Helper.Status.SetAction(setting.runAction.cleanAll.drainReagent1Pipe)
    --StatusManager.Instance():SetAction(runAction)
    --op:Drain(setting.liquidType.reagent1, setting.liquid.reagent1PipeVolume, 0)
    --
    ---- 清洗水样管
    --runAction = Helper.Status.SetAction(setting.runAction.cleanAll.cleanSamplePipe)
    --StatusManager.Instance():SetAction(runAction)
    --op:Drain(setting.liquidType.sample, setting.liquid.samplePipeVolume + config.measureParam.extendSamplePipeVolume, 0)
    --
    ---- 清洗量程校准液管
    --runAction = Helper.Status.SetAction(setting.runAction.cleanAll.cleanStandardPipe)
    --StatusManager.Instance():SetAction(runAction)
    --op:Drain(setting.liquidType.standard, setting.liquid.standardPipeVolume, 0)
    --
    ------开启扩展功能
    ----if config.system.targetMap.EXTEND.enable == true then
    ---- 清洗零点核查液管
    --runAction = Helper.Status.SetAction(setting.runAction.cleanAll.cleanZeroCheckPipe)
    --StatusManager.Instance():SetAction(runAction)
    --op:Drain(setting.liquidType.zeroCheck, setting.liquid.zeroCheckPipeVolume, 0)
    --
    ---- 清洗量程核查液管
    --runAction = Helper.Status.SetAction(setting.runAction.cleanAll.cleanRangeCheckPipe)
    --StatusManager.Instance():SetAction(runAction)
    --op:Drain(setting.liquidType.rangeCheck, setting.liquid.rangeCheckPipeVolume, 0)
    ----end
    --
    ---- 清洗试剂一管
    --runAction = Helper.Status.SetAction(setting.runAction.cleanAll.cleanReagent1Pipe)
    --StatusManager.Instance():SetAction(runAction)
    --op:Drain(setting.liquidType.reagent1, setting.liquid.reagent1PipeVolume, 0)
    --
    ---- 排空零点校准液管
    --runAction = Helper.Status.SetAction(setting.runAction.cleanAll.drainBlankPipe)
    --StatusManager.Instance():SetAction(runAction)
    --op:Drain(setting.liquidType.blank, setting.liquid.blankPipeVolume, 0)
    --
    ---- 排空废液管
    --runAction = Helper.Status.SetAction(setting.runAction.cleanAll.drainWastePipe)
    --StatusManager.Instance():SetAction(runAction)
    --op:DrainToWaste(0)
    --
    ---- 排空废水管
    --runAction = Helper.Status.SetAction(setting.runAction.cleanAll.drainWastePipe)
    --StatusManager.Instance():SetAction(runAction)
    --op:DrainToWaste(0)


    self.isFinish = true

    return true
end

--[[
 * @brief 一键管路更新
--]]
function CleanFlow:OneKeyRenew()

    --local runAction
    --
	---- 清空残留液
	--runAction = Helper.Status.SetAction(setting.runAction.oneKeyMaintain.clearWaste)
	--StatusManager.Instance():SetAction(runAction)
	--op:DrainToWaste(setting.liquid.meterPipeVolume)
	---- 清空试剂一管
	--runAction = Helper.Status.SetAction(setting.runAction.oneKeyMaintain.clearReagent1Pipe)
	--StatusManager.Instance():SetAction(runAction)
	--
	---- 清空量程校准液管
	--runAction = Helper.Status.SetAction(setting.runAction.oneKeyMaintain.clearStandardPipe)
	--StatusManager.Instance():SetAction(runAction)
	--
	---- 清空零点校准液管
	--runAction = Helper.Status.SetAction(setting.runAction.oneKeyMaintain.clearBlankPipe)
	--StatusManager.Instance():SetAction(runAction)
    --
    ---- 清空量程核查管
    --runAction = Helper.Status.SetAction(setting.runAction.oneKeyMaintain.clearRangeCheckPipe)
    --StatusManager.Instance():SetAction(runAction)
    --
    ---- 清空零点核查管
    --runAction = Helper.Status.SetAction(setting.runAction.oneKeyMaintain.clearZeroCheckPipe)
    --StatusManager.Instance():SetAction(runAction)


end

--[[
 * @brief 排冷凝液
--]]
function CleanFlow:DrainFromRefrigerator()
    ----打开氮气气路
    --op:TurnOnNirtrogen()

    --开LED
    dc:GetIOpticalAcquire():TurnOnLED(setting.LED.SMeaIndex)
    --开LED
    dc:GetIOpticalAcquire():TurnOnLED(setting.LED.LMeaIndex)

    --使能总阀曝气阀常开
    local map = ValveMap.new(setting.liquidType.airLED.valve | setting.liquidType.master.valve)
    dc:GetISolenoidValve():SetValveMapNormalOpen(map)
    --打开曝气
    op:ExposureTurnOn()

    if not self:Wait(120) then
        error(UserStopException:new())
    end

    --op:DrainFromRefrigerator()

end
