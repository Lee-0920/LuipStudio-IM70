
setting.runAction =
{
    collectSample =
    {
        collect =
        {
            name = "Collect",
            text = "采集",
            GetTime = function()
                return config.interconnection.miningWaterTime
            end,
        },
        silent =
        {
            name = "Silent",
            text = "静置",
            GetTime = function()
                return config.interconnection.silentTime
            end,
        },
    },
    refrigeratorSafetyCheck =
    {
        name = "Cooling",
        text = "制冷器冷却",
        GetTime = function()   -- 消解器冷却时间，单位为秒
            return 60
        end,
    },
    digestCooling =
    {
        name = "Cooling",
        text = "燃烧炉冷却",
        GetTime = function()   -- 消解器冷却时间，单位为秒
            return 600
        end,
    },
    digestHeating =
    {
        name = "Heating",
        text = "燃烧炉升温",
        GetTime = function()   -- 消解器冷却时间，单位为秒
            return 600
        end,
    },
    measure =
    {
        machineReset =
        {
            name = "MachineReset",
            text = "仪器复位",
            GetTime = function()    -- 测量前排液时间，单位为秒
                return 80
            end,
        },
        airFlowCheck =
        {
            name = "AirFlowCheck",
            text = "检测载气",
            GetTime = function()    -- 等待载气时间，单位为秒
                return 60
            end,
        },
        drainBeforeMeasure =
        {
            name = "DrainBeforeMeasure",
            text = "测量前排液",
            GetTime = function()    -- 测量前排液时间，单位为秒
                return 40
            end,
        },
        cleanBeforeMeasure =
        {
            name = "CleanBeforeMeasure",
            text = "测量前清洗",
            GetTime = function()    -- 测量前清洗时间，单位为秒
                return config.measureParam.cleanBefMeaBlankVol * 60
            end,
        },
        rinse =
        {
            name = "Rinse",
            text = "润洗",
            GetTime = function()
                local totalTime = 30
                totalTime = totalTime + (config.measureParam.sampleRenewVolume * 10)
                return totalTime -- 润洗时间，单位为秒
            end,
        },
        addSample =
        {
            name = "AddSample",
            text = "加待测样",
            GetTime = function()
                local totalTime = 70
                if true == config.measureParam.wasteWaterEnvironment then   -- 抗污模式
                    totalTime = 100
                end
                if config.measureParam.range[config.measureParam.currentRange + 1] == 1 then
                    totalTime = totalTime
                elseif config.measureParam.range[config.measureParam.currentRange + 1] == 2 then
                    totalTime = totalTime + 50
                elseif config.measureParam.range[config.measureParam.currentRange + 1] == 3 then
                    totalTime = totalTime + 200
                elseif config.measureParam.range[config.measureParam.currentRange + 1] == 4 then
                    totalTime = totalTime + 80
                elseif config.measureParam.range[config.measureParam.currentRange + 1] == 5 then
                    totalTime = totalTime + 310
                    if true == config.measureParam.wasteWaterEnvironment then   -- 抗污模式
                        totalTime = totalTime + 60
                    end
                elseif config.measureParam.range[config.measureParam.currentRange + 1] == 6 then
                    totalTime = totalTime + 240
                elseif config.measureParam.range[config.measureParam.currentRange + 1] == 7 then
                    totalTime = totalTime + 320
                end
                return totalTime -- 加待测样时间，单位为秒
            end,
        },
        sampleSupply =
        {
            name = "SampleSupply",
            text = "供样",
            GetTime = function()
                local totalTime = 60
                totalTime = totalTime + (config.measureParam.sampleRenewVolume * 10)
                return totalTime -- 润洗时间，单位为秒
            end,
        },
        addReagent1 =
        {
            name = "AddReagent1",
            text = "加试剂一",
            GetTime = function()
                return 25			-- 加试剂一时间，单位为秒
            end,
        },
        preheating =
        {
            name = "Preheating",
            text = "消解液预热",
            GetTime = function()
                return 60			-- 试剂一反应时间，单位为秒
            end,
        },
        addReagent2 =
        {
            name = "AddReagent2",
            text = "加试剂二",
            GetTime = function()
                return 240			-- 加试剂二时间，单位为秒
            end,
        },
        digest =
        {
            name = "Digest",
            text = "消解加热",
            GetTime = function()
                return config.measureParam.digestTime + 180 -- 消解时间 +  加热时间
            end,
        },
        digestCooling =
        {
            name = "DigestCooling",
            text = "消解冷却",
            GetTime = function()
                return 400				-- 消解冷却时间，单位为秒
            end,
        },
        readMeasureAD =
        {
            name = "ReadMeasureAD",
            text = "读反应值",
            GetTime = function()
                return 12			-- 读测量值时间，单位为秒
            end,
        },
        drainAfterMeasure =
        {
            name = "DrainAfterMeasure",
            text = "测量后排液",
            GetTime = function()
                return 100	-- 测量后排液时间，单位为秒
            end,
        },
        cleanAfterMeasure =
        {
            name = "CleanAfterMeasure",
            text = "测量后清洗",
            GetTime = function()
                local time = 180
                if config.measureParam.range[config.measureParam.currentRange + 1] + 1 == 2 then
                    time = time + 30
                elseif config.measureParam.range[config.measureParam.currentRange + 1] + 1 == 3 then
                    time = time + 30
                elseif config.measureParam.range[config.measureParam.currentRange + 1] + 1 == 4 then
                    time = time + 30
                elseif config.measureParam.range[config.measureParam.currentRange + 1] + 1 == 5 then
                    time = time + 60
                end
                if true == config.measureParam.wasteWaterEnvironment then   -- 抗污模式
                    time = time + 160
                end
                return time	-- 测量后清洗时间，单位为秒
            end,
        },
        readInitialAD =
        {
            name = "ReadInitialAD",
            text = "读初始值",
            GetTime = function()
                return 80 + config.measureParam.readInitRilentTime  -- 读初始值时间，单位为秒
            end,
        },
        exposureNirtrogen =
        {
            name = "ExposureNirtrogen",
            text = "曝气",
            GetTime = function()
                return config.measureParam.exposureTime  -- 读初始值时间，单位为秒
            end,
        },
        reactTime =
        {
            name = "ReactTime",
            text = "测量反应",
            GetTime = function()
                return 15 + config.measureParam.addSampleCnt * config.measureParam.addSampleMidtime  -- 读反应值时间，单位为秒
            end,
        },
        updateTime =
        {
            name = "UpdateTime",
            text = "管路更新",
            GetTime = function()
                return 50  -- 读反应值时间，单位为秒
            end,
        },
        addSampleTime =
        {
            name = "AddSampleTime",
            text = "加样",
            GetTime = function()
                return 70   -- 读反应值时间，单位为秒
            end,
        },
        baseLineCheck =
        {
            name = "BaseLineCheck",
            text = "加样等待",
            GetTime = function()
                return 120  -- 读反应值时间，单位为秒
            end,
        },
        accurateMeasureMode =
        {
            name = "AccurateMeasureMode",
            text = "精准测量",
            GetTime = function()
                return 120  -- 读反应值时间，单位为秒
            end,
        },
        waittingResult =
        {
            name = "WaittingResult",
            text = "等待测量结果",
            GetTime = function()
                local runTime = setting.runAction.measure.cleanAfterMeasure.GetTime()
                return config.measureParam.addAfterTime - runTime  -- 读反应值时间，单位为秒
            end,
        },
    },
    oneKeyMaintain =
    {
        clearWaste =
        {
            name = "ClearWaste",
            text = "清空残留液",
            GetTime = function()
                return 150
            end,
        },
        clearReagent1Pipe =
        {
            name = "ClearReagent1Pipe",
            text = "清空试剂一管",
            GetTime = function()
                return 40
            end,
        },
        clearStandardPipe =
        {
            name = "ClearStandardPipe",
            text = "清空量程校准液管",
            GetTime = function()
                return 40
            end,
        },
        clearReagent2Pipe =
        {
            name = "ClearReagent2Pipe",
            text = "清空试剂二管",
            GetTime = function()
                return 40
            end,
        },
        clearBlankPipe =
        {
            name = "ClearBlankPipe",
            text = "清空零点校准液管",
            GetTime = function()
                return 40
            end,
        },
        clearZeroCheckPipe =
        {
            name = "ClearZeroCheckPipe",
            text = "清空零点核查液管",
            GetTime = function()
                return 40
            end,
        },
        clearRangeCheckPipe =
        {
            name = "ClearRangeCheckPipe",
            text = "清空标样(跨度)核查液管",
            GetTime = function()
                return 40
            end,
        },
    },
    cleanDigestionRoom =
    {
        name = "Clean",
        text = "清洗",
        GetTime = function()    -- 清洗消解室流程总时间，单位为秒
            return 100
        end,
    },
    cleanDeeply =
    {
        name = "Clean",
        text = "清洗",
        GetTime = function()    -- 深度清洗流程总时间，单位为秒
            return 880
        end,
    },
    cleanAll =
    {
        cleanDigestionRoom =
        {
            name = "CleanDigestionRoom",
            text = "清洗逐出室",
            GetTime = function()
                return 100
            end,
        },
        cleanSamplePipe =
        {
            name = "CleanSamplePipe",
            text = "清洗水样管",
            GetTime = function()
                return 40
            end,
        },
        cleanStandardPipe =
        {
            name = "CleanStandardPipe",
            text = "清洗量程校准液管",
            GetTime = function()
                return 40
            end,
        },
        cleanReagent1Pipe =
        {
            name = "CleanReagent1Pipe",
            text = "清洗试剂一管",
            GetTime = function()
                return 40
            end,
        },
        cleanReagent2Pipe =
        {
            name = "CleanReagent2Pipe",
            text = "清洗试剂二管",
            GetTime = function()
                return 40
            end,
        },
        cleanBlankPipe =
        {
            name = "CleanBlankPipe",
            text = "清洗零点校准液管",
            GetTime = function()
                return 40
            end,
        },
        cleanZeroCheckPipe =
        {
            name = "CleanZeroCheckPipe",
            text = "清洗零点核查液管",
            GetTime = function()
                return 40
            end,
        },
        cleanRangeCheckPipe =
        {
            name = "CleanRangeCheckPipe",
            text = "清洗标样(跨度)核查液管",
            GetTime = function()
                return 40
            end,
        },
        drainSamplePipe =
        {
            name = "DrainSamplePipe",
            text = "排空水样管",
            GetTime = function()
                return 20
            end,
        },
        drainStandardPipe =
        {
            name = "DrainStandardPipe",
            text = "排空量程校准液管",
            GetTime = function()
                return 20
            end,
        },
        drainReagent1Pipe =
        {
            name = "DrainReagent1Pipe",
            text = "排空试剂一管",
            GetTime = function()
                return 20
            end,
        },
        drainReagent2Pipe =
        {
            name = "DrainReagent2Pipe",
            text = "排空试剂二管",
            GetTime = function()
                return 20
            end,
        },
        drainBlankPipe =
        {
            name = "DrainBlankPipe",
            text = "排空零点校准液管",
            GetTime = function()
                return 20
            end,
        },
        drainZeroCheckPipe =
        {
            name = "DrainZeroCheckPipe",
            text = "排空零点核查液管",
            GetTime = function()
                return 20
            end,
        },
        drainRangeCheckPipe =
        {
            name = "DrainRangeCheckPipe",
            text = "排空标样(跨度)核查液管",
            GetTime = function()
                return 20
            end,
        },
        drainWastePipe =
        {
            name = "DrainWastePipe",
            text = "排空分析废液管",
            GetTime = function()
                return 20
            end,
        },
        drainWasteWaterPipe =
        {
            name = "DrainWasteWaterPipe",
            text = "排空清洗废水管",
            GetTime = function()
                return 20
            end,
        },
    },
    autoPumpCheck =
    {
        name = "AutoPumpCheck",
        text = "定量泵校准",
        GetTime = function()    -- 定量泵校准总时间，单位为秒
            return 180
        end,
    },
    catalystRelife =
    {
        slidersIn =
        {
            name = "SlidersIn",
            text = "滑块进样",
            GetTime = function()
                return 4
            end,
        },
        slidersOut =
        {
            name = "SlidersOut",
            text = "滑块复位",
            GetTime = function()
                return 4
            end,
        },
        silentTime =
        {
            name = "SilentTime",
            text = "静置",
            GetTime = function()
                return 20
            end,
        },
        addReagent1 =
        {
            name = "addReagent1",
            text = "加试剂一",
            GetTime = function()
                return 20
            end,
        },
    },
    DCCommunication =
    {
        name = "DCCommunicationCheck",
        text = "驱动板检测",
    },
    LCCommunication =
    {
        name = "LCCommunicationCheck",
        text = "液路板检测",
    },
    smartCoolDetect =
    {
        name = "SmartCoolDetect",
        text = "冷却模块诊断",
    },
    smartHeatDetect =
    {
        name = "SmartHeatDetect",
        text = "加热模块诊断",
    },
    smartMeasureDetect =
    {
        name = "SmartMeasureDetect",
        text = "测量模块诊断",
    },
    smartMeterDetect =
    {
        name = "SmartMeterDetect",
        text = "定量模块诊断",
    },
    smartBlankValveDetect =
    {
        name = "SmartBlankValveDetect",
        text = "零点校准液阀诊断",
    },
    smartSampleValveDetect =
    {
        name = "SmartSampleValveDetect",
        text = "水样阀诊断",
    },
    smartStandardValveDetect =
    {
        name = "SmartStandardValveDetect",
        text = "量程校准液阀诊断",
    },
    smartZeroCheckValveDetect =
    {
        name = "SmartZeroCheckValveDetect",
        text = "零点核查液阀诊断",
    },
    smartRangeCheckValveDetect =
    {
        name = "SmartRangeCheckValveDetect",
        text = "标样(跨度)核查液阀诊断",
    },
    smartReagent1ValveDetect =
    {
        name = "SmartReagent1ValveDetect",
        text = "试剂一阀诊断",
    },
    smartReagent2ValveDetect =
    {
        name = "SmartReagent2ValveDetect",
        text = "试剂二阀诊断",
    },
    smartDigestionRoomValveDetect =
    {
        name = "SmartDigestionRoomValveDetect",
        text = "逐出室阀诊断",
    },
    smartWasteValveDetect =
    {
        name = "SmartWasteValveDetect",
        text = "分析废液阀诊断",
    },
    smartWasteWaterValveDetect =
    {
        name = "SmartWasteWaterValveDetect",
        text = "清洗废水阀诊断",
    },
    suckFromBlank =
    {
        name = "SuckFromBlank",
        text = "填充零点校准液",
    },
    drainToBlank =
    {
        name = "DrainToBlank",
        text = "排至零点校准液管",
    },
    suckFromSample =
    {
        name = "SuckFromSample",
        text = "填充水样",
    },
    drainToSample =
    {
        name = "DrainToSample",
        text = "排至水样管",
    },
    suckFromSample1 =
    {
        name = "SuckFromSample1",
        text = "填充通道一",
    },
    drainToSample1 =
    {
        name = "DrainToSample1",
        text = "排至通道一",
    },
    suckFromSample2 =
    {
        name = "SuckFromSample2",
        text = "填充通道二",
    },
    drainToSample2 =
    {
        name = "DrainToSample2",
        text = "排至通道二",
    },
    suckFromSample3 =
    {
        name = "SuckFromSample3",
        text = "填充通道三",
    },
    drainToSample3 =
    {
        name = "DrainToSample3",
        text = "排至通道三",
    },
    suckFromSample4 =
    {
        name = "SuckFromSample4",
        text = "填充通道四",
    },
    drainToSample4 =
    {
        name = "DrainToSample4",
        text = "排至通道四",
    },
    suckFromSample5 =
    {
        name = "SuckFromSample5",
        text = "填充通道五",
    },
    drainToSample5 =
    {
        name = "DrainToSample5",
        text = "排至通道五",
    },
    suckFromSample6 =
    {
        name = "SuckFromSample6",
        text = "填充通道六",
    },
    drainToSample6 =
    {
        name = "DrainToSample6",
        text = "排至通道六",
    },
    suckFromStandard =
    {
        name = "SuckFromStandard",
        text = "填充量程校准液",
    },
    drainToStandard =
    {
        name = "DrainToStandard",
        text = "排至量程校准液管",
    },

    suckFromZeroCheck =
    {
        name = "SuckFromZeroCheck",
        text = "填充零点核查液",
    },
    drainToZeroCheck =
    {
        name = "DrainToZeroCheck",
        text = "排至零点核查液管",
    },
    suckFromRangeCheck =
    {
        name = "SuckFromRangeCheck",
        text = "填充标样(跨度)核查液",
    },
    drainToRangeCheck =
    {
        name = "DrainToRangeCheck",
        text = "排至标样(跨度)核查液管",
    },
    suckFromReagent1 =
    {
        name = "SuckFromReagent1",
        text = "填充试剂1",
    },
    suckFromReagent1ToMixer =
    {
        name = "SuckFromReagent1ToMixer",
        text = "填充试剂1至水样杯",
    },
    suckFromReagent1ToExposure =
    {
        name = "SuckFromReagent1ToExposure",
        text = "填充试剂1至曝气池",
    },
    drainToReagent1 =
    {
        name = "DrainToReagent1",
        text = "排至试剂1管",
    },
    suckFromReagent2 =
    {
        name = "SuckFromReagent2",
        text = "填充试剂2",
    },
    drainToReagent2 =
    {
        name = "DrainToReagent2",
        text = "排至试剂2管",
    },
    suckFromReagent2Spare =
    {
        name = "SuckFromReagent2Spare",
        text = "填充试剂2(备用)",
    },
    drainToReagent2Spare =
    {
        name = "DrainToReagent2Spare",
        text = "排至试剂2管(备用)",
    },
    suckFromDigestionRoom =
    {
        name = "SuckFromDigestionRoom",
        text = "吸逐出室溶液",
    },
    drainToDigestionRoom =
    {
        name = "DrainToDigestionRoom",
        text = "排至逐出室",
    },
    drainToWaste =
    {
        name = "DrainToWaste",
        text = "排至分析废液",
    },
    drainToWasteWater =
    {
        name = "DrainToWasteWater",
        text = "排至清洗废水",
    },
    suckBlankToDigestionRoom =
    {
        name = "SuckBlankToDigestionRoom",
        text= "吸零点校准液至逐出室",
    },
    suckDigestionRoomToWaste =
    {
        name = "SuckDigestionRoomToWaste",
        text= "排逐出液至分析废液",
    },
    suckDigestionRoomToWasteWater =
    {
        name = "SuckDigestionRoomToWasteWater",
        text= "排逐出液至清洗废水",
    },
    gasSealCheck =
    {
        name = "GasSealCheck",
        text = "气密性检查",
    },
    oneKeyHeating =
    {
        name = "OneKeyHeating",
        text = "一键加热",
    },
    sliderForwardCalibrate =
    {
        name = "SliderForwardCalibrate",
        text = "滑块前进校准",
        GetTime = function()    -- 定量AD调节总时间，单位为秒
            return 20
        end,
    },
    sliderBackWardCalibrate =
    {
        name = "SliderForwardCalibrate",
        text = "滑块后退校准",
        GetTime = function()    -- 定量AD调节总时间，单位为秒
            return 20
        end,
    },
    meterADAdjust =
    {
        name = "MeterADAdjust",
        text = "定量AD调节",
        GetTime = function()    -- 定量AD调节总时间，单位为秒
            return 80
        end,
    },
    measureADAdjust =
    {
        name = "MeasureADAdjust",
        text = "测量模块调节",
        GetTime = function()    -- 测量AD调节总时间，单位为秒
            return 280
        end,
    },
    drainFromRefrigerator =
    {
        name = "DrainFromRefrigerator",
        text = "排冷凝液",
        GetTime = function()    -- 测量AD调节总时间，单位为秒
            return 60
        end,
    },
    suckRefrigeratorWater =
    {
        name = "SuckRefrigeratorWater",
        text = "排冷凝液",
        GetTime = function()    -- 测量AD调节总时间，单位为秒
            return 30
        end,
    },
    syringUpdate =
    {
        name = "SyringeUpdate",
        text = "注射器更新",
        GetTime = function()
            return 60
        end,
    },
    syringTest =
    {
        name = "SyringTest",
        text = "注射器测试",
        GetTime = function()
            return 60
        end,
    },
    masterUpdate =
    {
        name = "Updater",
        text = "升级中",
    },
    erase =
    {
        name = "Erase",
        text = "擦除",
    },
    writeProgram =
    {
        name = "WriteProgram",
        text = "烧写",
    },
    hardwareTest =
    {
        pumpTest =
        {
            name = "PumpTest",
            text = "泵测试",
        },
        sampleValveTest =
        {
            name = "SampleValveTest",
            text = "水样阀测试",
        },
        reagent1ValveTest =
        {
            name = "Reagent1ValveTest",
            text = "试剂一阀测试",
        },
        reagent2ValveTest =
        {
            name = "Reagent2ValveTest",
            text = "试剂二阀测试",
        },
        standardValveTest =
        {
            name = "StandardValveTest",
            text = "量程校准液阀测试",
        },
        zeroCheckkValveTest =
        {
            name = "ZeroCheckkValveTest",
            text = "零点核查液阀测试",
        },
        rangeCheckValveTest =
        {
            name = "RangeCheckValveTest",
            text = "标样(跨度)核查液阀测试",
        },
        blankValveTest =
        {
            name = "BlankValveTest",
            text = "零点校准液阀测试",
        },
        wasteValveTest =
        {
            name = "WasteValveTest",
            text = "分析废液阀测试",
        },
        wasteWaterValveTest =
        {
            name = "WasteWaterValveTest",
            text = "清洗废水阀测试",
        },
        digestUpValveTest =
        {
            name = "DigestUpValveTest",
            text = "消解上阀测试",
        },
        digestBottomValveTest =
        {
            name = "DigestBottomValveTest",
            text = "消解下阀测试",
        },
        heaterTest =
        {
            name = "HeaterTest",
            text = "消解加热测试",
        },
        coolerTest =
        {
            name = "CoolerTest",
            text = "消解冷却测试",
        },
        measuerLEDTest =
        {
            name = "MeasuerLEDTest",
            text = "测量LED",
        },
        meter1LEDTest =
        {
            name = "Meter1LEDTest",
            text = "定量点一LED",
        },
        meter2LEDTest =
        {
            name = "Meter2LEDTest",
            text = "定量点二LED",
        },
        collectSampleRelayTest =
        {
            name = "CollectSampleRelayTest",
            text = "采水继电器",
        },
        relay1Test =
        {
            name = "Relay1Test",
            text = "继电器1",
        },
        relay2Test =
        {
            name = "Relay2Test",
            text = "继电器2",
        },
        sampleCurrent4Output =
        {
            name = "SampleCurrent4Output",
            text = "样品4mA输出",
        },
        sampleCurrent12Output =
        {
            name = "SampleCurrent12Output",
            text = "样品12mA输出",
        },
        sampleCurrent20Output =
        {
            name = "SampleCurrent20Output",
            text = "样品20mA输出",
        },
        systemFanTest =
        {
            name = "SystemFanTest",
            text = "机箱冷却",
        },
    },
    motorOperate =
    {
        moveToZero =
        {
            name = "MoveToZero",
            text = "移动至原点",
        },
        moveToStoveCell =
        {
            name = "SoveToStoveCell",
            text = "移动至燃烧炉",
        },
        moveToExposureCell =
        {
            name = "MoveToExposureCell",
            text = "移动至曝气池",
        },
        moveToSampleMixer =
        {
            name = "MoveToSampleMixer",
            text = "移动至水样杯",
        },
        moveToBacteriaMixer =
        {
            name = "MoveToBacteriaMixer",
            text = "移动至发光菌混合槽",
        },
        moveToBacteriaCell =
        {
            name = "MoveToBacteriaCell",
            text = "移动至发光菌存储槽",
        },
        moveToBlankCell =
        {
            name = "MoveToBlankCell",
            text = "移动至空白水存储槽",
        },
        moveToSampleCell =
        {
            name = "MoveToSampleCell",
            text = "移动至水样存储槽",
        },
        moveToStandardCell =
        {
            name = "MoveToStandardCell",
            text = "移动至标样存储槽",
        },
        moveToSaltCell =
        {
            name = "MoveToSaltCell",
            text = "移动至渗透压调节液槽",
        },
        moveToCleanCell =
        {
            name = "MoveToCleanCell",
            text = "移动至针清洗槽",
        },
        moveToWasteCell =
        {
            name = "MoveToWasteCell",
            text = "移动至针排液槽",
        },
    },
    suckFromWash =
    {
        name = "SuckFromWash",
        text = "针管路加清洗水",
    },
    airToNeedlePipe =
    {
        name = "AirToNeedlePipe",
        text = "针管路吹气",
    },
    drainToWasteSample =
    {
        name = "DrainToWasteSample",
        text = "排空水样杯",
    },
    drainToWasteExposure =
    {
        name = "DrainToWasteExposure",
        text = "排空曝气池",
    },
    drainToWasteDilute =
    {
        name = "DrainToWasteDilute",
        text = "排空稀释杯",
    },
    drainToWasteOut =
    {
        name = "DrainToWasteOut",
        text = "排空废液池",
    },
    drainExposureCellWaste =
    {
        name = "DrainExposureCellWaste",
        text = "排空测量仓废液",
    },
    aspirationAirReagent =
    {
        name = "AspirationAirReagent",
        text = "注射器吸",
    },
    dischargeAirReagent =
    {
        name = "DischargeAirReagent",
        text = "注射器排",
    },
    syringeDrainMeasureRoom =
    {
        name = "SyringeDrainMeasureRoom",
        text = "注射器排测量仓溶液",
    },
    syringeDrainSampleMixer =
    {
        name = "SyringeDrainSampleMixer",
        text = "注射器排水样混合槽",
    },
    syringeSuckSampleMixer =
    {
        name = "SyringeSuckSampleMixer",
        text = "注射器抽水样杯溶液",
    },
    syringeSuckStandard =
    {
        name = "SyringeSuckStandard",
        text = "注射器抽量程校准液",
    },
    syringeSuckExposure =
    {
        name = "SyringeSuckExposure",
        text = "注射器抽曝气池溶液",
    },
    syringeSuckDilute =
    {
        name = "SyringeSuckDilute",
        text = "注射器抽稀释杯溶液",
    },
    drainToSample1 =
    {
        name = "DrainToSample1",
        text = "排至通道一",
    },
    drainToSample2 =
    {
        name = "DrainToSample2",
        text = "排至通道二",
    },
    drainToSample3 =
    {
        name = "DrainToSample3",
        text = "排至通道三",
    },
    drainToSample4 =
    {
        name = "DrainToSample4",
        text = "排至通道四",
    },
    drainToSample5 =
    {
        name = "DrainToSample5",
        text = "排至通道五",
    },
    drainToSample6 =
    {
        name = "DrainToSample6",
        text = "排至通道六",
    },
    drainToExtend1 =
    {
        name = "DrainToExtend1",
        text = "排至扩展通道1",
    },
    drainToExtend2 =
    {
        name = "DrainToExtend2",
        text = "排至扩展通道2",
    },
    drainToExtend3 =
    {
        name = "DrainToExtend3",
        text = "排至扩展通道3",
    },
    drainToExtend4 =
    {
        name = "DrainToExtend4",
        text = "排至扩展通道4",
    },
    drainToExtend5 =
    {
        name = "DrainToExtend5",
        text = "排至扩展通道5",
    },
    drainToExtend6 =
    {
        name = "DrainToExtend6",
        text = "排至扩展通道6",
    },
    suckFromExtend1 =
    {
        name = "SuckFromExtend1",
        text = "填充扩展通道1",
    },
    suckFromExtend2 =
    {
        name = "SuckFromExtend2",
        text = "填充扩展通道2",
    },
    suckFromExtend3 =
    {
        name = "SuckFromExtend3",
        text = "填充扩展通道3",
    },
    suckFromExtend4 =
    {
        name = "SuckFromExtend4",
        text = "填充扩展通道4",
    },
    suckFromExtend5 =
    {
        name = "SuckFromExtend5",
        text = "填充扩展通道5",
    },
    suckFromExtend6 =
    {
        name = "SuckFromExtend6",
        text = "填充扩展通道",
    },
}
return setting.runAction
