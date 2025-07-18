package.path = [[?;?.lua;?.ls;?;./SP/Controller/?.ls;./SP/Flow/?.ls;./SP/Common/?.ls;./SP/ExternalInterface/?.ls;]]
require("ControllerCreater")
require("FlowList")
require("Flow")
require("MeasureAD")
require("Measurer")
require("MeasureFlow")
require("CalibrateFlow")
require("CleanFlow")
require("SmartMeasureDetectFlow")
require("SmartHeatDetectFlow")
require("SmartCoolDetectFlow")
require("LiquidOperateFlow")
require("CombineOperateFlow")
require("CollectSampleFlow")
require("HardwareTest")
require("CommunicationCheckFlow")
require("ADAdjustFlow")
require("ModbusInterface")
require("Hj212Interface")
require("SensorCheckFlow")
require("MotorOperateFlow")
package.path = [[?;?.lua;?.ls;?;./SP/Setting/?.ls;./SP/Setting/Modbus/?.ls;./SP/Setting/Hj212/?.ls;]]
setting.externalInterface = {}

if config.system.modbusTableType == 0 then
    require("Labsun10")
    modbusStr = "LS1.0"
elseif config.system.modbusTableType == 1 then
    require("JS")
    modbusStr = "JS"
else
    require("DBS")
    modbusStr = "DBS1.0"
end

if config.system.hj212Platform.hj212Type == 1 then
    require("Hj212CCEP")        -- CCEP认证协议
elseif config.system.hj212Platform.hj212Type == 2 then
    require("Hj212")            -- 咸阳(HJ212-2017-Wry)
end


function InitHj212()
    if  (config.system.hj212Platform.hj212Type == 1 or config.system.hj212Platform.hj212Type == 2) and
            nil ~= setting.externalInterface.hj212.InitHj212 then

        setting.externalInterface.hj212.InitHj212()
    end
end

--[[
 *@brief 初始化界面中用户自定义的配置
--]]
function InitWidgetUserConfig()
    RefreshRangeMapping()
end


--[[
 *@brief 初始化设备,界面创建之后
--]]
function InitInstrument()
    status.running.isCorrectStopFlow = true
    ConfigLists.SaveMeasureRunning()

    status.measure.isCheckBaseLine = false
    ConfigLists.SaveMeasureStatus()   
end

--[[
 *@brief 机箱自动温控开关  dc:GetISolenoidValve():ProportionalValve_AutoControlPressure(true)
--]]
function BoxAutoEnvironmentalControl()
    local temperatureMonitor = config.system.temperatureMonitor
    local err = pcall(function()
        dc:SetBoxFanEnable(temperatureMonitor)
        if temperatureMonitor == true then
            log:debug("上机箱温控设置温度：" .. config.system.environmentTemperature)
            log:debug("下机箱温控设置温度：" .. config.system.exEnvironmentTemperature)
        end
    end)
    if not err then
        log:warn("设置机箱风扇自动散热功能==>失败" .. "SetBoxFanEnable(true)" .. " failed.")
    end
end


--[[
 *@brief 温度控制
--]]
function ThermostatControl()
    local err = pcall(function()
        App.Sleep(200)
        op:ReviseThermostatTemp(setting.temperature.indexStove, ThermostatMode.Heater, config.measureParam.reactTemperature, setting.temperature.toleranceTemp, setting.temperature.digestTempTimeout)
        App.Sleep(200)
        op:ReviseThermostatTemp(setting.temperature.indexRefrigerator, ThermostatMode.Refrigerate, config.measureParam.coolTemperature, setting.temperature.coolToleranceTemp, setting.temperature.coolTempTimeout)
        App.Sleep(200)
        local NDIRTemp = dc:GetReportThermostatTemp(setting.temperature.temperatureLNDIR)
        if math.abs(config.measureParam.measureModuleTemperature-NDIRTemp) > 1 then
            op:ReviseThermostatTemp(setting.temperature.indexLNDIR, ThermostatMode.Heater, config.measureParam.measureModuleTemperature, setting.temperature.NDIRToleranceTemp, setting.temperature.NDIRTempTimeout)
        end
        NDIRTemp = dc:GetReportThermostatTemp(setting.temperature.temperatureSNDIR)
        if math.abs(config.measureParam.measureModuleTemperature-NDIRTemp) > 1 then
            op:ReviseThermostatTemp(setting.temperature.indexSNDIR, ThermostatMode.Heater, config.measureParam.measureModuleTemperature, setting.temperature.NDIRToleranceTemp, setting.temperature.NDIRTempTimeout)
        end
        op:ExposureTurnOff()
        op:TurnOffNirtrogen()
        dc:GetIOpticalAcquire():TurnOffLED(setting.LED.LMeaIndex)	--关LED
        dc:GetIOpticalAcquire():TurnOffLED(setting.LED.SMeaIndex)	--关LED
        dc:ClearBuf()--清buf,防止数组刷新
        dc:ClearExBuf()--清buf,防止数组刷新
    end)
    if not err then
        --log:warn("试剂二切换备用阀开关启动设置失败 =>")
    end
