--[[
 * @brief 硬件测试
--]]

HardwareTest =
{
    -- row 1
    {
        name = "MeterPump",
        open = function()
            local pump = pumps[setting.liquidType.waste.pump + 1]
            pump:Start(RollDirection.Drain, 1000000, 0.5)
        end,
        close = function()
            local pump = pumps[setting.liquidType.waste.pump + 1]
            pump:Stop()
        end,
        status = false,
    },
    -- row 2
    {
        name = "SampleValve",
        open = function()
            local curmap = dc:GetISolenoidValve():GetValveMap():GetData()
            local map = ValveMap.new(curmap | setting.liquidType.sample.valve)
            dc:GetISolenoidValve():SetValveMap(map)
        end,
        close = function()
            local curmap = dc:GetISolenoidValve():GetValveMap():GetData()
            local map = ValveMap.new(curmap & ~setting.liquidType.sample.valve)
            dc:GetISolenoidValve():SetValveMap(map)
        end,
        status = false,
    },
    -- row 3
    {
        name = "Reagent1Valve",
        open = function()
            local curmap = dc:GetISolenoidValve():GetValveMap():GetData()
            local map = ValveMap.new(curmap | setting.liquidType.reagent1.valve)
            dc:GetISolenoidValve():SetValveMap(map)
        end,
        close = function()
            local curmap = dc:GetISolenoidValve():GetValveMap():GetData()
            local map = ValveMap.new(curmap & ~setting.liquidType.reagent1.valve)
            dc:GetISolenoidValve():SetValveMap(map)
        end,
        status = false,
    },
    -- row 4
    {
        name = "Reagent2Valve",
        open = function()
            local curmap = dc:GetISolenoidValve():GetValveMap():GetData()
            local map = ValveMap.new(curmap | setting.liquidType.reagent2.valve)
            dc:GetISolenoidValve():SetValveMap(map)
        end,
        close = function()
            local curmap = dc:GetISolenoidValve():GetValveMap():GetData()
            local map = ValveMap.new(curmap & ~setting.liquidType.reagent2.valve)
            dc:GetISolenoidValve():SetValveMap(map)
        end,
        status = false,
    },
    -- row 5
    {
        name = "ThreeWatValve",
        open = function()
            local curmap = dc:GetISolenoidValve():GetValveMap():GetData()
            local map = ValveMap.new(curmap | setting.liquidType.map.valve9)
            dc:GetISolenoidValve():SetValveMap(map)
        end,
        close = function()
            local curmap = dc:GetISolenoidValve():GetValveMap():GetData()
            local map = ValveMap.new(curmap & ~setting.liquidType.map.valve9)
            dc:GetISolenoidValve():SetValveMap(map)
        end,
        status = false,
    },
    -- row 6
    {
        name = "StandardValve",
        open = function()
            local curmap = dc:GetISolenoidValve():GetValveMap():GetData()
            local map = ValveMap.new(curmap | setting.liquidType.standard.valve)
            dc:GetISolenoidValve():SetValveMap(map)
        end,
        close = function()
            local curmap = dc:GetISolenoidValve():GetValveMap():GetData()
            local map = ValveMap.new(curmap & ~setting.liquidType.standard.valve)
            dc:GetISolenoidValve():SetValveMap(map)
        end,
        status = false,
    },
    -- row 7
    {
        name = "BlankValve",
        open = function()
            local curmap = dc:GetISolenoidValve():GetValveMap():GetData()
            local map = ValveMap.new(curmap | setting.liquidType.blank.valve)
            dc:GetISolenoidValve():SetValveMap(map)
        end,
        close = function()
            local curmap = dc:GetISolenoidValve():GetValveMap():GetData()
            local map = ValveMap.new(curmap & ~setting.liquidType.blank.valve)
            dc:GetISolenoidValve():SetValveMap(map)
        end,
        status = false,
    },
    -- row 8
    {
        name = "ZeroCheckValve",
        open = function()
            local curmap = dc:GetISolenoidValve():GetValveMap():GetData()
            local map = ValveMap.new(curmap | setting.liquidType.zeroCheck.valve)
            dc:GetISolenoidValve():SetValveMap(map)
        end,
        close = function()
            local curmap = dc:GetISolenoidValve():GetValveMap():GetData()
            local map = ValveMap.new(curmap & ~setting.liquidType.zeroCheck.valve)
            dc:GetISolenoidValve():SetValveMap(map)
        end,
        status = false,
    },
    -- row 9
    {
        name = "RangeCheckValve",
        open = function()
            local curmap = dc:GetISolenoidValve():GetValveMap():GetData()
            local map = ValveMap.new(curmap | setting.liquidType.rangeCheck.valve)
            dc:GetISolenoidValve():SetValveMap(map)
        end,
        close = function()
            local curmap = dc:GetISolenoidValve():GetValveMap():GetData()
            local map = ValveMap.new(curmap & ~setting.liquidType.rangeCheck.valve)
            dc:GetISolenoidValve():SetValveMap(map)
        end,
        status = false,
    },
    -- row 10
    {
        name = "WasteValve",
        open = function()
            local curmap = dc:GetISolenoidValve():GetValveMap():GetData()
            local map = ValveMap.new(curmap | setting.liquidType.wasteSample.valve)
            dc:GetISolenoidValve():SetValveMap(map)
        end,
        close = function()
            local curmap = dc:GetISolenoidValve():GetValveMap():GetData()
            local map = ValveMap.new(curmap & ~setting.liquidType.wasteSample.valve)
            dc:GetISolenoidValve():SetValveMap(map)
        end,
        status = false,
    },
    -- row 11
    {
        name = "WasteWaterValve",
        open = function()
            local curmap = dc:GetISolenoidValve():GetValveMap():GetData()
            local map = ValveMap.new(curmap | setting.liquidType.wasteWater.valve)
            dc:GetISolenoidValve():SetValveMap(map)
        end,
        close = function()
            local curmap = dc:GetISolenoidValve():GetValveMap():GetData()
            local map = ValveMap.new(curmap & ~setting.liquidType.wasteWater.valve)
            dc:GetISolenoidValve():SetValveMap(map)
        end,
        status = false,
    },
    -- row 12
    {
        name = "DigestRoomUpValve",
        open = function()
            if HardwareTest[14].status or HardwareTest[15].status then
                return false
            end
            local curmap = dc:GetISolenoidValve():GetValveMap():GetData()
            local map = ValveMap.new(curmap | setting.liquidType.map.valve5)
            dc:GetISolenoidValve():SetValveMap(map)
        end,
        close = function()
            local curmap = dc:GetISolenoidValve():GetValveMap():GetData()
            local map = ValveMap.new(curmap & ~setting.liquidType.map.valve5)
            dc:GetISolenoidValve():SetValveMap(map)
        end,
        status = false,
    },
    -- row 13
    {
        name = "DigestRoomBottomValve",
        open = function()
            if HardwareTest[14].status or HardwareTest[15].status then
                return false
            end
            local curmap = dc:GetISolenoidValve():GetValveMap():GetData()
            local map = ValveMap.new(curmap | setting.liquidType.map.valve10)
            dc:GetISolenoidValve():SetValveMap(map)
        end,
        close = function()
            local curmap = dc:GetISolenoidValve():GetValveMap():GetData()
            local map = ValveMap.new(curmap & ~setting.liquidType.map.valve10)
            dc:GetISolenoidValve():SetValveMap(map)
        end,
        status = false,
    },
    -- row 14
    {
        name = "StoveHeating",
        open = function()
            if HardwareTest[12].status or HardwareTest[13].status or HardwareTest[15].status then
                return false
            end
            local thermostatTemp = dc:GetCurrentTemperature():GetThermostatTemp()
            local targetTemp = thermostatTemp + setting.temperature.smartHeatDetectTemp
            dc:GetITemperatureControl():ReviseThermostatTemp(setting.temperature.indexStove,
                    ThermostatMode.Heater,
                    targetTemp,
                    setting.temperature.toleranceTemp,
                    setting.temperature.smartHeatDetectTime)
        end,
        close = function()
            dc:GetITemperatureControl():ReviseThermostatTemp(setting.temperature.indexStove,
                    ThermostatMode.Heater,
                    config.measureParam.reactTemperature,
                    setting.temperature.toleranceTemp,
                    setting.temperature.smartHeatDetectTime)
        end,
        status = false,
    },
    -- row 15
    {
        name = "StoveFan",
        open = function()
            dc:GetITemperatureControl():DigestionFanSetOutputForTOC(setting.temperature.indexStoveFan, 1)
        end,
        close = function()
            dc:GetITemperatureControl():DigestionFanSetOutputForTOC(setting.temperature.indexStoveFan, 0)
        end,
        status = false,
    },
    -- row 16
    {
        name = "MeasuerLED",
        open = function()
            dc:GetIOpticalAcquire():TurnOnLED(setting.LED.LMeaIndex)

            --开始更新基线状态
            status.measure.isCheckBaseLine = true
            ConfigLists.SaveMeasureStatus()

            StatusManager.Instance():SetBaseline(BaseLineStatus.Failed)
        end,
        close = function()
            dc:GetIOpticalAcquire():TurnOffLED(setting.LED.LMeaIndex)

            --开始更新基线状态
            status.measure.isCheckBaseLine = false
            ConfigLists.SaveMeasureStatus()
            StatusManager.Instance():SetBaseline(BaseLineStatus.Stop)
        end,
        status = false,
    },
    -- row 17
    {
        name = "Meter1LED",
        open = function()
            dc:GetIOpticalMeter():TurnOnLED(1)
        end,
        close = function()
            dc:GetIOpticalMeter():TurnOffLED(1)
        end,
        status = false,
    },
    -- row 18
    {
        name = "Meter2LED",
        open = function()
            dc:GetIOpticalMeter():TurnOnLED(2)
        end,
        close = function()
            dc:GetIOpticalMeter():TurnOffLED(2)
        end,
        status = false,
    },
    -- row 19
    {
        name = "CollectSampleRelay",
        open = function()
            if not string.find(config.info.instrument["type"], "PT63P") then
                WaterCollector.Instance():TurnOn()
            end
        end,
        close = function()
            if not string.find(config.info.instrument["type"], "PT63P") then
                WaterCollector.Instance():TurnOff()
            end
        end,
        status = false,
    },
    -- row 20
    {
        name = "Relay1",
        open = function()
            RelayControl.Instance():TurnOn(2)
        end,
        close = function()
            RelayControl.Instance():TurnOff(2)
        end,
        status = false,
    },
    -- row 21
    {
        name = "Relay2",
        open = function()
            RelayControl.Instance():TurnOn(3)
        end,
        close = function()
            RelayControl.Instance():TurnOff(3)
        end,
        status = false,
    },
    -- row 22
    {
        name = "SampleCurrent4Output",
        open = function()
            if HardwareTest[23].status or HardwareTest[24].status then
                return false
            end
            CurrentResultManager.Instance():OutputSampleCurrent(4)
            CurrentResultManager.Instance():OutputCheckCurrent(4)
        end,
        close = function()
            if HardwareTest[23].status or HardwareTest[24].status then
                return false
            end
            CurrentResultManager.Instance():OutputSample(status.measure.report.measure.consistency)
            CurrentResultManager.Instance():OutputCheck(status.measure.report.measure.consistency)
        end,
        status = false,
    },
    -- row 23
    {
        name = "SampleCurrent12Output",
        open = function()
            if HardwareTest[22].status or HardwareTest[24].status then
                return false
            end
            CurrentResultManager.Instance():OutputSampleCurrent(12)
            CurrentResultManager.Instance():OutputCheckCurrent(12)
        end,
        close = function()
            if HardwareTest[22].status or HardwareTest[24].status then
                return false
            end
            CurrentResultManager.Instance():OutputSample(status.measure.report.measure.consistency)
            CurrentResultManager.Instance():OutputCheck(status.measure.report.measure.consistency)
        end,
        status = false,
    },
    -- row 24
    {
        name = "SampleCurrent20Output",
        open = function()
            if HardwareTest[22].status or HardwareTest[23].status then
                return false
            end
            CurrentResultManager.Instance():OutputSampleCurrent(20)
            CurrentResultManager.Instance():OutputCheckCurrent(20)
        end,
        close = function()
            if HardwareTest[22].status or HardwareTest[23].status then
                return false
            end
            CurrentResultManager.Instance():OutputSample(status.measure.report.measure.consistency)
            CurrentResultManager.Instance():OutputCheck(status.measure.report.measure.consistency)
        end,
        status = false,
    },
    -- row 25
    {
        name = "BoxDownFan",
        open = function()
            dc:SetBoxFanEnable(false)
            op.ITemperatureControl:BoxFanSetOutputForTOC(setting.temperature.boxDownFan, 0.5)
        end,
        close = function()
            op.ITemperatureControl:BoxFanSetOutputForTOC(setting.temperature.boxDownFan, 0)
            if not HardwareTest[39].status then
                dc:SetBoxFanEnable(true)
            end
        end,
        status = false,
    },
    -- row 26
    {
        name = "StoveFan",
        open = function()
            dc:GetITemperatureControl():DigestionFanSetOutputForTOC(setting.temperature.indexStoveFan, 1)
        end,
        close = function()
            dc:GetITemperatureControl():DigestionFanSetOutputForTOC(setting.temperature.indexStoveFan, 0)
        end,
        status = false,
    },
    -- row 27
    {
        name = "ProportionalValve1",
        open = function()
            dc:GetISolenoidValve():ProportionalValve_SetDACValue(setting.pressure.indexExposureValve, config.measureParam.exposureValveVoltage)
        end,
        close = function()
            dc:GetISolenoidValve():ProportionalValve_SetDACValue(setting.pressure.indexExposureValve, 0)
        end,
        status = false,
    },
    -- row 28
    {
        name = "ProportionalValve2",
        open = function()
            dc:GetISolenoidValve():ProportionalValve_SetDACValue(setting.pressure.indexCarryPressureValve, config.measureParam.carryingValveVoltage)
        end,
        close = function()
            dc:GetISolenoidValve():ProportionalValve_SetDACValue(setting.pressure.indexCarryPressureValve, 0)
        end,
        status = false,
    },
    -- row 29
    {
        name = "Refrigeration",
        open = function()
            op:ReviseThermostatTemp(setting.temperature.indexRefrigerator, ThermostatMode.Refrigerate, config.measureParam.coolTemperature + 10, setting.temperature.coolToleranceTemp, setting.temperature.coolTempTimeout)
        end,
        close = function()
            op:ReviseThermostatTemp(setting.temperature.indexRefrigerator, ThermostatMode.Refrigerate, config.measureParam.coolTemperature, setting.temperature.coolToleranceTemp, setting.temperature.coolTempTimeout)
        end,
        status = false,
    },
    -- row 30
    {
        name = "NirtrogenValve",
        open = function()
            local curmap = dc:GetISolenoidValve():GetValveMap():GetData()
            local map = ValveMap.new(curmap | setting.liquidType.master.valve)
            dc:GetISolenoidValve():SetValveMap(map)
        end,
        close = function()
            local curmap = dc:GetISolenoidValve():GetValveMap():GetData()
            local map = ValveMap.new(curmap & ~setting.liquidType.master.valve)
            dc:GetISolenoidValve():SetValveMap(map)
        end,
        status = false,
    },
    -- row 31
    {
        name = "ExposureNirtrogen",
        open = function()
            op:ExposureTurnOn()
        end,
        close = function()
            op:ExposureTurnOff()
        end,
        status = false,
    },
    --row 32
    {
        name = "CarrierGas",
        open = function()
            --dc:GetISolenoidValve():ProportionalValve_SetDACValue(setting.pressure.indexCarryPressureValve, config.measureParam.carryingValveVoltage)
            --local curmap = dc:GetISolenoidValve():GetValveMap():GetData()
            --local map = ValveMap.new(curmap | setting.liquidType.map.valve4)
            --dc:GetISolenoidValve():SetValveMap(map)
            op:TurnOnNirtrogen(0.2)
        end,
        close = function()
            --dc:GetISolenoidValve():ProportionalValve_SetDACValue(setting.pressure.indexCarryPressureValve, 0)
            --local curmap = dc:GetISolenoidValve():GetValveMap():GetData()
            --local map = ValveMap.new(curmap & ~setting.liquidType.map.valve4)
            --dc:GetISolenoidValve():SetValveMap(map)
            op:TurnOffNirtrogen()
        end,
        status = false,
    },
    -- row 33
    {
        name = "SlidersPump",
        open = function()
            if HardwareTest[36].status or HardwareTest[37].status or  HardwareTest[38].status then
                return false
            end
            --local pump = pumps[setting.liquidType.sliders.pump + 1]
            --pump:Start(RollDirection.Drain, 5, 0)
            --op:SlidersMovingWithSensor()
            op:PumpNoEvent(setting.liquidType.sliders, setting.sensor.sliderActionWithSensor, 0)
        end,
        close = function()
            local pump = pumps[setting.liquidType.sliders.pump + 1]
            pump:Stop()
            local flowManager = FlowManager.Instance()
            flowManager:ClearAllRemainEvent()
        end,
        status = false,
    },
    -- row 34
    {
        name = "SyringePump",
        open = function()
            local pump = pumps[setting.liquidType.syringeBlank.pump + 1]
            local factor = dc:GetIPeristalticPump():GetPumpFactor(2)
            local drainSpeed = setting.liquid.syringeSlowDrainSpeed * factor
            if op:SyringeGetSenseStatus(setting.sensor.syringeIndex) == true then
                pump:Start(RollDirection.Suck, setting.liquid.syringeCleanVolume, drainSpeed)
            else
                pump:Start(RollDirection.Drain, setting.liquid.syringeResetVolume, drainSpeed)
            end
        end,
        close = function()
            local pump = pumps[setting.liquidType.syringeBlank.pump + 1]
            local factor = dc:GetIPeristalticPump():GetPumpFactor(2)
            local drainSpeed = setting.liquid.syringeSlowDrainSpeed * factor
            if op:SyringeGetSenseStatus(setting.sensor.syringeIndex) == false then
                pump:Start(RollDirection.Drain, setting.liquid.syringeResetVolume, drainSpeed)
            end
        end,
        status = false,
    },
    -- row 35
    {
        name = "SlidersCheck",
        open = function()
            if HardwareTest[36].status or HardwareTest[37].status or  HardwareTest[38].status or HardwareTest[33].status then
                return false
            end
            --local pump = pumps[setting.liquidType.sliders.pump + 1]
            --pump:Start(RollDirection.Drain, setting.sensor.sliderActionWithSensor, 0)
            --op:SlidersSensorCheck()
        end,
        close = function()
            --local pump = pumps[setting.liquidType.stove.pump + 1]
            --pump:Stop()
        end,
        status = false,
    },
    -- row 36
    {
        name = "SlidersCalibrate",
        open = function()
            if HardwareTest[38].status or HardwareTest[37].status or  HardwareTest[35].status or HardwareTest[33].status then
                return false
            end
            --op:SlidersCalibrate()
        end,
        close = function()
            --local pump = pumps[setting.liquidType.sliders.pump + 1]
            --pump:Stop()
        end,
        status = false,
    },
    -- row 37
    {
        name = "SlidersForward",
        open = function()
            if HardwareTest[38].status or HardwareTest[36].status or  HardwareTest[35].status or HardwareTest[33].status then
                return false
            end
            local pump = pumps[setting.liquidType.sliders.pump + 1]
            pump:Start(RollDirection.Suck, setting.sensor.slidersStep, 0)
        end,
        close = function()
            local pump = pumps[setting.liquidType.sliders.pump + 1]
            pump:Stop()
            if true == op:GetSlidersSensorStatus() then
                setting.sensor.isValid = true
            end
        end,
        status = false,
    },
    -- row 38
    {
        name = "SlidersBackward",
        open = function()
            if HardwareTest[37].status or HardwareTest[36].status or  HardwareTest[35].status or HardwareTest[33].status then
                return false
            end
            local pump = pumps[setting.liquidType.sliders.pump + 1]
            pump:Start(RollDirection.Drain, setting.sensor.slidersStep, 0)
            --setting.sensor.isValid = false
        end,
        close = function()
            local pump = pumps[setting.liquidType.sliders.pump + 1]
            pump:Stop()
            --if true == op:GetSlidersSensorStatus() then
            --    setting.sensor.isValid = true
            --end
        end,
        status = false,
    },
    -- row 39
    {
        name = "BoxUpFan",
        open = function()
            dc:SetBoxFanEnable(false)
            dc:GetITemperatureControl():BoxFanSetOutputForTOC(setting.temperature.boxUpFan, 0.5)
        end,
        close = function()
            dc:GetITemperatureControl():BoxFanSetOutputForTOC(setting.temperature.boxUpFan, 0)
            if not HardwareTest[25].status then
                dc:SetBoxFanEnable(true)
            end
        end,
        status = false,
    },
    -- row 40
    {
        name = "RefrigeratorWaterValve",
        open = function()
            local curmap = dc:GetISolenoidValve():GetValveMap():GetData()
            local map = ValveMap.new(curmap | setting.liquidType.coolerWater.valve)
            dc:GetISolenoidValve():SetValveMap(map)
        end,
        close = function()
            local curmap = dc:GetISolenoidValve():GetValveMap():GetData()
            local map = ValveMap.new(curmap & ~setting.liquidType.coolerWater.valve)
            dc:GetISolenoidValve():SetValveMap(map)
        end,
        status = false,
    },
    -- row 41
    {
        name = "HalogenBottleWater",
        open = function()
            local curmap = dc:GetISolenoidValve():GetValveMap():GetData()
            local map = ValveMap.new(curmap | setting.liquidType.halogenBottleWater.valve)
            dc:GetISolenoidValve():SetValveMap(map)
        end,
        close = function()
            local curmap = dc:GetISolenoidValve():GetValveMap():GetData()
            local map = ValveMap.new(curmap & ~setting.liquidType.halogenBottleWater.valve)
            dc:GetISolenoidValve():SetValveMap(map)
        end,
        status = false,
    },
    -- row 42
    {
        name = "SyringeBlank",
        open = function()
            local curmap = dc:GetISolenoidValve():GetValveMap():GetData()
            local map = ValveMap.new(curmap | setting.liquidType.syringeBlank.valve)
            dc:GetISolenoidValve():SetValveMap(map)
        end,
        close = function()
            local curmap = dc:GetISolenoidValve():GetValveMap():GetData()
            local map = ValveMap.new(curmap & ~setting.liquidType.syringeBlank.valve)
            dc:GetISolenoidValve():SetValveMap(map)
        end,
        status = false,
    },
    -- row 43
    {
        name = "MeasuerLED",
        open = function()
            dc:GetIOpticalAcquire():TurnOnLED(setting.LED.SMeaIndex)

            --开始更新基线状态
            status.measure.isCheckBaseLine = true
            ConfigLists.SaveMeasureStatus()

            StatusManager.Instance():SetBaseline(BaseLineStatus.Failed)
        end,
        close = function()
            dc:GetIOpticalAcquire():TurnOffLED(setting.LED.SMeaIndex)

            --开始更新基线状态
            status.measure.isCheckBaseLine = false
            ConfigLists.SaveMeasureStatus()
            StatusManager.Instance():SetBaseline(BaseLineStatus.Stop)
        end,
        status = false,
    },
    -- row 44
    {
        name = "SamplePump",
        open = function()
            local pump = pumps[setting.liquidType.sample.pump + 1]
            local acceleration = 0.5
            local drainSpeed = 0.2
            local motionParam = MotionParam.new()
            motionParam:SetAcceleration(acceleration)
            motionParam:SetSpeed(drainSpeed)
            log:debug("[重设泵参数]： Set Speed " .. drainSpeed .. ", Set Acceleration " .. acceleration)
            dc:GetIPeristalticPump():SetMotionParam(0, motionParam)
            pump:Start(RollDirection.Drain, 1000000, 0.5)
        end,
        close = function()
            local pump = pumps[setting.liquidType.sample.pump + 1]
            pump:Stop()
        end,
        status = false,
    },
    -- row 45
    {
        name = "ReagentPump",
        open = function()
            local pump = pumps[setting.liquidType.reagent1.pump + 1]
            pump:Start(RollDirection.Drain, 1000000, 0)
        end,
        close = function()
            local pump = pumps[setting.liquidType.reagent1.pump + 1]
            pump:Stop()
        end,
        status = false,
    },
    -- row 46
    {
        name = "CoolantPump",
        open = function()
            local pump = pumps[setting.liquidType.coolerWater.pump + 1]
            pump:Start(RollDirection.Drain, 1000000, 0.3)
        end,
        close = function()
            local pump = pumps[setting.liquidType.coolerWater.pump + 1]
            pump:Stop()
        end,
        status = false,
    },
    -- row 47
    {
        name = "Sliders",
        open = function()
            local pump = pumps[setting.liquidType.sliders.pump + 1]
            --pump:Start(RollDirection.Drain, 1000000, 0)
        end,
        close = function()
            local pump = pumps[setting.liquidType.sliders.pump + 1]
            pump:Stop()
        end,
        status = false,
    },
    -- row 48
    {
        name = "SampleSupplyPump",
        open = function()
            local pump = pumps[setting.liquidType.standard.pump + 1]
            pump:Start(RollDirection.Drain, 1000000, 0)
        end,
        close = function()
            local pump = pumps[setting.liquidType.standard.pump + 1]
            pump:Stop()
        end,
        status = false,
    },
    -- row 49
    {
        name = "SampleValve",
        open = function()
            local curmap = dc:GetISolenoidValve():GetValveMap():GetData()
            local map = ValveMap.new(curmap | setting.liquidType.sample1.valve)
            dc:GetISolenoidValve():SetValveMap(map)
        end,
        close = function()
            local curmap = dc:GetISolenoidValve():GetValveMap():GetData()
            local map = ValveMap.new(curmap & ~setting.liquidType.sample1.valve)
            dc:GetISolenoidValve():SetValveMap(map)
        end,
        status = false,
    },
    -- row 50
    {
        name = "SampleValve",
        open = function()
            local curmap = dc:GetISolenoidValve():GetValveMap():GetData()
            local map = ValveMap.new(curmap | setting.liquidType.sample2.valve)
            dc:GetISolenoidValve():SetValveMap(map)
        end,
        close = function()
            local curmap = dc:GetISolenoidValve():GetValveMap():GetData()
            local map = ValveMap.new(curmap & ~setting.liquidType.sample2.valve)
            dc:GetISolenoidValve():SetValveMap(map)
        end,
        status = false,
    },
    -- row 51
    {
        name = "SampleValve",
        open = function()
            local curmap = dc:GetISolenoidValve():GetValveMap():GetData()
            local map = ValveMap.new(curmap | setting.liquidType.sample3.valve)
            dc:GetISolenoidValve():SetValveMap(map)
        end,
        close = function()
            local curmap = dc:GetISolenoidValve():GetValveMap():GetData()
            local map = ValveMap.new(curmap & ~setting.liquidType.sample3.valve)
            dc:GetISolenoidValve():SetValveMap(map)
        end,
        status = false,
    },
    -- row 52
    {
        name = "SampleValve",
        open = function()
            local curmap = dc:GetISolenoidValve():GetValveMap():GetData()
            local map = ValveMap.new(curmap | setting.liquidType.sample4.valve)
            dc:GetISolenoidValve():SetValveMap(map)
        end,
        close = function()
            local curmap = dc:GetISolenoidValve():GetValveMap():GetData()
            local map = ValveMap.new(curmap & ~setting.liquidType.sample4.valve)
            dc:GetISolenoidValve():SetValveMap(map)
        end,
        status = false,
    },
    -- row 53
    {
        name = "SampleValve",
        open = function()
            local curmap = dc:GetISolenoidValve():GetValveMap():GetData()
            local map = ValveMap.new(curmap | setting.liquidType.sample5.valve)
            dc:GetISolenoidValve():SetValveMap(map)
        end,
        close = function()
            local curmap = dc:GetISolenoidValve():GetValveMap():GetData()
            local map = ValveMap.new(curmap & ~setting.liquidType.sample5.valve)
            dc:GetISolenoidValve():SetValveMap(map)
        end,
        status = false,
    },
    -- row 54
    {
        name = "SampleValve",
        open = function()
            local curmap = dc:GetISolenoidValve():GetValveMap():GetData()
            local map = ValveMap.new(curmap | setting.liquidType.sample6.valve)
            dc:GetISolenoidValve():SetValveMap(map)
        end,
        close = function()
            local curmap = dc:GetISolenoidValve():GetValveMap():GetData()
            local map = ValveMap.new(curmap & ~setting.liquidType.sample6.valve)
            dc:GetISolenoidValve():SetValveMap(map)
        end,
        status = false,
    },
    -- row 55
    {
        name = "AirValve",
        open = function()
            local curmap = dc:GetISolenoidValve():GetValveMap():GetData()
            local map = ValveMap.new(curmap | setting.liquidType.map.valve8)
            dc:GetISolenoidValve():SetValveMap(map)
        end,
        close = function()
            local curmap = dc:GetISolenoidValve():GetValveMap():GetData()
            local map = ValveMap.new(curmap & ~setting.liquidType.map.valve8)
            dc:GetISolenoidValve():SetValveMap(map)
        end,
        status = false,
    },
    -- row 56
    {
        name = "AirValve",
        open = function()
            local curmap = dc:GetISolenoidValve():GetValveMap():GetData()
            local map = ValveMap.new(curmap | setting.liquidType.map.valve9)
            dc:GetISolenoidValve():SetValveMap(map)
        end,
        close = function()
            local curmap = dc:GetISolenoidValve():GetValveMap():GetData()
            local map = ValveMap.new(curmap & ~setting.liquidType.map.valve9)
            dc:GetISolenoidValve():SetValveMap(map)
        end,
        status = false,
    },
    -- row 57
    {
        name = "AirValve",
        open = function()
            local curmap = dc:GetISolenoidValve():GetValveMap():GetData()
            local map = ValveMap.new(curmap | setting.liquidType.map.valve10)
            dc:GetISolenoidValve():SetValveMap(map)
        end,
        close = function()
            local curmap = dc:GetISolenoidValve():GetValveMap():GetData()
            local map = ValveMap.new(curmap & ~setting.liquidType.map.valve10)
            dc:GetISolenoidValve():SetValveMap(map)
        end,
        status = false,
    },
    -- row 58
    {
        name = "AirValve",
        open = function()
            local curmap = dc:GetISolenoidValve():GetValveMap():GetData()
            local map = ValveMap.new(curmap | setting.liquidType.map.valve11)
            dc:GetISolenoidValve():SetValveMap(map)
        end,
        close = function()
            local curmap = dc:GetISolenoidValve():GetValveMap():GetData()
            local map = ValveMap.new(curmap & ~setting.liquidType.map.valve11)
            dc:GetISolenoidValve():SetValveMap(map)
        end,
        status = false,
    },
    -- row 59
    {
        name = "StirPump",
        open = function()
            dc:GetIMotorControl():ExtraDeviceControl(0, 1)
        end,
        close = function()
            dc:GetIMotorControl():ExtraDeviceControl(0, 0)
        end,
        status = false,
    },
    -- row 60
    {
        name = "AirPump",
        open = function()
            dc:GetIMotorControl():ExtraDeviceControl(1, 1)
        end,
        close = function()
            dc:GetIMotorControl():ExtraDeviceControl(1, 0)
        end,
        status = false,
    },
    -- row 61
    {
        name = "WasteExposure",
        open = function()
            local curmap = dc:GetISolenoidValve():GetValveMap():GetData()
            local map = ValveMap.new(curmap | setting.liquidType.wasteExposure.valve)
            dc:GetISolenoidValve():SetValveMap(map)
        end,
        close = function()
            local curmap = dc:GetISolenoidValve():GetValveMap():GetData()
            local map = ValveMap.new(curmap & ~setting.liquidType.wasteExposure.valve)
            dc:GetISolenoidValve():SetValveMap(map)
        end,
        status = false,
    },
    -- row 62
    {
        name = "WasteDilute",
        open = function()
            local curmap = dc:GetISolenoidValve():GetValveMap():GetData()
            local map = ValveMap.new(curmap | setting.liquidType.wasteDilute.valve)
            dc:GetISolenoidValve():SetValveMap(map)
        end,
        close = function()
            local curmap = dc:GetISolenoidValve():GetValveMap():GetData()
            local map = ValveMap.new(curmap & ~setting.liquidType.wasteDilute.valve)
            dc:GetISolenoidValve():SetValveMap(map)
        end,
        status = false,
    },
    -- row 63
    {
        name = "CoolerWater",
        open = function()
            local curmap = dc:GetISolenoidValve():GetValveMap():GetData()
            local map = ValveMap.new(curmap | setting.liquidType.coolerWater.valve)
            dc:GetISolenoidValve():SetValveMap(map)
        end,
        close = function()
            local curmap = dc:GetISolenoidValve():GetValveMap():GetData()
            local map = ValveMap.new(curmap & ~setting.liquidType.coolerWater.valve)
            dc:GetISolenoidValve():SetValveMap(map)
        end,
        status = false,
    },
    -- row 64
    {
        name = "CoolerWaterIC",
        open = function()
            local curmap = dc:GetISolenoidValve():GetValveMap():GetData()
            local map = ValveMap.new(curmap | setting.liquidType.coolerWaterIC.valve)
            dc:GetISolenoidValve():SetValveMap(map)
        end,
        close = function()
            local curmap = dc:GetISolenoidValve():GetValveMap():GetData()
            local map = ValveMap.new(curmap & ~setting.liquidType.coolerWaterIC.valve)
            dc:GetISolenoidValve():SetValveMap(map)
        end,
        status = false,
    },
    -- row 65
    {
        name = "ExPump1",
        open = function()
            local pump = pumps[setting.liquidType.exSampleIn1.pump + 1]
            local acceleration = 0.5
            local drainSpeed = 0.2
            local motionParam = ExMotionParam.new()
            motionParam:SetAcceleration(acceleration)
            motionParam:SetSpeed(drainSpeed)
            log:debug("[重设泵参数]： Set Speed " .. drainSpeed .. ", Set Acceleration " .. acceleration)
            lc:GetIExtPeristalticPump():SetMotionParam(0, motionParam)
            --motionParam =  lc:GetIExtPeristalticPump():GetMotionParam(0)
            --print("Speed " .. motionParam:GetSpeed() .. ", Acceleration " .. motionParam:GetAcceleration())
            pump:Start(RollDirection.Drain, 1000000, 0.5)
        end,
        close = function()
            local pump = pumps[setting.liquidType.exSampleIn1.pump + 1]
            pump:Stop()
        end,
        status = false,
    },
    -- row 66
    {
        name = "ExPump2",
        open = function()
            local pump = pumps[setting.liquidType.exSampleIn2.pump + 1]
            pump:Start(RollDirection.Drain, 1000000, 0.5)
        end,
        close = function()
            local pump = pumps[setting.liquidType.exSampleIn2.pump + 1]
            pump:Stop()
        end,
        status = false,
    },
    -- row 67
    {
        name = "ExPump3",
        open = function()
            local pump = pumps[setting.liquidType.exSampleIn3.pump + 1]
            pump:Start(RollDirection.Drain, 1000000, 0.5)
        end,
        close = function()
            local pump = pumps[setting.liquidType.exSampleIn3.pump + 1]
            pump:Stop()
        end,
        status = false,
    },
    -- row 68
    {
        name = "ExPump4",
        open = function()
            local pump = pumps[setting.liquidType.exSampleIn4.pump + 1]
            pump:Start(RollDirection.Drain, 1000000, 0.5)
        end,
        close = function()
            local pump = pumps[setting.liquidType.exSampleIn4.pump + 1]
            pump:Stop()
        end,
        status = false,
    },
    -- row 69
    {
        name = "ExPump5",
        open = function()
            local pump = pumps[setting.liquidType.exSampleIn5.pump + 1]
            pump:Start(RollDirection.Drain, 1000000, 0.5)
        end,
        close = function()
            local pump = pumps[setting.liquidType.exSampleIn5.pump + 1]
            pump:Stop()
        end,
        status = false,
    },
    -- row 70
    {
        name = "ExPump6",
        open = function()
            local pump = pumps[setting.liquidType.exSampleIn6.pump + 1]
            pump:Start(RollDirection.Drain, 1000000, 0.5)
        end,
        close = function()
            local pump = pumps[setting.liquidType.exSampleIn6.pump + 1]
            pump:Stop()
        end,
        status = false,
    },
    -- row 71
    {
        name = "ExPump7",
        open = function()
            local pump = pumps[setting.liquidType.exSampleOut1.pump + 1]
            pump:Start(RollDirection.Drain, 1000000, 0.5)
        end,
        close = function()
            local pump = pumps[setting.liquidType.exSampleOut1.pump + 1]
            pump:Stop()
        end,
        status = false,
    },
    -- row 72
    {
        name = "ExPump8",
        open = function()
            local pump = pumps[setting.liquidType.exSampleOut2.pump + 1]
            pump:Start(RollDirection.Drain, 1000000, 0.5)
        end,
        close = function()
            local pump = pumps[setting.liquidType.exSampleOut2.pump + 1]
            pump:Stop()
        end,
        status = false,
    },
    -- row 73
    {
        name = "ExPump9",
        open = function()
            local pump = pumps[setting.liquidType.exSampleOut3.pump + 1]
            pump:Start(RollDirection.Drain, 1000000, 0.5)
        end,
        close = function()
            local pump = pumps[setting.liquidType.exSampleOut3.pump + 1]
            pump:Stop()
        end,
        status = false,
    },
    -- row 74
    {
        name = "ExPump10",
        open = function()
            local pump = pumps[setting.liquidType.exSampleOut4.pump + 1]
            pump:Start(RollDirection.Drain, 1000000, 0.5)
        end,
        close = function()
            local pump = pumps[setting.liquidType.exSampleOut4.pump + 1]
            pump:Stop()
        end,
        status = false,
    },
    -- row 75
    {
        name = "ExPump11",
        open = function()
            local pump = pumps[setting.liquidType.exSampleOut5.pump + 1]
            pump:Start(RollDirection.Drain, 1000000, 0.5)
        end,
        close = function()
            local pump = pumps[setting.liquidType.exSampleOut5.pump + 1]
            pump:Stop()
        end,
        status = false,
    },
    -- row 76
    {
        name = "ExPump12",
        open = function()
            local pump = pumps[setting.liquidType.exSampleOut6.pump + 1]
            pump:Start(RollDirection.Drain, 1000000, 0.5)
        end,
        close = function()
            local pump = pumps[setting.liquidType.exSampleOut6.pump + 1]
            pump:Stop()
        end,
        status = false,
    },
    -- row 77
    {
        name = "ExValve1",
        open = function()
            local curmap = lc:GetIExtSolenoidValve():GetValveMap():GetData()
            local map = ExValveMap.new(curmap | setting.liquidType.exSampleIn1.valve)
            lc:GetIExtSolenoidValve():SetValveMap(map)
        end,
        close = function()
            local curmap = lc:GetIExtSolenoidValve():GetValveMap():GetData()
            local map = ExValveMap.new(curmap & ~setting.liquidType.exSampleIn1.valve)
            lc:GetIExtSolenoidValve():SetValveMap(map)
        end,
        status = false,
    },
    -- row 78
    {
        name = "ExValve2",
        open = function()
            local curmap = lc:GetIExtSolenoidValve():GetValveMap():GetData()
            local map = ExValveMap.new(curmap | setting.liquidType.exSampleIn2.valve)
            lc:GetIExtSolenoidValve():SetValveMap(map)
        end,
        close = function()
            local curmap = lc:GetIExtSolenoidValve():GetValveMap():GetData()
            local map = ExValveMap.new(curmap & ~setting.liquidType.exSampleIn2.valve)
            lc:GetIExtSolenoidValve():SetValveMap(map)
        end,
        status = false,
    },
    -- row 79
    {
        name = "ExValve3",
        open = function()
            local curmap = lc:GetIExtSolenoidValve():GetValveMap():GetData()
            local map = ExValveMap.new(curmap | setting.liquidType.exSampleIn3.valve)
            lc:GetIExtSolenoidValve():SetValveMap(map)
        end,
        close = function()
            local curmap = lc:GetIExtSolenoidValve():GetValveMap():GetData()
            local map = ExValveMap.new(curmap & ~setting.liquidType.exSampleIn3.valve)
            lc:GetIExtSolenoidValve():SetValveMap(map)
        end,
        status = false,
    },
    -- row 80
    {
        name = "ExValve4",
        open = function()
            local curmap = lc:GetIExtSolenoidValve():GetValveMap():GetData()
            local map = ExValveMap.new(curmap | setting.liquidType.exSampleIn4.valve)
            lc:GetIExtSolenoidValve():SetValveMap(map)
        end,
        close = function()
            local curmap = lc:GetIExtSolenoidValve():GetValveMap():GetData()
            local map = ExValveMap.new(curmap & ~setting.liquidType.exSampleIn4.valve)
            lc:GetIExtSolenoidValve():SetValveMap(map)
        end,
        status = false,
    },
    -- row 81
    {
        name = "ExValve5",
        open = function()
            local curmap = lc:GetIExtSolenoidValve():GetValveMap():GetData()
            local map = ExValveMap.new(curmap | setting.liquidType.exSampleIn5.valve)
            lc:GetIExtSolenoidValve():SetValveMap(map)
        end,
        close = function()
            local curmap = lc:GetIExtSolenoidValve():GetValveMap():GetData()
            local map = ExValveMap.new(curmap & ~setting.liquidType.exSampleIn5.valve)
            lc:GetIExtSolenoidValve():SetValveMap(map)
        end,
        status = false,
    },
    -- row 82
    {
        name = "ExValve6",
        open = function()
            local curmap = lc:GetIExtSolenoidValve():GetValveMap():GetData()
            local map = ExValveMap.new(curmap | setting.liquidType.exSampleIn6.valve)
            lc:GetIExtSolenoidValve():SetValveMap(map)
        end,
        close = function()
            local curmap = lc:GetIExtSolenoidValve():GetValveMap():GetData()
            local map = ExValveMap.new(curmap & ~setting.liquidType.exSampleIn6.valve)
            lc:GetIExtSolenoidValve():SetValveMap(map)
        end,
        status = false,
    },
}

