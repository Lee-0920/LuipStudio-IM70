setting.ui.profile.componentParam =
{
    name = "componentParam",
    text = "组件参数",
    updateEvent = UpdateEvent.ChangeMeasureParam,
    index = 3,
    rowCount = 15,
    superRow = 0,
    administratorRow = 0,
    writePrivilege=  RoleType.Super,
    readPrivilege = RoleType.Super,
    isMeaParaml = true,
    {
        name = "stoveCell",
        text = "燃烧炉",
        {
            name = "stoveCell.pos",
            text = "水平位置",
            unit = "步",
            type = DataType.Int,
            writePrivilege=  RoleType.Super,
            readPrivilege = RoleType.Super,
            checkValue = function(value)
                if setting.ui.profile.measureParam.integerPattern(value) == true then
                    local num = tonumber(value)
                    if num < 0 or num > setting.motor.maxStepsX then
                        return string.format("%d", config.componentParam.stoveCell.pos)
                    else
                        return value
                    end
                else
                    return string.format("%d", config.componentParam.stoveCell.pos)
                end
            end,
        },
        {
            name = "stoveCell.side",
            text = "边界深度",
            unit = "步",
            type = DataType.Int,
            writePrivilege=  RoleType.Super,
            readPrivilege = RoleType.Super,
            checkValue = function(value)
                if setting.ui.profile.measureParam.integerPattern(value) == true then
                    local num = tonumber(value)
                    if num < 0 or num > setting.motor.maxStepsZ then
                        return string.format("%d", config.componentParam.stoveCell.side)
                    else
                        return value
                    end
                else
                    return string.format("%d", config.componentParam.stoveCell.side)
                end
            end,
        },
        {
            name = "stoveCell.bottom",
            text = "底部深度",
            unit = "步",
            type = DataType.Int,
            writePrivilege=  RoleType.Super,
            readPrivilege = RoleType.Super,
            checkValue = function(value)
                if setting.ui.profile.measureParam.integerPattern(value) == true then
                    local num = tonumber(value)
                    if num < 0 or num > setting.motor.maxStepsZ then
                        return string.format("%d", config.componentParam.stoveCell.bottom)
                    else
                        return value
                    end
                else
                    return string.format("%d", config.componentParam.stoveCell.bottom)
                end
            end,
        },
    },
    {
        name = "sampleMixer",
        text = "水样杯",
        {
            name = "sampleMixer.pos",
            text = "水平位置",
            unit = "步",
            type = DataType.Int,
            writePrivilege=  RoleType.Super,
            readPrivilege = RoleType.Super,
            checkValue = function(value)
                if setting.ui.profile.measureParam.integerPattern(value) == true then
                    local num = tonumber(value)
                    if num < 0 or num > setting.motor.maxStepsX then
                        return string.format("%d", config.componentParam.sampleMixer.pos)
                    else
                        return value
                    end
                else
                    return string.format("%d", config.componentParam.sampleMixer.pos)
                end
            end,
        },
        {
            name = "sampleMixer.side",
            text = "边界深度",
            unit = "步",
            type = DataType.Int,
            writePrivilege=  RoleType.Super,
            readPrivilege = RoleType.Super,
            checkValue = function(value)
                if setting.ui.profile.measureParam.integerPattern(value) == true then
                    local num = tonumber(value)
                    if num < 0 or num > setting.motor.maxCupStepsZ then
                        return string.format("%d", config.componentParam.sampleMixer.side)
                    else
                        return value
                    end
                else
                    return string.format("%d", config.componentParam.sampleMixer.side)
                end
            end,
        },
        {
            name = "sampleMixer.bottom",
            text = "底部深度",
            unit = "步",
            type = DataType.Int,
            writePrivilege=  RoleType.Super,
            readPrivilege = RoleType.Super,
            checkValue = function(value)
                if setting.ui.profile.measureParam.integerPattern(value) == true then
                    local num = tonumber(value)
                    if num < 0 or num > setting.motor.maxCupStepsZ then
                        return string.format("%d", config.componentParam.sampleMixer.bottom)
                    else
                        return value
                    end
                else
                    return string.format("%d", config.componentParam.sampleMixer.bottom)
                end
            end,
        },
    },
    {
        name = "exposureCell",
        text = "曝气池",
        {
            name = "exposureCell.pos",
            text = "水平位置",
            unit = "步",
            type = DataType.Int,
            writePrivilege=  RoleType.Super,
            readPrivilege = RoleType.Super,
            checkValue = function(value)
                if setting.ui.profile.measureParam.integerPattern(value) == true then
                    local num = tonumber(value)
                    if num < 0 or num > setting.motor.maxStepsX then
                        return string.format("%d", config.componentParam.exposureCell.pos)
                    else
                        return value
                    end
                else
                    return string.format("%d", config.componentParam.exposureCell.pos)
                end
            end,
        },
        {
            name = "exposureCell.side",
            text = "边界深度",
            unit = "步",
            type = DataType.Int,
            writePrivilege=  RoleType.Super,
            readPrivilege = RoleType.Super,
            checkValue = function(value)
                if setting.ui.profile.measureParam.integerPattern(value) == true then
                    local num = tonumber(value)
                    if num < 0 or num > setting.motor.maxCupStepsZ then
                        return string.format("%d", config.componentParam.exposureCell.side)
                    else
                        return value
                    end
                else
                    return string.format("%d", config.componentParam.exposureCell.side)
                end
            end,
        },
        {
            name = "exposureCell.bottom",
            text = "底部深度",
            unit = "步",
            type = DataType.Int,
            writePrivilege=  RoleType.Super,
            readPrivilege = RoleType.Super,
            checkValue = function(value)
                if setting.ui.profile.measureParam.integerPattern(value) == true then
                    local num = tonumber(value)
                    if num < 0 or num > setting.motor.maxCupStepsZ then
                        return string.format("%d", config.componentParam.exposureCell.bottom)
                    else
                        return value
                    end
                else
                    return string.format("%d", config.componentParam.exposureCell.bottom)
                end
            end,
        },
    },
    {
        name = "diluteCell",
        text = "稀释杯",
        {
            name = "diluteCell.pos",
            text = "水平位置",
            unit = "步",
            type = DataType.Int,
            writePrivilege=  RoleType.Super,
            readPrivilege = RoleType.Super,
            checkValue = function(value)
                if setting.ui.profile.measureParam.integerPattern(value) == true then
                    local num = tonumber(value)
                    if num < 0 or num > setting.motor.maxStepsX then
                        return string.format("%d", config.componentParam.diluteCell.pos)
                    else
                        return value
                    end
                else
                    return string.format("%d", config.componentParam.diluteCell.pos)
                end
            end,
        },
        {
            name = "diluteCell.side",
            text = "边界深度",
            unit = "步",
            type = DataType.Int,
            writePrivilege=  RoleType.Super,
            readPrivilege = RoleType.Super,
            checkValue = function(value)
                if setting.ui.profile.measureParam.integerPattern(value) == true then
                    local num = tonumber(value)
                    if num < 0 or num > setting.motor.maxCupStepsZ then
                        return string.format("%d", config.componentParam.diluteCell.side)
                    else
                        return value
                    end
                else
                    return string.format("%d", config.componentParam.diluteCell.side)
                end
            end,
        },
        {
            name = "diluteCell.bottom",
            text = "底部深度",
            unit = "步",
            type = DataType.Int,
            writePrivilege=  RoleType.Super,
            readPrivilege = RoleType.Super,
            checkValue = function(value)
                if setting.ui.profile.measureParam.integerPattern(value) == true then
                    local num = tonumber(value)
                    if num < 0 or num > setting.motor.maxCupStepsZ then
                        return string.format("%d", config.componentParam.diluteCell.bottom)
                    else
                        return value
                    end
                else
                    return string.format("%d", config.componentParam.diluteCell.bottom)
                end
            end,
        },
    },
    {
        name = "standardCell",
        text = "废液杯",
        {
            name = "standardCell.pos",
            text = "水平位置",
            unit = "步",
            type = DataType.Int,
            writePrivilege=  RoleType.Super,
            readPrivilege = RoleType.Super,
            checkValue = function(value)
                if setting.ui.profile.measureParam.integerPattern(value) == true then
                    local num = tonumber(value)
                    if num < 0 or num > setting.motor.maxStepsX then
                        return string.format("%d", config.componentParam.standardCell.pos)
                    else
                        return value
                    end
                else
                    return string.format("%d", config.componentParam.standardCell.pos)
                end
            end,
        },
        {
            name = "standardCell.side",
            text = "边界深度",
            unit = "步",
            type = DataType.Int,
            writePrivilege=  RoleType.Super,
            readPrivilege = RoleType.Super,
            checkValue = function(value)
                if setting.ui.profile.measureParam.integerPattern(value) == true then
                    local num = tonumber(value)
                    if num < 0 or num > setting.motor.maxCupStepsZ then
                        return string.format("%d", config.componentParam.standardCell.side)
                    else
                        return value
                    end
                else
                    return string.format("%d", config.componentParam.standardCell.side)
                end
            end,
        },
        {
            name = "standardCell.bottom",
            text = "底部深度",
            unit = "步",
            type = DataType.Int,
            writePrivilege=  RoleType.Super,
            readPrivilege = RoleType.Super,
            checkValue = function(value)
                if setting.ui.profile.measureParam.integerPattern(value) == true then
                    local num = tonumber(value)
                    if num < 0 or num > setting.motor.maxCupStepsZ then
                        return string.format("%d", config.componentParam.standardCell.bottom)
                    else
                        return value
                    end
                else
                    return string.format("%d", config.componentParam.standardCell.bottom)
                end
            end,
        },
    },
    defaultRestore = function(userType)

        if userType == RoleType.Super then
            local stovePos = config.componentParam.stoveCell.pos
            local defaultTable = ConfigLists.LoadComponentParamConfig(true)
            Helper.DefaultRestore(defaultTable, config.componentParam)

            config.componentParam.stoveCell.pos = stovePos

            log:info(setting.ui.profile.componentParam.text .. "恢复默认")
            config.modifyRecord.componentParam(true)
            ConfigLists.SaveComponentParamConfig()
        end

        return false  --无需重启仪器
    end,
    saveFile = function(isUpdate)
        log:info("修改" .. setting.ui.profile.componentParam.text)
        config.modifyRecord.componentParam(isUpdate)
        ConfigLists.SaveComponentParamConfig()

        return false  --无需重启仪器
    end,
    integerPattern = function(value)
        if type(value) == "string" then
            local ret = false
            local integerPattern = "^%d?%d?%d?%d?%d?%d$"
            if string.find(value, integerPattern) then
                ret = true
            end
            return ret
        else
            return false
        end
    end,
}
return setting.ui.profile.componentParam
