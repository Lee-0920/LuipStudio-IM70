setting.ui.profile.hardwareParamIterms =
{
    name = "hardwareParamIterms",
    text = "硬件校准",
    writePrivilege=  RoleType.Administrator,
    readPrivilege = RoleType.Administrator,
    rowCount = 39,
    superRow = 0,
    administratorRow = 39,
    index = 10,
    {
        name = "XMotorParam",
        text = "X轴电机参数",
        motorParam = MotorParam.new(),
        get = function()
            if dc:GetConnectStatus() then
                local status,result = pcall(function()
                    return dc:GetIMotorControl():GetMotorParam(0)
                end)
                if not status then
                    ExceptionHandler.MakeAlarm(result)
                    setting.ui.profile.hardwareParamIterms[1].motorParam:SetSpeed(0)
                    setting.ui.profile.hardwareParamIterms[1].motorParam:SetAcceleration(0)
                else
                    setting.ui.profile.hardwareParamIterms[1].motorParam = nil
                    setting.ui.profile.hardwareParamIterms[1].motorParam = result
                end
            else
                setting.ui.profile.hardwareParamIterms[1].motorParam:SetSpeed(0)
                setting.ui.profile.hardwareParamIterms[1].motorParam:SetAcceleration(0)
            end
        end,
        set = function()
            if dc:GetConnectStatus() then
                local status,result = pcall(function()
                    return dc:GetIMotorControl():SetMotorParam(0, setting.ui.profile.hardwareParamIterms[1].motorParam)
                end)
                if not status then
                    ExceptionHandler.MakeAlarm(result)
                    local text = "设置" .. setting.ui.profile.hardwareParamIterms[1].text .. "系数失败\n"
                    return false, text
                else
                    return true, ""
                end
            else
                local text = "驱动板连接断开,\n设置" .. setting.ui.profile.hardwareParamIterms[1].text .. "系数失败\n"
                return false, text
            end
        end,
        {
            name = "XPumpMaxSpeed",
            text = "最大速度",
            refData = "motorParam.motorX.speed",
            unit = "步/秒",
            get = function()
                return setting.ui.profile.hardwareParamIterms[1].motorParam:GetSpeed()
            end,
            checkValue = function(value)
                if setting.ui.profile.hardwareParamIterms.integerPattern(value) == true then
                    return value
                else
                    return string.format("%.0f",setting.ui.profile.hardwareParamIterms[1][1].get())
                end
            end,
            set = function(value)
                setting.ui.profile.hardwareParamIterms[1].motorParam:SetSpeed(value)
            end,
            writePrivilege=  RoleType.Super,
            readPrivilege = RoleType.Super,
        },
        {
            name = "XPumpAcceleration",
            text = "加速度",
            refData = "motorParam.motorX.acceleration",
            unit = "步/秒^2",
            get = function()
                return setting.ui.profile.hardwareParamIterms[1].motorParam:GetAcceleration()
            end,
            checkValue = function(value)
                if setting.ui.profile.hardwareParamIterms.integerPattern(value) == true then
                    return value
                else
                    return string.format("%.4f",setting.ui.profile.hardwareParamIterms[1][2].get())
                end
            end,
            set = function(value)
                setting.ui.profile.hardwareParamIterms[1].motorParam:SetAcceleration(value)
            end,
            writePrivilege=  RoleType.Super,
            readPrivilege = RoleType.Super,
        },
    },    
    autoTempCalibrate =
    {
        {
            name = "tempCalibrate1",
            text = "温度1",
            index = 0,
            unit = "℃",
            checkValue = function(value)
                if setting.ui.profile.hardwareParamIterms.manyDecimalPattern(value) == true then
                    return value
                else
                    return ""
                end
            end,
            calibrateFunc = function(index, value)
                if dc:GetConnectStatus() then
                    local err,ret = pcall(function()
                        local tempAD = 0
                        --for i=1,5 do
                        --    tempAD = tempAD + dc:GetStoveADValue()
                        --    App.Sleep(1000)
                        --end
                        tempAD = tempAD/5
                        log:debug("getad " .. tempAD)
                        config.hardwareConfig.twoPointTempCalibrate.firstTempAD = tempAD
                        config.hardwareConfig.twoPointTempCalibrate.firstTemp = value
                        return true
                    end)

                    if not err then      -- 出现异常
                        if type(ret) == "userdata" then
                            log:warn("TemperatureCalibrate() =>" .. ret:What())
                        elseif type(ret) == "table" then
                            log:warn("TemperatureCalibrate() =>" .. ret:What())
                        elseif type(ret) == "string" then
                            log:warn("TemperatureCalibrate() =>" .. ret)	--C++、Lua系统异常
                        end
                    end
                else
                    log:debug("驱动板未连接")
                end
            end
        },
        {
            name = "tempCalibrate2",
            text = "温度2",
            index = 1,
            unit = "℃",
            checkValue = function(value)
                if setting.ui.profile.hardwareParamIterms.manyDecimalPattern(value) == true then
                    return value
                else
                    return ""
                end
            end,
            calibrateFunc = function(index, value)
                if dc:GetConnectStatus() then
                    local err,ret = pcall(function()
                        local tempAD = 0
                        --for i=1,5 do
                        --    tempAD = tempAD + dc:GetStoveADValue()
                        --    App.Sleep(1000)
                        --end
                        tempAD = tempAD/5
                        log:debug("getad " .. tempAD)
                        config.hardwareConfig.twoPointTempCalibrate.secondTempAD = tempAD
                        config.hardwareConfig.twoPointTempCalibrate.secondTemp = value
                        return true
                    end)
                    if not err then      -- 出现异常
                        if type(ret) == "userdata" then
                            log:warn("TemperatureCalibrate() =>" .. ret:What())
                        elseif type(ret) == "table" then
                            log:warn("TemperatureCalibrate() =>" .. ret:What())
                        elseif type(ret) == "string" then
                            log:warn("TemperatureCalibrate() =>" .. ret)	--C++、Lua系统异常
                        end
                    end
                else
                    log:debug("驱动板未连接")
                end
            end
        },
    },
    exAutoTempCalibrate =
    {
        {
            name = "tempCalibrate",
            text = "制冷温度",
            index = 1,
            unit = "℃",
            checkValue = function(value)
                if setting.ui.profile.hardwareParamIterms.manyDecimalPattern(value) == true then
                    return value
                else
                    return ""
                end
            end,
            calibrateFunc = function(index, value)
                if dc:GetConnectStatus() then
                    local tempCalibrate = TempCalibrateFactor.new()

                    local status,result = pcall(function()
                        return dc:GetITemperatureControl():GetCalibrateFactorForTOC(index)
                    end)

                    if not status then
                        ExceptionHandler.MakeAlarm(result)
                        return false
                    else
                        tempCalibrate = nil
                        tempCalibrate = result
                    end

                    local offsetFactor = 0.01
                    local startNegativeInput = result:GetNegativeInput()
                    local setNegativeInput = startNegativeInput - offsetFactor
                    local startTemperature = 0
                    local reviseTemperature = 0
                    local temperatureFactor
                    local temperatureTolerance = 1.5
                    for i=1,5 do
                        startTemperature = startTemperature + dc:GetReportThermostatTemp(setting.temperature.temperatureRefrigerator)
                        App.Sleep(1000)
                    end
                    startTemperature = startTemperature / 5
                    if value > startTemperature  then
                        setNegativeInput = startNegativeInput - offsetFactor
                    else
                        setNegativeInput = startNegativeInput + offsetFactor
                    end
                    tempCalibrate:SetNegativeInput(setNegativeInput)
                    log:debug("targetTemperature " .. value .. ", startTemperature " .. startTemperature .. ", startNegativeInput "  .. startNegativeInput .. ", setNegativeInput " .. setNegativeInput)

                    local status,result = pcall(function()
                        return dc:GetITemperatureControl():SetCalibrateFactorForTOC(index, tempCalibrate)
                    end)
                    if not status then
                        ExceptionHandler.MakeAlarm(result)
                        return false, "设置温度校准系数失败\n"
                    else
                        App.Sleep(1000)
                        for i=1,5 do
                            reviseTemperature = reviseTemperature + dc:GetReportThermostatTemp(setting.temperature.temperatureRefrigerator)
                            App.Sleep(1000)
                        end
                        reviseTemperature = reviseTemperature / 5

                        temperatureFactor = offsetFactor / (math.abs(reviseTemperature - startTemperature))

                        offsetFactor = temperatureFactor * (math.abs(value - startTemperature))

                        if value > startTemperature then
                            setNegativeInput = startNegativeInput - offsetFactor
                        else
                            setNegativeInput = startNegativeInput + offsetFactor
                        end
                        tempCalibrate:SetNegativeInput(setNegativeInput)
                        log:debug("reviseTemperature " .. reviseTemperature .. ", setNegativeInput " .. setNegativeInput .. ", factor " .. offsetFactor)

                        local status,result = pcall(function()
                            return dc:GetITemperatureControl():SetCalibrateFactorForTOC(index, tempCalibrate)
                        end)
                        App.Sleep(1000)
                        if not status then
                            ExceptionHandler.MakeAlarm(result)
                            return false, "设置温度校准系数失败\n"
                        else
                            reviseTemperature = 0
                            for i=1,5 do
                                reviseTemperature = reviseTemperature + dc:GetReportThermostatTemp(setting.temperature.temperatureRefrigerator)
                                App.Sleep(1000)
                            end

                            reviseTemperature = reviseTemperature / 5
                            if math.abs(value - reviseTemperature) < temperatureTolerance then
                                return true
                            else
                                return false
                            end
                        end
                    end

                else
                    log:debug("驱动板未连接")
                end
            end,
        },
        {
            name = "NDIRTempCalibrate",
            text = "测量池1温度",
            tempCalibrate = TempCalibrateFactor.new(),
            index = 2,
            unit = "℃",
            checkValue = function(value)
                if setting.ui.profile.hardwareParamIterms.manyDecimalPattern(value) == true then
                    return value
                else
                    return ""
                end
            end,
            calibrateFunc = function(index, value)
                if dc:GetConnectStatus() then
                    local tempCalibrate = TempCalibrateFactor.new()

                    local status,result = pcall(function()
                        return dc:GetITemperatureControl():GetCalibrateFactorForTOC(index)
                    end)

                    if not status then
                        ExceptionHandler.MakeAlarm(result)
                        return false
                    else
                        tempCalibrate = nil
                        tempCalibrate = result
                    end

                    local offsetFactor = 0.01
                    local startNegativeInput = result:GetNegativeInput()
                    local setNegativeInput = startNegativeInput - offsetFactor
                    local startTemperature = 0
                    local reviseTemperature = 0
                    local temperatureFactor
                    local temperatureTolerance = 1.5
                    for i=1,5 do
                        startTemperature = startTemperature + dc:GetReportThermostatTemp(setting.temperature.temperatureLNDIR)
                        App.Sleep(1000)
                    end
                    startTemperature = startTemperature / 5
                    if value > startTemperature  then
                        setNegativeInput = startNegativeInput - offsetFactor
                    else
                        setNegativeInput = startNegativeInput + offsetFactor
                    end
                    tempCalibrate:SetNegativeInput(setNegativeInput)
                    log:debug("targetTemperature " .. value .. ", startTemperature " .. startTemperature .. ", startNegativeInput "  .. startNegativeInput .. ", setNegativeInput " .. setNegativeInput)

                    local status,result = pcall(function()
                        return dc:GetITemperatureControl():SetCalibrateFactorForTOC(index, tempCalibrate)
                    end)
                    if not status then
                        ExceptionHandler.MakeAlarm(result)
                        return false, "设置温度校准系数失败\n"
                    else
                        App.Sleep(1000)
                        for i=1,5 do
                            reviseTemperature = reviseTemperature + dc:GetReportThermostatTemp(setting.temperature.temperatureLNDIR)
                            App.Sleep(1000)
                        end
                        reviseTemperature = reviseTemperature / 5

                        temperatureFactor = offsetFactor / (math.abs(reviseTemperature - startTemperature))

                        offsetFactor = temperatureFactor * (math.abs(value - startTemperature))

                        if value > startTemperature then
                            setNegativeInput = startNegativeInput - offsetFactor
                        else
                            setNegativeInput = startNegativeInput + offsetFactor
                        end
                        tempCalibrate:SetNegativeInput(setNegativeInput)
                        log:debug("reviseTemperature " .. reviseTemperature .. ", setNegativeInput " .. setNegativeInput .. ", factor " .. offsetFactor)

                        local status,result = pcall(function()
                            return dc:GetITemperatureControl():SetCalibrateFactorForTOC(index, tempCalibrate)
                        end)
                        App.Sleep(1000)
                        if not status then
                            ExceptionHandler.MakeAlarm(result)
                            return false, "设置温度校准系数失败\n"
                        else
                            reviseTemperature = 0
                            for i=1,5 do
                                reviseTemperature = reviseTemperature + dc:GetReportThermostatTemp(setting.temperature.temperatureLNDIR)
                                App.Sleep(1000)
                            end

                            reviseTemperature = reviseTemperature / 5
                            if math.abs(value - reviseTemperature) < temperatureTolerance then
                                return true
                            else
                                return false
                            end
                        end
                    end

                else
                    log:debug("驱动板未连接")
                end
            end,
        },
        {
            name = "NDIRTempCalibrate",
            text = "测量池2温度",
            tempCalibrate = TempCalibrateFactor.new(),
            index = 3,
            unit = "℃",
            checkValue = function(value)
                if setting.ui.profile.hardwareParamIterms.manyDecimalPattern(value) == true then
                    return value
                else
                    return ""
                end
            end,
            calibrateFunc = function(index, value)
                if dc:GetConnectStatus() then
                    local tempCalibrate = TempCalibrateFactor.new()

                    local status,result = pcall(function()
                        return dc:GetITemperatureControl():GetCalibrateFactorForTOC(index)
                    end)

                    if not status then
                        ExceptionHandler.MakeAlarm(result)
                        return false
                    else
                        tempCalibrate = nil
                        tempCalibrate = result
                    end

                    local offsetFactor = 0.01
                    local startNegativeInput = result:GetNegativeInput()
                    local setNegativeInput = startNegativeInput - offsetFactor
                    local startTemperature = 0
                    local reviseTemperature = 0
                    local temperatureFactor
                    local temperatureTolerance = 1.5
                    for i=1,5 do
                        startTemperature = startTemperature + dc:GetReportThermostatTemp(setting.temperature.temperatureSNDIR)
                        App.Sleep(1000)
                    end
                    startTemperature = startTemperature / 5
                    if value > startTemperature  then
                        setNegativeInput = startNegativeInput - offsetFactor
                    else
                        setNegativeInput = startNegativeInput + offsetFactor
                    end
                    tempCalibrate:SetNegativeInput(setNegativeInput)
                    log:debug("targetTemperature " .. value .. ", startTemperature " .. startTemperature .. ", startNegativeInput "  .. startNegativeInput .. ", setNegativeInput " .. setNegativeInput)

                    local status,result = pcall(function()
                        return dc:GetITemperatureControl():SetCalibrateFactorForTOC(index, tempCalibrate)
                    end)
                    if not status then
                        ExceptionHandler.MakeAlarm(result)
                        return false, "设置温度校准系数失败\n"
                    else
                        App.Sleep(1000)
                        for i=1,5 do
                            reviseTemperature = reviseTemperature + dc:GetReportThermostatTemp(setting.temperature.temperatureSNDIR)
                            App.Sleep(1000)
                        end
                        reviseTemperature = reviseTemperature / 5

                        temperatureFactor = offsetFactor / (math.abs(reviseTemperature - startTemperature))

                        offsetFactor = temperatureFactor * (math.abs(value - startTemperature))

                        if value > startTemperature then
                            setNegativeInput = startNegativeInput - offsetFactor
                        else
                            setNegativeInput = startNegativeInput + offsetFactor
                        end
                        tempCalibrate:SetNegativeInput(setNegativeInput)
                        log:debug("reviseTemperature " .. reviseTemperature .. ", setNegativeInput " .. setNegativeInput .. ", factor " .. offsetFactor)

                        local status,result = pcall(function()
                            return dc:GetITemperatureControl():SetCalibrateFactorForTOC(index, tempCalibrate)
                        end)
                        App.Sleep(1000)
                        if not status then
                            ExceptionHandler.MakeAlarm(result)
                            return false, "设置温度校准系数失败\n"
                        else
                            reviseTemperature = 0
                            for i=1,5 do
                                reviseTemperature = reviseTemperature + dc:GetReportThermostatTemp(setting.temperature.temperatureSNDIR)
                                App.Sleep(1000)
                            end

                            reviseTemperature = reviseTemperature / 5
                            if math.abs(value - reviseTemperature) < temperatureTolerance then
                                return true
                            else
                                return false
                            end
                        end
                    end

                else
                    log:debug("驱动板未连接")
                end
            end,
        },
        {
            name = "fanUpTempCalibrate",
            text = "机箱温度",
            tempCalibrate = TempCalibrateFactor.new(),
            index = 5,
            unit = "℃",
            checkValue = function(value)
                if setting.ui.profile.hardwareParamIterms.manyDecimalPattern(value) == true then
                    return value
                else
                    return ""
                end
            end,
            calibrateFunc = function(index, value)
                if dc:GetConnectStatus() then
                    local tempCalibrate = TempCalibrateFactor.new()

                    local status,result = pcall(function()
                        return dc:GetITemperatureControl():GetCalibrateFactorForTOC(index)
                    end)

                    if not status then
                        ExceptionHandler.MakeAlarm(result)
                        return false
                    else
                        tempCalibrate = nil
                        tempCalibrate = result
                    end

                    local offsetFactor = 0.01
                    local startNegativeInput = result:GetNegativeInput()
                    local setNegativeInput
                    local startTemperature = 0
                    local reviseTemperature = 0
                    local temperatureFactor
                    local temperatureTolerance = 1.5
                    for i=1,5 do
                        startTemperature = startTemperature + dc:GetReportThermostatTemp(setting.temperature.temperatureInsideBox)
                        App.Sleep(1000)
                    end
                    startTemperature = startTemperature / 5
                    if value > startTemperature  then
                        setNegativeInput = startNegativeInput - offsetFactor
                    else
                        setNegativeInput = startNegativeInput + offsetFactor
                    end
                    tempCalibrate:SetNegativeInput(setNegativeInput)
                    log:debug("targetTemperature " .. value .. ", startTemperature " .. startTemperature .. ", startNegativeInput "  .. startNegativeInput .. ", setNegativeInput " .. setNegativeInput)

                    local status,result = pcall(function()
                        return dc:GetITemperatureControl():SetCalibrateFactorForTOC(index, tempCalibrate)
                    end)
                    if not status then
                        ExceptionHandler.MakeAlarm(result)
                        return false, "设置温度校准系数失败\n"
                    else
                        App.Sleep(1000)
                        for i=1,5 do
                            reviseTemperature = reviseTemperature + dc:GetReportThermostatTemp(setting.temperature.temperatureInsideBox)
                            App.Sleep(1000)
                        end
                        reviseTemperature = reviseTemperature / 5

                        temperatureFactor = offsetFactor / (math.abs(reviseTemperature - startTemperature))

                        offsetFactor = temperatureFactor * (math.abs(value - startTemperature))

                        if value > startTemperature then
                            setNegativeInput = startNegativeInput - offsetFactor
                        else
                            setNegativeInput = startNegativeInput + offsetFactor
                        end
                        tempCalibrate:SetNegativeInput(setNegativeInput)
                        log:debug("reviseTemperature " .. reviseTemperature .. ", setNegativeInput " .. setNegativeInput .. ", factor " .. offsetFactor)

                        local status,result = pcall(function()
                            return dc:GetITemperatureControl():SetCalibrateFactorForTOC(index, tempCalibrate)
                        end)
                        App.Sleep(1000)
                        if not status then
                            ExceptionHandler.MakeAlarm(result)
                            return false, "设置温度校准系数失败\n"
                        else
                            reviseTemperature = 0
                            for i=1,5 do
                                reviseTemperature = reviseTemperature + dc:GetReportThermostatTemp(setting.temperature.temperatureInsideBox)
                                App.Sleep(1000)
                            end

                            reviseTemperature = reviseTemperature / 5
                            if math.abs(value - reviseTemperature) < temperatureTolerance then
                                return true
                            else
                                return false
                            end
                        end
                    end

                else
                    log:debug("驱动板未连接")
                end
            end,
        },
    },
    manyDecimalPattern = function(value)
        if type(value) == "string" then
            local ret = false
            local decimalPatterm = "^%d?%d?%d%.%d%d?%d?%d?%d?%d?%d?%d?$"
            local integerPatterm = "^%d?%d?%d$"
            if not string.find(value, decimalPatterm) then
                if string.find(value, integerPatterm) then
                    ret = true
                end
            else
                ret = true
            end
            return ret
        else
            return false
        end
    end,
    twoDecimalPattern = function(value)
        if type(value) == "string" then
            local ret = false
            local decimalPatterm = "^%d?%d?%d%.%d%d?$"
            local integerPatterm = "^%d?%d?%d$"
            if not string.find(value, decimalPatterm) then
                if string.find(value, integerPatterm) then
                    ret = true
                end
            else
                ret = true
            end
            return ret
        else
            return false
        end
    end,
    threeDecimalPattern = function(value)
        if type(value) == "string" then
            local ret = false
            local decimalPatterm = "^%d?%d?%d%.%d%d?%d?$"
            local integerPatterm = "^%d?%d?%d$"
            if not string.find(value, decimalPatterm) then
                if string.find(value, integerPatterm) then
                    ret = true
                end
            else
                ret = true
            end
            return ret
        else
            return false
        end
    end,
    integerPattern = function(value)
        if type(value) == "string" then
            local ret = false
            local integerPatterm = "^%d?%d?%d?%d$"
            if string.find(value, integerPatterm) then
                ret = true
            end
            return ret
        else
            return false
        end
    end,
    electricPattern = function(value)
        if type(value) == "string" then
            local ret = false
            local decimalPatterm = "^[-+]?%d?%d?%d?%d%.%d%d?$"
            local integerPatterm = "^[-+]?%d?%d?%d?%d$"
            if not string.find(value, decimalPatterm) then
                if string.find(value, integerPatterm) then
                    ret = true
                end
            else
                ret = true
            end
            return ret
        else
            return false
        end
    end,
    synchronize = function()
        
    end,
    backupParam = function()
        
    end,
}