function HardwareTest:execute(row, action)
    --	print("HardwareTest try execute "..row)

    local ret
    local err,result = pcall
    (
            function()
                if action == true then
                    --		print("HardwareTest try execute "..row.." open")
                    ret = HardwareTest[row].open()
                    --		print(ret)
                elseif action == false then
                    --		print("HardwareTest try execute "..row.." close")
                    ret = HardwareTest[row].close()
                end
            end
    )
    if not err then      -- 出现异常
        if type(result) == "userdata" then
            if result:GetType() == "CommandTimeoutException" then          --命令应答超时异常
                ExceptionHandler.MakeAlarm(result)
            else
                log:warn("HardwareTest:execute() =>" .. result:What())
            end
        elseif type(result) == "table" then
            log:warn("HardwareTest:execute() =>" .. result:What())								--其他定义类型异常
        elseif type(result) == "string" then
            log:warn("HardwareTest:execute() =>" .. result)	--C++、Lua系统异常
        end
        --		print("Action fail")
        return false     --操作未成功
    else
        if ret == false then
            --			print("operate conflict return")
            return false
        end

        if action == true then		-- 状态记录
            HardwareTest[row].status = true
        elseif action == false then
            HardwareTest[row].status = false
        end
        --		print("Action success")
        return true      --操作成功
    end
end