end

--[[
 *@brief 载气压力智能温控调节
--]]
function PressureAutoEnvironmentalControl()
    local carryPressureOffset = config.system.carryPressureOffset
    local err = pcall(function()
        dc:GetISolenoidValve():ProportionalValve_AutoControlPressure(carryPressureOffset)
        if carryPressureOffset == true then
            log:debug("载气压力补偿： " .. "打开")
        else
            log:debug("载气压力补偿： " .. "关闭")
        end
    end)
    if not err then
        log:warn("设置载气压力智能调节==>失败")
    end
end

--[[
 *@brief 量程映射刷新
--]]
function RefreshRangeMapping()
    for _,v in ipairs(_G.setting.ui.profile.measureParam) do
        for _,k in ipairs(v) do
            if DataType.Option == k.type and nil ~= k.UpdateOptions then
                k.UpdateOptions()
            end
        end
    end

    _G.setting.ui.curve.UpdateCurve()
end


function UpdateMeasureTimeStatus(oldTime)
	
	print("oldTime = " .. oldTime)
	
    local err,ret = pcall(function()
		local currTime = os.time()		
		print("currTime = " .. currTime)
		
		status.measure.schedule.autoMeasure.dateTime = currTime - (oldTime - status.measure.schedule.autoMeasure.dateTime)
        status.measure.schedule.autoMeasureChannelTwo.dateTime = currTime - (oldTime - status.measure.schedule.autoMeasureChannelTwo.dateTime)
        status.measure.schedule.autoMeasureChannelThree.dateTime = currTime - (oldTime - status.measure.schedule.autoMeasureChannelThree.dateTime)
        status.measure.schedule.autoMeasureChannelFour.dateTime = currTime - (oldTime - status.measure.schedule.autoMeasureChannelFour.dateTime)
        status.measure.schedule.autoMeasureChannelFive.dateTime = currTime - (oldTime - status.measure.schedule.autoMeasureChannelFive.dateTime)
        status.measure.schedule.autoMeasureChannelSix.dateTime = currTime - (oldTime - status.measure.schedule.autoMeasureChannelSix.dateTime)
        local interval = os.date("*t", currTime).day - os.date("*t", oldTime).day
        if MeasureMode.Timed ~= config.scheduler.calibrate.mode then
            status.measure.schedule.autoCalibrate.dateTime = currTime - (oldTime - status.measure.schedule.autoCalibrate.dateTime)
        elseif MeasureMode.Timed == config.scheduler.calibrate.mode and 0 ~= interval then
            local lastCalibrateDateTime = os.date("*t", status.measure.schedule.autoCalibrate.dateTime)
            lastCalibrateDateTime.day = lastCalibrateDateTime.day + interval
            status.measure.schedule.autoCalibrate.dateTime = os.time(lastCalibrateDateTime)
        end
		status.measure.schedule.autoClean.dateTime = currTime - (oldTime - status.measure.schedule.autoClean.dateTime)
		status.measure.schedule.autoCheck.dateTime = currTime - (oldTime - status.measure.schedule.autoCheck.dateTime)
        status.measure.schedule.autoBlankCheck.dateTime = currTime - (oldTime - status.measure.schedule.autoBlankCheck.dateTime)
        status.measure.schedule.zeroCheck.dateTime = currTime - (oldTime - status.measure.schedule.zeroCheck.dateTime)
        status.measure.schedule.rangeCheck.dateTime = currTime - (oldTime - status.measure.schedule.rangeCheck.dateTime)
        status.measure.schedule.autoAddstandard.dateTime = currTime - (oldTime - status.measure.schedule.autoAddstandard.dateTime)
        status.measure.schedule.autoParallel.dateTime = currTime - (oldTime - status.measure.schedule.autoParallel.dateTime)
        status.measure.schedule.autoDrainFromRefrigerator.dateTime = currTime - (oldTime - status.measure.schedule.autoDrainFromRefrigerator.dateTime)

		ConfigLists.SaveMeasureStatus()
        config.scheduler.calibrate.configChangeTime = currTime - (oldTime - config.scheduler.calibrate.configChangeTime)
        ConfigLists.SaveSchedulerConfig()
		
        return true
    end)

    if not err then      -- 出现异常
        if type(ret) == "userdata" then
            log:warn("UpdateMeasureTimeStatus() =>" .. ret:What())
        elseif type(ret) == "table" then
            log:warn("UpdateMeasureTimeStatus() =>" .. ret:What())
        elseif type(ret) == "string" then
            log:warn("UpdateMeasureTimeStatus() =>" .. ret)	--C++、Lua系统异常
        end
    end
end

