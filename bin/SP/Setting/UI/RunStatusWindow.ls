setting.ui.runStatus =
{
    reportModeList =
    {
        "   运行 ",
        "   离线 ",
        "   维护 ",
        "   故障 ",
        "   校准 ",
        "   调试 ",
    },
    targets =
    {
        {
            name = "ChannelOne",   --TOC模式下显示测量类型

            nameExpand = "通道一",

            targetPrivilege = Target.ChannelOne,

            getProformaData = function()
                local consistency = status.measure.proformaResult.measure.consistency

                return consistency
            end,

            getData = function()
                local dateTime = status.measure.newResult.measureChannelOne.dateTime
                local consistency = status.measure.newResult.measureChannelOne.consistency

                return dateTime, consistency
            end,

            getResultType = function()
                local resultType  = status.measure.newResult.measureChannelOne.resultType
                return resultType
            end,

            getModelType = function()
                local resultType  = status.measure.newResult.measureChannelOne.modelType
                return resultType
            end,
        },
        {
            name = "ChannelTwo",

            nameExpand = "通道二",

            targetPrivilege = Target.ChannelTwo,

            getProformaData = function()
                local consistency = status.measure.proformaResult.measureChannelTwo.consistency

                return consistency
            end,

            getData = function()
                local dateTime = status.measure.newResult.measureChannelTwo.dateTime
                local consistency = status.measure.newResult.measureChannelTwo.consistency

                return dateTime, consistency
            end,

            getResultType = function()
                local resultType  = status.measure.newResult.measureChannelTwo.resultType
                return resultType
            end,

            getModelType = function()
                local resultType  = status.measure.newResult.measureChannelTwo.modelType
                return resultType
            end,
        },
        {
            name = "ChannelThree",   --TOC模式下显示测量类型

            nameExpand = "通道三",

            targetPrivilege = Target.ChannelThree,

            getProformaData = function()
                local consistency = status.measure.proformaResult.measureChannelThree.consistency

                return consistency
            end,

            getData = function()
                local dateTime = status.measure.newResult.measureChannelThree.dateTime
                local consistency = status.measure.newResult.measureChannelThree.consistency

                return dateTime, consistency
            end,

            getResultType = function()
                local resultType  = status.measure.newResult.measureChannelThree.resultType
                return resultType
            end,

            getModelType = function()
                local resultType  = status.measure.newResult.measureChannelThree.modelType
                return resultType
            end,
        },
        {
            name = "ChannelFour",

            nameExpand = "通道四",

            targetPrivilege = Target.ChannelFour,

            getProformaData = function()
                local consistency = status.measure.proformaResult.measureChannelFour.consistency

                return consistency
            end,

            getData = function()
                local dateTime = status.measure.newResult.measureChannelFour.dateTime
                local consistency = status.measure.newResult.measureChannelFour.consistency

                return dateTime, consistency
            end,

            getResultType = function()
                local resultType  = status.measure.newResult.measureChannelFour.resultType
                return resultType
            end,

            getModelType = function()
                local resultType  = status.measure.newResult.measureChannelFour.modelType
                return resultType
            end,
        },
        {
            name = "ChannelFive",   --TOC模式下显示测量类型

            nameExpand = "通道五",

            targetPrivilege = Target.ChannelFive,

            getProformaData = function()
                local consistency = status.measure.proformaResult.measureChannelFive.consistency

                return consistency
            end,

            getData = function()
                local dateTime = status.measure.newResult.measureChannelFive.dateTime
                local consistency = status.measure.newResult.measureChannelFive.consistency

                return dateTime, consistency
            end,

            getResultType = function()
                local resultType  = status.measure.newResult.measureChannelFive.resultType
                return resultType
            end,

            getModelType = function()
                local resultType  = status.measure.newResult.measureChannelFive.modelType
                return resultType
            end,
        },
        {
            name = "ChannelSix",

            nameExpand = "通道六",

            targetPrivilege = Target.ChannelSix,

            getProformaData = function()
                local consistency = status.measure.proformaResult.measureChannelSix.consistency

                return consistency
            end,

            getData = function()
                local dateTime = status.measure.newResult.measureChannelSix.dateTime
                local consistency = status.measure.newResult.measureChannelSix.consistency

                return dateTime, consistency
            end,

            getResultType = function()
                local resultType  = status.measure.newResult.measureChannelSix.resultType
                return resultType
            end,

            getModelType = function()
                local resultType  = status.measure.newResult.measureChannelSix.modelType
                return resultType
            end,
        },
        {
            name = "Check",   --TOC模式下显示测量类型

            nameExpand = "核查",

            targetPrivilege = Target.Check,

            getProformaData = function()
                local consistency = status.measure.proformaResult.measure.consistency

                return consistency
            end,

            getData = function()
                local dateTime = status.measure.newResult.measure.dateTime
                local consistency = status.measure.newResult.measure.consistency

                return dateTime, consistency
            end,

            getResultType = function()
                local resultType  = status.measure.newResult.measure.resultType
                return resultType
            end,

            getModelType = function()
                local resultType  = status.measure.newResult.measure.modelType
                return resultType
            end,

        },
    },
    oneKeyMaintain = function()
        log:debug("RunStatusWindow createFlow ==> CalibrateFlow:oneKeyMaintain")
        local flow = CalibrateFlow:new({}, CalibrateType.oneKeyMaintain)
        flow.name = "OneKeyMaintain"
        FlowList.AddFlow(flow)
    end,

    UseExpandName = function()
        return true
    end,

    setBaseLineStatus = function(event)
        if event ~= nil and status.measure.isCheckBaseLine == true then
            --仅UI线程可用，否则调用无效
            if event == true then
                StatusManager.Instance():SetBaseline(BaseLineStatus.Ok)
            else
                StatusManager.Instance():SetBaseline(BaseLineStatus.Failed)
            end

        end
        return true
    end,

    WeepingDetectTempValue = 0,
    WeepingDetectHandle = function(value)
        -- @DSCP_EVENT_DSI_CHECK_LEAKING_NOTICE
        if 0 ~= setting.ui.runStatus.WeepingDetectTempValue and
                true == config.system.adcDetect[1].enable and
                value <= setting.ui.runStatus.WeepingDetectTempValue*(config.system.weepingLimitValve/100) then
            log:debug("Weeping Detect! "..value)
            local alarm = Helper.MakeAlarm(setting.alarm.instrumentWeeping, "")
            AlarmManager.Instance():AddAlarm(alarm)
            FlowManager.Instance():StopFlow()
        end

        if value ~= 0 then
            setting.ui.runStatus.WeepingDetectTempValue = value
        else
            setting.ui.runStatus.WeepingDetectTempValue = 1
        end
    end,

    dataChangeType = function(consistency , rangeView, modelType, userType)
        if userType == RoleType.General then
            return ""
        end

        --log:debug("consistency "..consistency.." rangeView "..rangeView.."modelType "..modelType)
        local result = string.format("%.2f", consistency / config.system.sampleConverCurveK)
        if string.match(modelType, "COD")  then
            --return "当前数据量程： 0 - "..rangeView..", 对应TOC浓度： "..result
            return " "
        else
            return " "
        end
    end,

    showType = function()
        --if config.system.targetMap.COD.enable == true then
        --    return "COD"
        --else
            return "TOC"
        --end

    end,

    getOpticalData = function()
        local data = 0
        local num = 0
        local ScanLen = dc:GetScanLen()
        if ScanLen ~= nil then
            num = ScanLen
        end

        local ScanData = dc:GetScanData(num - 1)
        if ScanData ~= nil then
            data = ScanData
        end

        return  data
    end,

    getExOpticalData = function()
        local data = 0
        local num = 0
        local ScanLen = dc:GetExScanLen()
        if ScanLen ~= nil then
            num = ScanLen
        end

        local ScanData = dc:GetExScanData(num - 1)
        if ScanData ~= nil then
            data = ScanData
        end

        return  data
    end,

    setStoveTemperatureCalibrate = function()
        local tempCalibrate = TempCalibrateFactor.new()
        if dc:GetConnectStatus() then
            local status,result = pcall(function()
                --local scale
                --if  config.hardwareConfig.twoPointTempCalibrate.firstTempAD > config.hardwareConfig.twoPointTempCalibrate.secondTempAD  then
                --    scale = (config.hardwareConfig.twoPointTempCalibrate.firstTempAD - config.hardwareConfig.twoPointTempCalibrate.secondTempAD )
                --            / (config.hardwareConfig.twoPointTempCalibrate.firstTemp - config.hardwareConfig.twoPointTempCalibrate.secondTemp)
                --else
                --    scale = (config.hardwareConfig.twoPointTempCalibrate.secondTempAD - config.hardwareConfig.twoPointTempCalibrate.firstTempAD )
                --            / (config.hardwareConfig.twoPointTempCalibrate.secondTemp - config.hardwareConfig.twoPointTempCalibrate.firstTemp)
                --end
                --
                --log:debug("cal set " .. scale .. "  "
                --        .. config.hardwareConfig.twoPointTempCalibrate.firstTemp .. "  "
                --        .. config.hardwareConfig.twoPointTempCalibrate.firstTempAD)
                --tempCalibrate:SetCalibrationVoltage(config.hardwareConfig.twoPointTempCalibrate.firstTemp)
                --tempCalibrate:SetReferenceVoltage(config.hardwareConfig.twoPointTempCalibrate.firstTempAD)
                --tempCalibrate:SetNegativeInput(scale)
                --return dc:GetITemperatureControl():SetCalibrateFactorForTOC(0, tempCalibrate)
            end)
            if not status then
                ExceptionHandler.MakeAlarm(result)
                return false, "设置温度校准系数失败\n"
            else
                return true, ""
            end
        else
            return false,"驱动板连接断开,\n设置温度校准系数失败\n"
        end
    end,

    maintenanceStopStove = function()

        local ret = false
        if dc:GetConnectStatus() == true then

            if setting.temperature.isOpenTempMonitor then
                setting.temperature.isOpenTempMonitor = false
                op:StopThermostat()
                --dc:GetITemperatureControl():RelayControlForTOC(0)
                print("close")
                log:warn("燃烧炉停止")
                ret = true
            else
                setting.temperature.monitor.stoveAbnormalTemperature = -1
                setting.temperature.isOpenTempMonitor = true
                op:ReviseThermostatTemp(setting.temperature.indexStove, ThermostatMode.Heater, config.measureParam.reactTemperature, setting.temperature.toleranceTemp, setting.temperature.digestTempTimeout)
                dc:GetITemperatureControl():RelayControlForTOC(1)
                setting.temperature.monitor.stoveAlarm = false
                print("open")
                log:warn("燃烧炉升温")
                ret = false
            end
            App.Sleep(200)
        end

        return  ret
    end,

    thermostatMonitor = function()
        --print(tostring(setting.temperature.monitor.time))
        setting.temperature.monitor.time = setting.temperature.monitor.time +  setting.temperature.tempMonitorControlPeriod
        local currentTemp
        if dc:GetConnectStatus() == true then
            
            local statusManager = StatusManager.Instance()
            local runStatus = statusManager:GetStatus()
            local name = runStatus:GetContent()
            if name == setting.runStatus.DCUpdate.text then
                setting.temperature.monitor.stoveAbnormalTemperature = -1
                setting.temperature.monitor.refrigeratorAbnormalTemperature = -1
                setting.temperature.monitor.NDIRAbnormalTemperature = -1
                return true
            elseif setting.temperature.monitor.stoveAbnormalTemperature == -1 or
                    setting.temperature.monitor.refrigeratorAbnormalTemperature == -1 or
                    setting.temperature.monitor.NDIRAbnormalTemperature == -1 then
                setting.temperature.monitor.stoveLastTemperature = 0
                setting.temperature.monitor.stoveAbnormalTemperature = 0
                setting.temperature.monitor.refrigeratorLastTemperature = 0
                setting.temperature.monitor.refrigeratorAbnormalTemperature = 0
                setting.temperature.monitor.NDIRLastTemperature = 0
                setting.temperature.monitor.NDIRAbnormalTemperature = 0
                setting.temperature.monitor.time = 0
                return true --驱动升级后首次监测无效
            end

            --监测燃烧炉30秒内温度变化是否异常
            if setting.temperature.isOpenTempMonitor == true then
                --监测燃烧炉5秒内温度变化是否跳变
                op:IsTemperatureAbnormal(setting.temperature.indexStove, 20)
                if math.fmod( setting.temperature.monitor.time, setting.temperature.monitor.stoveTimeout) == 0 then
                    if true == op:CheckThermostat(setting.temperature.indexStove, 5, 35) then
                        currentTemp = dc:GetCurrentTemperature():GetThermostatTemp()
                        if math.abs(currentTemp - config.measureParam.reactTemperature) > 20
                                and setting.temperature.monitor.stoveAlarm == false then
                            dc:GetITemperatureControl():RelayControlForTOC(1)
                            op:ReviseThermostatTemp(setting.temperature.indexStove, ThermostatMode.Heater,
                                    config.measureParam.reactTemperature, setting.temperature.toleranceTemp, setting.temperature.digestTempTimeout)
                        end
                    end
                end
            end

            --监测制冷器5秒内温度变化是否跳变
            op:IsTemperatureAbnormal(setting.temperature.indexRefrigerator, 10)
            --监测制冷器5分钟内温度变化是否异常
            if  math.fmod( setting.temperature.monitor.time, setting.temperature.monitor.refrigeratorTimeout) == 0 then
                if true == op:CheckThermostat(setting.temperature.indexRefrigerator, 1, 5) then
                    currentTemp =  dc:GetReportThermostatTemp(setting.temperature.temperatureRefrigerator)
                    if math.abs(currentTemp - config.measureParam.coolTemperature) > 2.5
                            and setting.temperature.monitor.refrigeratorAlarm == false then
                        op:ReviseThermostatTemp(setting.temperature.indexRefrigerator,  ThermostatMode.Refrigerate,
                                config.measureParam.coolTemperature, setting.temperature.coolToleranceTemp, setting.temperature.coolTempTimeout)
                    end
                end
            end

            ----监测NDIR 5秒内温度变化是否跳变
            --op:IsTemperatureAbnormal(setting.temperature.indexLNDIR, 10)
            ----监测NIDR 5分钟内温度变化是否异常
            --if  math.fmod( setting.temperature.monitor.time, setting.temperature.monitor.NDIRTimeout) == 0 then
            --    if true == op:CheckThermostat(setting.temperature.indexLNDIR, 0.5, 10) then
            --        currentTemp = dc:GetReportThermostatTemp(setting.temperature.temperatureLNDIR)
            --        if math.abs(currentTemp - config.measureParam.measureModuleTemperature) > 2
            --                and setting.temperature.monitor.NDIRAlarm == false then
            --            op:ReviseThermostatTemp(setting.temperature.indexLNDIR,  ThermostatMode.Heater,
            --                    config.measureParam.measureModuleTemperature, setting.temperature.NDIRToleranceTemp, setting.temperature.NDIRTempTimeout)
            --        end
            --    end
            --end

            ----监测NDIR 5秒内温度变化是否跳变
            --op:IsTemperatureAbnormal(setting.temperature.indexLNDIR, 10)
            ----监测NIDR 5分钟内温度变化是否异常
            --if  math.fmod( setting.temperature.monitor.time, setting.temperature.monitor.NDIRTimeout) == 0 then
            --    if true == op:CheckThermostat(setting.temperature.indexLNDIR, 0.5, 10) then
            --        currentTemp = dc:GetReportThermostatTemp(setting.temperature.temperatureLNDIR)
            --        if math.abs(currentTemp - config.measureParam.measureModuleTemperature) > 2
            --                and setting.temperature.monitor.NDIRAlarm == false then
            --            op:ReviseThermostatTemp(setting.temperature.indexLNDIR,  ThermostatMode.Heater,
            --                    config.measureParam.measureModuleTemperature, setting.temperature.NDIRToleranceTemp, setting.temperature.NDIRTempTimeout)
            --        end
            --    end
            --end
        end
    end

}
return setting.ui.runStatus
