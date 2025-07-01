setting.ui.profile = {}
setting.ui.profile.measureParam =
{
    name = "measureParam",
    text = "测量参数",
    updateEvent = UpdateEvent.ChangeMeasureParam,
    index = 2,
    rowCount = 54,
    superRow = 27,
    administratorRow = 27,
    writePrivilege=  RoleType.Maintain,
    readPrivilege = RoleType.Maintain,
    isMeaParaml = true,
    -- 1
    {
        name = "channel",
        text = "通道配置",
        {
            name = "measureType",
            text = "坐标选择",
            type = DataType.Option,
            writePrivilege = RoleType.Maintain,
            readPrivilege = RoleType.Maintain,
            --targetPrivilege = Target.ChannelOne,
            options = {
                "绝对坐标",
                "相对坐标",
                "增量坐标",                
            },
        },
         {
            name = "xpos",
            text = "x坐标",
            unit = "PUU",
            type = DataType.Int,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
            checkValue = function(value)                
                if type(value) == "string" then
                    local integerPatterm = "^[-+]?%d?%d?%d?%d$"
                    if string.find(value, integerPatterm) then
                        local num = tonumber(value)
                        ret = true
                    end
                else
                    return string.format("%.0f", config.measureParam.xpos)
                end
                return value
            end,
        },
        {
            name = "ypos",
            text = "y坐标",
            unit = "PUU",
            type = DataType.Int,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
            checkValue = function(value)                
                if type(value) == "string" then
                    local integerPatterm = "^[-+]?%d?%d?%d?%d$"
                    if string.find(value, integerPatterm) then
                        local num = tonumber(value)
                        ret = true
                    end
                else
                    return string.format("%.0f", config.measureParam.ypos)
                end
                return value
            end,
        },
        {
            name = "zpos",
            text = "z坐标",
            unit = "PUU",
            type = DataType.Int,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
            checkValue = function(value)                
                if type(value) == "string" then
                    local integerPatterm = "^[-+]?%d?%d?%d?%d$"
                    if string.find(value, integerPatterm) then
                        local num = tonumber(value)
                        ret = true
                    end
                else
                    return string.format("%.0f", config.measureParam.zpos)
                end
                return value
            end,
        },
    },
    -- 1
    {
        name = "range",
        text = "量程切换",
        {
            name = "autoChangeRange",
            text = "量程自动切换",
            type = DataType.Bool,
            rangConfig = true,
            writePrivilege = RoleType.Maintain,
            readPrivilege = RoleType.Maintain,
        },
        {
            name = "activeRangeMode",
            text = "切换后生效模式",
            type = DataType.Option,
            rangConfig = true,
            writePrivilege = RoleType.Maintain,
            readPrivilege = RoleType.Maintain,
            options = {
                "立即生效",
                "下次生效",
            },
        },
    },
    {
        name = "currentRangeParam",
        text = "当前量程信息",
        {
            name = "curveParam[1].curveK",
            text = "TC斜率",
            type = DataType.Double,
            unit = setting.measureResult.curve[1].curveKLowLimit.."~"..setting.measureResult.curve[1].curveKUpLimit,
            rangeParamStart = true,
            writePrivilege=  RoleType.Super,
            readPrivilege = RoleType.Maintain,
            currentValue = nil,
            checkValue = function(value)
                if setting.ui.profile.measureParam.fourDecimalWithNegativePattern(value) == true then
                    setting.ui.profile.measureParam[3][1].currentValue = tonumber(value)
                    return value
                else
                    local retK = config.measureParam.curveK
                    local retB = config.measureParam.curveB
                    retK, retB = CurveParamCurveXYChange(retK, retB)
                    setting.ui.profile.measureParam[3][1].currentValue = retK
                    return string.format("%.6f", retK)
                end
            end,
            curveParamCurveXYChange = function(value, isUpdateCurrentValue)
                local retK = value
                local retB = config.measureParam.curveB
                if setting.ui.profile.measureParam[3][2].currentValue ~= nil and isUpdateCurrentValue == false then
                    retB = setting.ui.profile.measureParam[3][2].currentValue
                end

                retK, retB = CurveParamCurveXYChange(retK, retB)
                if isUpdateCurrentValue == true then
                    setting.ui.profile.measureParam[3][1].currentValue = retK
                else
                    -- 必须在函数checkValue更新，此时是原始值
                end
                return retK
            end,
        },
        {
            name = "curveParam[1].curveB",
            text = "TC截距",
            type = DataType.Double,
            unit = setting.measureResult.curve[1].curveBLowLimit.."~"..setting.measureResult.curve[1].curveBUpLimit,
            writePrivilege=  RoleType.Super,
            readPrivilege = RoleType.Maintain,
            currentValue = nil,
            checkValue = function(value)
                if setting.ui.profile.measureParam.fourDecimalWithNegativePattern(value) == true then
                    setting.ui.profile.measureParam[3][2].currentValue = tonumber(value)
                    return value
                else
                    local retK = config.measureParam.curveK
                    local retB = config.measureParam.curveB
                    retK, retB = CurveParamCurveXYChange(retK, retB)
                    setting.ui.profile.measureParam[3][2].currentValue = retB
                    return string.format("%.6f", retB)
                end
            end,
            curveParamCurveXYChange = function(value, isUpdateCurrentValue)
                local retK = config.measureParam.curveK
                local retB = value
                if setting.ui.profile.measureParam[3][1].currentValue ~= nil and isUpdateCurrentValue == false then
                    retK = setting.ui.profile.measureParam[3][1].currentValue
                end

                retK, retB = CurveParamCurveXYChange(retK, retB)
                if isUpdateCurrentValue == true then
                    setting.ui.profile.measureParam[3][2].currentValue = retB
                else
                    -- 必须在函数checkValue更新，此时是原始值
                end
                return retB
            end,
        },
        {
            name = "curveParam[1].timeStr",
            text = "校准时间",
            type = DataType.String,
            writePrivilege=  RoleType.Super,
            readPrivilege = RoleType.Maintain,
            checkValue = function(value)
                return config.measureParam.timeStr
            end,
        },
        {
            name = "curveParam[1].curveKIC",
            text = "IC斜率",
            type = DataType.Double,
            unit = setting.measureResult.curve[1].curveKLowLimit.."~"..setting.measureResult.curve[1].curveKUpLimit,
            writePrivilege=  RoleType.Super,
            readPrivilege = RoleType.Maintain,
            currentValue = nil,
            checkValue = function(value)
                if setting.ui.profile.measureParam.fourDecimalWithNegativePattern(value) == true then
                    setting.ui.profile.measureParam[3][4].currentValue = tonumber(value)
                    return value
                else
                    local retK = config.measureParam.curveParam[1].curveKIC
                    local retB = config.measureParam.curveParam[1].curveBIC
                    retK, retB = CurveParamCurveXYChange(retK, retB)
                    setting.ui.profile.measureParam[3][4].currentValue = retB
                    return string.format("%.6f", retB)
                end
            end,
        },
        {
            name = "curveParam[1].curveBIC",
            text = "IC截距",
            type = DataType.Double,
            unit = setting.measureResult.curve[1].curveBLowLimit.."~"..setting.measureResult.curve[1].curveBUpLimit,
            writePrivilege=  RoleType.Super,
            readPrivilege = RoleType.Maintain,
            currentValue = nil,
            checkValue = function(value)
                if setting.ui.profile.measureParam.fourDecimalWithNegativePattern(value) == true then
                    setting.ui.profile.measureParam[3][5].currentValue = tonumber(value)
                    return value
                else
                    local retK = config.measureParam.curveParam[1].curveKIC
                    local retB = config.measureParam.curveParam[1].curveBIC
                    retK, retB = CurveParamCurveXYChange(retK, retB)
                    setting.ui.profile.measureParam[3][5].currentValue = retB
                    return string.format("%.6f", retB)
                end
            end,
        },
        {
            name = "curveParam[1].timeStrIC",
            text = "校准时间",
            type = DataType.String,
            writePrivilege=  RoleType.Super,
            readPrivilege = RoleType.Maintain,
            checkValue = function(value)
                return config.measureParam.curveParam[1].timeStrIC
            end,
        },
        {
            name = "curveParam[1].curveKNPOC",
            text = "NPOC斜率",
            type = DataType.Double,
            unit = setting.measureResult.curve[1].curveKLowLimit.."~"..setting.measureResult.curve[1].curveKUpLimit,
            writePrivilege=  RoleType.Super,
            readPrivilege = RoleType.Maintain,
            currentValue = nil,
            checkValue = function(value)
                if setting.ui.profile.measureParam.fourDecimalWithNegativePattern(value) == true then
                    setting.ui.profile.measureParam[3][7].currentValue = tonumber(value)
                    return value
                else
                    local retK = config.measureParam.curveParam[1].curveKNPOC
                    local retB = config.measureParam.curveParam[1].curveBNPOC
                    retK, retB = CurveParamCurveXYChange(retK, retB)
                    setting.ui.profile.measureParam[3][7].currentValue = retB
                    return string.format("%.6f", retB)
                end
            end,
        },
        {
            name = "curveParam[1].curveBNPOC",
            text = "NPOC截距",
            type = DataType.Double,
            unit = setting.measureResult.curve[1].curveBLowLimit.."~"..setting.measureResult.curve[1].curveBUpLimit,
            writePrivilege=  RoleType.Super,
            readPrivilege = RoleType.Maintain,
            currentValue = nil,
            checkValue = function(value)
                if setting.ui.profile.measureParam.fourDecimalWithNegativePattern(value) == true then
                    setting.ui.profile.measureParam[3][8].currentValue = tonumber(value)
                    return value
                else
                    local retK = config.measureParam.curveParam[1].curveKNPOC
                    local retB = config.measureParam.curveParam[1].curveBNPOC
                    retK, retB = CurveParamCurveXYChange(retK, retB)
                    setting.ui.profile.measureParam[3][8].currentValue = retB
                    return string.format("%.6f", retB)
                end
            end,
        },
        {
            name = "curveParam[1].timeStrNPOC",
            text = "校准时间",
            type = DataType.String,
            writePrivilege=  RoleType.Super,
            readPrivilege = RoleType.Maintain,
            checkValue = function(value)
                return config.measureParam.curveParam[1].timeStrNPOC
            end,
        },
    },
    {
        name = "rangeParam",
        text = "校准量程信息",
        --{
        --    name = "rangeAccurateCalibrate",
        --    text = "精准校准模式",
        --    type = DataType.Bool,
        --    writePrivilege=  RoleType.Administrator,
        --    readPrivilege = RoleType.Administrator,
        --},
        {
            name = "absCalibrateMode",
            text = "绝对浓度模式",
            type = DataType.Bool,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
        },
        {
            name = "curveParam[1].RangeConsistencyIC",
            text = "IC量程校准液浓度",
            type = DataType.Float,
            unit = "mg/L",
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Maintain,
            checkValue = function(value)
                if setting.ui.profile.measureParam.twoDecimalPattern(value) == true then
                    local num = tonumber(value)
                    if num <= 0 then
                        return string.format("%.2f", config.measureParam.curveParam[1].RangeConsistencyIC)
                    else
                        return value
                    end
                else
                    return string.format("%.2f", config.measureParam.curveParam[1].RangeConsistencyIC)
                end
            end,
        },
        {
            name = "curveParam[1].RangeConsistencyNPOC",
            text = "NPOC量程校准液浓度",
            type = DataType.Float,
            unit = "mg/L",
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Maintain,
            checkValue = function(value)
                if setting.ui.profile.measureParam.twoDecimalPattern(value) == true then
                    local num = tonumber(value)
                    if num <= 0 then
                        return string.format("%.2f", config.measureParam.curveParam[1].RangeConsistencyNPOC)
                    else
                        return value
                    end
                else
                    return string.format("%.2f", config.measureParam.curveParam[1].RangeConsistencyNPOC)
                end
            end,
        },
        --{
        --    name = "ZeroConsistency",
        --    text = "零点校准液浓度",
        --    type = DataType.Float,
        --    unit = "mg/L",
        --    writePrivilege=  RoleType.Administrator,
        --    readPrivilege = RoleType.Maintain,
        --    checkValue = function(value)
        --        if setting.ui.profile.measureParam.twoDecimalPattern(value) == true then
        --            local num = tonumber(value)
        --            if num < 0 then
        --                return string.format("%.2f", config.measureParam.ZeroConsistency)
        --            else
        --                return value
        --            end
        --        else
        --            return string.format("%.2f", config.measureParam.ZeroConsistency)
        --        end
        --    end,
        --},
        {
            name = "RangeConsistency",
            text = "TC量程校准液浓度",
            type = DataType.Float,
            unit = "mg/L",
            rangeParamEnd = true,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Maintain,
            checkValue = function(value)
                if setting.ui.profile.measureParam.twoDecimalPattern(value) == true then
                    local num = tonumber(value)
                    if num <= 0 then
                        return string.format("%.2f", config.measureParam.RangeConsistency)
                    else
                        return value
                    end
                else
                    return string.format("%.2f", config.measureParam.RangeConsistency)
                end
            end,
        },
    },
    --[[{
        name = "intelligentCheck",
        text = "智能判定",
        {
            name = "curveQualifiedDetermination",
            text = "校准合格判定",
            type = DataType.Bool,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
        },
    },]]--
   --[[ {
        name = "sampleCheck",
        text = "核查",
        {
            name = "checkConsistency",
            text = "核查浓度",
            type = DataType.Float,
            unit = "mg/L",
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Maintain,
            checkValue = function(value)
                if setting.ui.profile.measureParam.twoDecimalPattern(value) == true then
                    local num = tonumber(value)
                    if num <= 0 then
                        return string.format("%.2f", config.measureParam.checkConsistency)
                    else
                        return value
                    end
                else
                    return string.format("%.2f", config.measureParam.checkConsistency)
                end
            end,
        },
        {
            name = "checkErrorLimit",
            text = "核查偏差限值",
            type = DataType.Float,
            unit = "100%",
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Maintain,
            checkValue = function(value)
                if setting.ui.profile.measureParam.twoDecimalPattern(value) == true then
                    local num = tonumber(value)
                    if num <= 0 then
                        return string.format("%.2f", config.measureParam.checkErrorLimit)
                    else
                        return value
                    end
                else
                    return string.format("%.2f", config.measureParam.checkErrorLimit)
                end
            end,
        },
        {
            name = "checkReporting",
            text = "核查上报",
            type = DataType.Bool,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
        },
        {
            name = "accurateCheck",
            text = "精准核查",
            type = DataType.Bool,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Maintain,
        },
        {
            name = "failAutoRevise",
            text = "超限值启动校准",
            type = DataType.Bool,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Maintain,
        },
    },]]--
    -- 2
    {
        name = "react",
        text = "反应",
        {
            name = "reactTemperature",
            text = "反应温度",
            type = DataType.Float,
            unit = "℃",
            writePrivilege=  RoleType.Super,
            readPrivilege = RoleType.Super,
            checkValue = function(value)
                if setting.ui.profile.measureParam.timePattern(value) == true then
                    local num = tonumber(value)
                    if num < 0 or num > setting.temperature.digestTemperatureLimitTop then
                        return string.format("%.1f", config.measureParam.reactTemperature)
                    else
                        return value
                    end
                else
                    return string.format("%.1f", config.measureParam.reactTemperature)
                end
            end,
        },
        {
            name = "coolTemperature",
            text = "制冷温度",
            type = DataType.Float,
            unit = "℃",
            writePrivilege=  RoleType.Super,
            readPrivilege = RoleType.Super,
            checkValue = function(value)
                if setting.ui.profile.measureParam.electricPattern(value) == true then
                    local num = tonumber(value)
                    if num < -10 or num > 40 then
                        return string.format("%.2f", config.measureParam.coolTemperature)
                    else
                        return value
                    end
                    return value
                else
                    return string.format("%.2f", config.measureParam.coolTemperature)
                end
            end,
        },
        {
            name = "measureModuleTemperature",
            text = "测量池1温度",
            type = DataType.Float,
            unit = "℃",
            writePrivilege=  RoleType.Super,
            readPrivilege = RoleType.Super,
            checkValue = function(value)
                if setting.ui.profile.measureParam.electricPattern(value) == true then
                    local num = tonumber(value)
                    if num < 10 or num > 80 then
                        return string.format("%.2f", config.measureParam.measureModuleTemperature)
                    else
                        return value
                    end
                    return value
                else
                    return string.format("%.2f", config.measureParam.measureModuleTemperature)
                end
            end,
        },
        {
            name = "shortMeasureModuleTemperature",
            text = "测量池2温度",
            type = DataType.Float,
            unit = "℃",
            writePrivilege=  RoleType.Super,
            readPrivilege = RoleType.Super,
            checkValue = function(value)
                if setting.ui.profile.measureParam.electricPattern(value) == true then
                    local num = tonumber(value)
                    if num < 10 or num > 80 then
                        return string.format("%.2f", config.measureParam.shortMeasureModuleTemperature)
                    else
                        return value
                    end
                    return value
                else
                    return string.format("%.2f", config.measureParam.shortMeasureModuleTemperature)
                end
            end,
        },
    },
    --[[{
        name = "measureADAdjust",
        text = "测量模块调节",
        {
            name = "measureLedAD.measure",
            text = "目标值",
            unit = "V",
            type = DataType.Float,
            writePrivilege=  RoleType.Super,
            readPrivilege = RoleType.Super,
            checkValue = function(value)
                if setting.ui.profile.measureParam.fourDecimalWithNegativePattern(value) == true then
                    local num = tonumber(value)
                    if num < 0 or num > 5 then
                        return string.format("%.3f", config.measureParam.measureLedAD.measure)
                    else
                        return value
                    end
                else
                    return string.format("%.3f", config.measureParam.measureLedAD.measure)
                end
            end,
        },
        {
            name = "measureLedAD.offsetPercent",
            text = "偏差阈值",
            unit = "100%",
            type = DataType.Float,
            writePrivilege=  RoleType.Super,
            readPrivilege = RoleType.Super,
            checkValue = function(value)
                if setting.ui.profile.measureParam.fourDecimalWithNegativePattern(value) == true then
                    local num = tonumber(value)
                    if num < 0 or num >= 1 then
                        return string.format("%.2f", config.measureParam.measureLedAD.offsetPercent)
                    else
                        return value
                    end
                else
                    return string.format("%.2f", config.measureParam.measureLedAD.offsetPercent)
                end
            end,
        },
    },]]--
    {
        name = "revise",
        text = "修正",
        {
            name = "negativeRevise",
            text = "负值修正",
            type = DataType.Bool,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
        },
        {
            name = "reviseFactor",
            text = "斜率修正",
            type = DataType.Float,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
            checkValue = function(value)
                if setting.ui.profile.measureParam.fourDecimalWithNegativePattern(value) == true then
                    return value
                else
                    return string.format("%.4f", config.measureParam.reviseFactor)
                end
            end,
        },
        {
            name = "shiftFactor",
            text = "截距修正",
            type = DataType.Float,
            writePrivilege=  RoleType.Super,
            readPrivilege = RoleType.Super,
            checkValue = function(value)
                if setting.ui.profile.measureParam.fourDecimalWithNegativePattern(value) == true then
                    return value
                else
                    return string.format("%.4f", config.measureParam.shiftFactor)
                end
            end,
        },
        {
            name = "measureDataOffsetValve",
            text = "偏移量",
            type = DataType.Float,
            writePrivilege=  RoleType.Super,
            readPrivilege = RoleType.Super,
            checkValue = function(value)
                if setting.ui.profile.measureParam.fourDecimalPattern(value) == true then
                    local num = tonumber(value)
                    if num > setting.measureResult.quantifyLowLimit*2 or num < -(setting.measureResult.quantifyLowLimit*2) then
                        return string.format("%.4f", config.measureParam.measureDataOffsetValve)
                    else
                        return value
                    end
                else
                    return string.format("%.4f", config.measureParam.measureDataOffsetValve)
                end
            end,
        },
    },
    {
        name = "cleanBefMea",
        text = "测量前清洗",
        {
            name = "cleanBefDilute",
            text = "稀释前清洗",
            type = DataType.Bool,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
        },
        --{
        --    name = "cleanBefMeaBlankVol",
        --    text = "零点校准液",
        --    unit = "mL",
        --    type = DataType.Float,
        --    writePrivilege=  RoleType.Administrator,
        --    readPrivilege = RoleType.Administrator,
        --    checkValue = function(value)
        --        local ret,vol = setting.ui.profile.measureParam.meterPointMultipleCheck(value)
        --        if ret == true then
        --            local num = tonumber(vol)
        --            if num < 0 or num > 18 then
        --                return string.format("%.2f", config.measureParam.cleanBefMeaBlankVol)
        --            else
        --                return vol
        --            end
        --        else
        --            return string.format("%.2f", config.measureParam.cleanBefMeaBlankVol)
        --        end
        --    end,
        --},
    },
    {
        name = "Homogenizer",
        text = "均质池",
        {
            name = "drainFromMixerVol",
            text = "排液体积",
            unit = "mL",
            type = DataType.Float,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
            checkValue = function(value)
                local ret,vol = setting.ui.profile.measureParam.meterPointMultipleCheck(value)
                if ret == true then
                    local num = tonumber(vol)
                    if num < 0 or num > 120 then
                        return string.format("%.2f", config.measureParam.drainFromMixerVol)
                    else
                        return vol
                    end
                else
                    return string.format("%.2f", config.measureParam.drainFromMixerVol)
                end
            end,
        },
        {
            name = "sampleSupplyVolume",
            text = "供样体积",
            unit = "mL",
            type = DataType.Float,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
            checkValue = function(value)
                local ret,vol = setting.ui.profile.measureParam.meterPointMultipleCheck(value)
                if ret == true then
                    local num = tonumber(vol)
                    if num < 0 or num > 120 then
                        return string.format("%.2f", config.measureParam.sampleSupplyVolume)
                    else
                        return vol
                    end
                else
                    return string.format("%.2f", config.measureParam.sampleSupplyVolume)
                end
            end,
        },
    },
    {
        name = "SamplerVolume",
        text = "水样杯",
        {
            name = "sampleRenewVolume",
            text = "润洗体积",
            unit = "mL",
            type = DataType.Float,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
            checkValue = function(value)
                local ret,vol = setting.ui.profile.measureParam.meterPointMultipleCheck(value)
                if ret == true then
                    local num = tonumber(vol)
                    if num < 0 or num > 50 then
                        return string.format("%.2f", config.measureParam.sampleRenewVolume)
                    else
                        return vol
                    end
                else
                    return string.format("%.2f", config.measureParam.sampleRenewVolume)
                end
            end,
        },
        {
            name = "renewTime",
            text = "润洗次数",
            unit = "次",
            type = DataType.Int,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
            checkValue = function(value)
                if setting.ui.profile.measureParam.timePattern(value) == true then
                    local num = tonumber(value)
                    if num > 0 and num < 5 then
                        return value
                    else
                        return tostring(config.measureParam.renewTime)
                    end
                else
                    return tostring(config.measureParam.renewTime)
                end
            end,
        },
        {
            name = "sampleUpdateVolume",
            text = "更新体积",
            unit = "mL",
            type = DataType.Float,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
            checkValue = function(value)
                if setting.ui.profile.measureParam.timePattern(value) == true then
                    local num = tonumber(value)
                    if num < 0 or num > 100 then
                        return string.format("%.1f", config.measureParam.sampleUpdateVolume)
                    else
                        return value
                    end
                else
                    return string.format("%.1f", config.measureParam.sampleUpdateVolume)
                end
            end,
        },
        {
            name = "sampleReduceVolume",
            text = "回抽体积",
            unit = "mL",
            type = DataType.Float,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
            checkValue = function(value)
                local ret,vol = setting.ui.profile.measureParam.meterPointMultipleCheck(value)
                if ret == true then
                    local num = tonumber(vol)
                    if num < 0 or num > 6 then
                        return string.format("%.2f", config.measureParam.sampleReduceVolume)
                    else
                        return vol
                    end
                else
                    return string.format("%.2f", config.measureParam.sampleReduceVolume)
                end
            end,
        },
        {
            name = "sampleWasteVol",
            text = "排废液体积",
            unit = "mL",
            type = DataType.Float,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
            checkValue = function(value)
                if setting.ui.profile.measureParam.twoDecimalPattern(value) == true then
                    local num = tonumber(value)
                    if num < 0 or num > 20 then
                        return string.format("%.2f", config.measureParam.sampleWasteVol)
                    else
                        return value
                    end
                else
                    return string.format("%.2f", config.measureParam.sampleWasteVol)
                end
            end,
        },
    },
    {
        name = "pipeVolume",
        text = "管路",
        {
            name = "extendSamplePipeVolume",
            text = "水样管延长体积",
            unit = "mL",
            type = DataType.Float,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
            checkValue = function(value)
                if setting.ui.profile.measureParam.twoDecimalPattern(value) == true then
                    local num = tonumber(value)
                    if num < 0 or num > 50 then
                        return string.format("%.2f", config.measureParam.extendSamplePipeVolume)
                    else
                        return value
                    end
                else
                    return string.format("%.2f", config.measureParam.extendSamplePipeVolume)
                end
            end,
        },
        {
            name = "reagentRenewVolume",
            text = "试剂更新体积",
            unit = "mL",
            type = DataType.Float,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
            checkValue = function(value)
                if setting.ui.profile.measureParam.twoDecimalPattern(value) == true then
                    local num = tonumber(value)
                    if num < 0 or num > 12 then
                        return string.format("%.2f", config.measureParam.reagentRenewVolume)
                    else
                        return value
                    end
                else
                    return string.format("%.2f", config.measureParam.reagentRenewVolume)
                end
            end,
        },
    },
    {
        name = "debugParam",
        text = "TOC调试参数",
        {
            name = "syringReactVolume",
            text = "TC注射体积",
            unit = "mL",
            type = DataType.Float,
            writePrivilege=  RoleType.Super,
            readPrivilege = RoleType.Super,
            checkValue = function(value)
                if  setting.ui.profile.measureParam.threeDecimalPattern(value) then
                    local num = tonumber(value)
                    if num < setting.liquid.syringeAddMinVloume or num > setting.liquid.syringeAddMaxVloume then
                        return string.format("%.2f", config.measureParam.syringReactVolume)
                    else
                        return value
                    end
                else
                    return string.format("%.2f", config.measureParam.syringReactVolume)
                end
            end,
        },
        {
            name = "syringICReactVolume",
            text = "IC注射体积",
            unit = "mL",
            type = DataType.Float,
            writePrivilege=  RoleType.Super,
            readPrivilege = RoleType.Super,
            checkValue = function(value)
                if  setting.ui.profile.measureParam.threeDecimalPattern(value) then
                    local num = tonumber(value)
                    if num < setting.liquid.syringeAddMinVloume or num > setting.liquid.syringeAddMaxVloume then
                        return string.format("%.2f", config.measureParam.syringICReactVolume)
                    else
                        return value
                    end
                else
                    return string.format("%.2f", config.measureParam.syringICReactVolume)
                end
            end,
        },
        --{
        --    name = "addBeforeTime",
        --    text = "注样前等待时间",
        --    type = DataType.Float,
        --    unit = "秒",
        --    writePrivilege=  RoleType.Super,
        --    readPrivilege = RoleType.Super,
        --    checkValue = function(value)
        --        if setting.ui.profile.measureParam.twoDecimalPattern(value) == true then
        --            local num = tonumber(value)
        --            if num >= 0 and num <= 1000 then
        --                return value
        --            else
        --                return string.format("%.2f", config.measureParam.addBeforeTime)
        --            end
        --        else
        --            return string.format("%.2f", config.measureParam.addBeforeTime)
        --        end
        --    end,
        --},
        {
            name = "addAfterTime",
            text = "注样后等待时间",
            type = DataType.Float,
            unit = "秒",
            writePrivilege=  RoleType.Super,
            readPrivilege = RoleType.Super,
            checkValue = function(value)
                if setting.ui.profile.measureParam.twoDecimalPattern(value) == true then
                    local num = tonumber(value)
                    if num >= 0 and num <= 1000 then
                        return value
                    else
                        return string.format("%.2f", config.measureParam.addAfterTime)
                    end
                else
                    return string.format("%.2f", config.measureParam.addAfterTime)
                end
            end,
        },
        {
            name = "addSampleMidtime",
            text = "加样间隔时间",
            type = DataType.Float,
            unit = "秒",
            writePrivilege=  RoleType.Super,
            readPrivilege = RoleType.Super,
            checkValue = function(value)
                if setting.ui.profile.measureParam.twoDecimalPattern(value) == true then
                    local num = tonumber(value)
                    if num >= 0 and num <= 60 then
                        return value
                    else
                        return string.format("%.2f", config.measureParam.addSampleMidtime)
                    end
                else
                    return string.format("%.2f", config.measureParam.addSampleMidtime)
                end
            end,
        },
        {
            name = "addSampleCnt",
            text = "加样次数",
            type = DataType.Int,
            unit = "次",
            writePrivilege=  RoleType.Super,
            readPrivilege = RoleType.Super,
            checkValue = function(value)
                if setting.ui.profile.measureParam.timePattern(value) == true then
                    local num = tonumber(value)
                    if num >= 1 and num <= 10 then
                        return value
                    else
                        return tostring(config.measureParam.addSampleCnt)
                    end
                else
                    return tostring(config.measureParam.addSampleCnt)
                end
            end,
        },
        --{
        --    name = "syringeUpdateCnt",
        --    text = "更新次数",
        --    unit = "次",
        --    type = DataType.Int,
        --    writePrivilege=  RoleType.Super,
        --    readPrivilege = RoleType.Super,
        --    checkValue = function(value)
        --        if setting.ui.profile.measureParam.timePattern(value) == true then
        --            local num = tonumber(value)
        --            if num >= 0 and num <= setting.liquid.syringeUpdateUpperLimit then
        --                return value
        --            else
        --                return string.format("%.2f", config.measureParam.syringeUpdateCnt)
        --            end
        --        else
        --            return string.format("%.2f", config.measureParam.syringeUpdateCnt)
        --        end
        --    end,
        --},
        {
            name = "exposureTime",
            text = "曝气时间",
            type = DataType.Int,
            unit = "秒",
            writePrivilege=  RoleType.Super,
            readPrivilege = RoleType.Super,
            checkValue = function(value)
                if setting.ui.profile.measureParam.timePattern(value) == true then
                    return value
                else
                    return tostring(config.measureParam.exposureTime)
                end
            end,
        },
        {
            name = "exposureValveVoltage",
            text = "曝气比例阀电压",
            unit = "V",
            type = DataType.Float,
            writePrivilege=  RoleType.Super,
            readPrivilege = RoleType.Super,
            checkValue = function(value)
                if setting.ui.profile.measureParam.twoDecimalPattern(value) == true then
                    local num = tonumber(value)
                    if num >= 0 and num <= 3.25 then
                        return value
                    else
                        return string.format("%.2f", config.measureParam.exposureValveVoltage)
                    end
                else
                    return string.format("%.2f", config.measureParam.exposureValveVoltage)
                end
            end,
        },
        {
            name = "carryingValveVoltage",
            text = "载气比例阀电压",
            unit = "V",
            type = DataType.Float,
            writePrivilege=  RoleType.Super,
            readPrivilege = RoleType.Super,
            checkValue = function(value)
                if setting.ui.profile.measureParam.twoDecimalPattern(value) == true then
                    local num = tonumber(value)
                    if num >= 0 and num <= 3.25 then
                        return value
                    else
                        return string.format("%.2f", config.measureParam.carryingValveVoltage)
                    end
                else
                    return string.format("%.2f", config.measureParam.carryingValveVoltage)
                end
            end,
        },
        {
            name = "preCarryingPressure",
            text = "载气压力",
            unit = "kPa",
            type = DataType.Float,
            writePrivilege=  RoleType.Super,
            readPrivilege = RoleType.Super,
            checkValue = function(value)
                if setting.ui.profile.measureParam.twoDecimalPattern(value) == true then
                    local num = tonumber(value)
                    if num >= 0 and num <= 500 then
                        return value
                    else
                        return string.format("%.2f", config.measureParam.preCarryingPressure)
                    end
                else
                    return string.format("%.2f", config.measureParam.preCarryingPressure)
                end
            end,
        },
        {
            name = "exposurePressure",
            text = "曝气压力",
            unit = "kPa",
            type = DataType.Float,
            writePrivilege=  RoleType.Super,
            readPrivilege = RoleType.Super,
            checkValue = function(value)
                if setting.ui.profile.measureParam.twoDecimalPattern(value) == true then
                    local num = tonumber(value)
                    if num >= 0 and num <= 500 then
                        return value
                    else
                        return string.format("%.2f", config.measureParam.exposurePressure)
                    end
                else
                    return string.format("%.2f", config.measureParam.exposurePressure)
                end
            end,
        },
        {
            name = "baseLineCheckCnt",
            text = "合格次数",
            unit = "次",
            type = DataType.Int,
            writePrivilege=  RoleType.Super,
            readPrivilege = RoleType.Super,
            checkValue = function(value)
                if setting.ui.profile.measureParam.timePattern(value) == true then
                    local num = tonumber(value)
                    if num >= 1 and num <= 30 then
                        return value
                    else
                        return tostring(config.measureParam.baseLineCheckCnt)
                    end
                else
                    return tostring(config.measureParam.baseLineCheckCnt)
                end
            end,
        },
        {
            name = "stirTime",
            text = "搅拌时间",
            type = DataType.Float,
            unit = "秒",
            writePrivilege=  RoleType.Super,
            readPrivilege = RoleType.Super,
            checkValue = function(value)
                if setting.ui.profile.measureParam.twoDecimalPattern(value) == true then
                    local num = tonumber(value)
                    if num >= 0 and num <= 1000 then
                        return value
                    else
                        return string.format("%.2f", config.measureParam.stirTime)
                    end
                else
                    return string.format("%.2f", config.measureParam.stirTime)
                end
            end,
        },
    },
    {
        name = "reviseParam",
        text = "内部校正",
        {
            name = "reviseParameter[1]",
            text = "0-" .. tostring(setting.measure.range[1].viewRange) .. "(" .. tostring(setting.measure.range[1].diluteFactor) .. "倍)",
            type = DataType.Float,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
            checkValue = function(value)
                if setting.ui.profile.measureParam.threeDecimalPattern(value) == true then
                    return value
                else
                    return string.format("%.3f", config.measureParam.reviseParameter[1])
                end
            end,
        },
        {
            name = "reviseParameter[2]",
            text = "0-" .. tostring(setting.measure.range[2].viewRange) .. "(" .. tostring(setting.measure.range[2].diluteFactor) .. "倍)",
            type = DataType.Float,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
            checkValue = function(value)
                if setting.ui.profile.measureParam.threeDecimalPattern(value) == true then
                    return value
                else
                    return string.format("%.3f", config.measureParam.reviseParameter[2])
                end
            end,
        },
        {
            name = "reviseParameter[3]",
            text = "0-" .. tostring(setting.measure.range[3].viewRange) .. "(" .. tostring(setting.measure.range[3].diluteFactor) .. "倍)",
            type = DataType.Float,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
            checkValue = function(value)
                if setting.ui.profile.measureParam.threeDecimalPattern(value) == true then
                    return value
                else
                    return string.format("%.3f", config.measureParam.reviseParameter[3])
                end
            end,
        },
        {
            name = "reviseParameter[4]",
            text = "0-" .. tostring(setting.measure.range[4].viewRange) .. "(" .. tostring(setting.measure.range[4].diluteFactor) .. "倍)",
            type = DataType.Float,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
            checkValue = function(value)
                if setting.ui.profile.measureParam.threeDecimalPattern(value) == true then
                    return value
                else
                    return string.format("%.3f", config.measureParam.reviseParameter[4])
                end
            end,
        },
        {
            name = "reviseParameter[5]",
            text = "0-" .. tostring(setting.measure.range[5].viewRange) .. "(" .. tostring(setting.measure.range[5].diluteFactor) .. "倍)",
            type = DataType.Float,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
            checkValue = function(value)
                if setting.ui.profile.measureParam.threeDecimalPattern(value) == true then
                    return value
                else
                    return string.format("%.3f", config.measureParam.reviseParameter[5])
                end
            end,
        },
    },
    isShowCheck = function()
        return true
    end,
    checkOEM = function()
        return config.system.OEM
    end,
    defaultRestore = function(userType, defaultReviseParameter)

        if userType == RoleType.Super then
            local RangeConsistency = {}
            local ZeroConsistency = {}
            local timeStr = {}
            local curveB = {}
            local curveK = {}
            local reviseParameter = {}

            local RangeConsistencyIC = {}
            local ZeroConsistencyIC = {}
            local timeStrIC = {}
            local curveBIC = {}
            local curveKIC = {}

            local RangeConsistencyNPOC = {}
            local ZeroConsistencyNPOC = {}
            local timeStrNPOC = {}
            local curveBNPOC = {}
            local curveKNPOC = {}

            for i = 1,setting.measure.range.rangeNum do
                RangeConsistency[i] = config.measureParam.curveParam[i].RangeConsistency
                ZeroConsistency[i] = config.measureParam.curveParam[i].ZeroConsistency
                timeStr[i] = config.measureParam.curveParam[i].timeStr
                curveB[i] = config.measureParam.curveParam[i].curveB
                curveK[i] = config.measureParam.curveParam[i].curveK
                RangeConsistencyIC[i] = config.measureParam.curveParam[i].RangeConsistencyIC
                ZeroConsistencyIC[i] = config.measureParam.curveParam[i].ZeroConsistencyIC
                timeStrIC[i] = config.measureParam.curveParam[i].timeStrIC
                curveBIC[i] = config.measureParam.curveParam[i].curveBIC
                curveKIC[i] = config.measureParam.curveParam[i].curveKIC
                RangeConsistencyNPOC[i] = config.measureParam.curveParam[i].RangeConsistencyNPOC
                ZeroConsistencyNPOC[i] = config.measureParam.curveParam[i].ZeroConsistencyNPOC
                timeStrNPOC[i] = config.measureParam.curveParam[i].timeStrNPOC
                curveBNPOC[i] = config.measureParam.curveParam[i].curveBNPOC
                curveKNPOC[i] = config.measureParam.curveParam[i].curveKNPOC
            end

            for k,v in pairs(config.measureParam.reviseParameter) do
                table.insert(reviseParameter, config.measureParam.reviseParameter[k])
            end

            local defaultTable = ConfigLists.LoadMeasureParamConfig(true)
            Helper.DefaultRestore(defaultTable, config.measureParam)

            for i = 1,setting.measure.range.rangeNum do
                config.measureParam.curveParam[i].RangeConsistency = RangeConsistency[i]
                config.measureParam.curveParam[i].ZeroConsistency = ZeroConsistency[i]
                config.measureParam.curveParam[i].timeStr = timeStr[i]
                config.measureParam.curveParam[i].curveB = curveB[i]
                config.measureParam.curveParam[i].curveK = curveK[i]
                config.measureParam.curveParam[i].RangeConsistencyIC = RangeConsistencyIC[i]
                config.measureParam.curveParam[i].ZeroConsistencyIC = ZeroConsistencyIC[i]
                config.measureParam.curveParam[i].timeStrIC = timeStrIC[i]
                config.measureParam.curveParam[i].curveBIC = curveBIC[i]
                config.measureParam.curveParam[i].curveKIC = curveKIC[i]
                config.measureParam.curveParam[i].RangeConsistencyNPOC = RangeConsistencyNPOC[i]
                config.measureParam.curveParam[i].ZeroConsistencyNPOC = ZeroConsistencyNPOC[i]
                config.measureParam.curveParam[i].timeStrNPOC = timeStrNPOC[i]
                config.measureParam.curveParam[i].curveBNPOC = curveBNPOC[i]
                config.measureParam.curveParam[i].curveKNPOC = curveKNPOC[i]
            end

            if false == defaultReviseParameter then
                --校准参数不恢复
                for k,v in pairs(config.measureParam.reviseParameter) do
                    config.measureParam.reviseParameter[k] = reviseParameter[k]
                end
            else
                for k,v in pairs(config.measureParam.reviseParameter) do
                    log:debug("校正参数 "..k.." 恢复默认 ,修改前值为 "..reviseParameter[k])
                end
            end

            log:info(Helper.GetRoleTypeStr().." 恢复默认"..setting.ui.profile.measureParam.text)
            config.modifyRecord.measureParam(true)
            ConfigLists.SaveMeasureParamConfig()

        elseif userType == RoleType.Administrator then

            local defaultTable = ConfigLists.LoadMeasureParamConfig(true)
            config.measureParam.currentRange = defaultTable.currentRange
            config.measureParam.calibrateRangeIndex = defaultTable.calibrateRangeIndex
            config.measureParam.zeroCheckRangeIndex = defaultTable.zeroCheckRangeIndex
            config.measureParam.rangeCheckRangeIndex = defaultTable.rangeCheckRangeIndex
            config.measureParam.autoChangeRange = defaultTable.autoChangeRange
            config.measureParam.activeRangeMode = defaultTable.activeRangeMode
            config.measureParam.range[1] = defaultTable.range[1]
            config.measureParam.range[2] = defaultTable.range[2]
            config.measureParam.range[3] = defaultTable.range[3]

            config.measureParam.negativeRevise = defaultTable.negativeRevise
            config.measureParam.reviseFactor = defaultTable.reviseFactor
            config.measureParam.checkConsistency = defaultTable.checkConsistency
            config.measureParam.checkErrorLimit = defaultTable.checkErrorLimit
            config.measureParam.failAutoRevise = defaultTable.failAutoRevise
            config.measureParam.accurateCheck = defaultTable.accurateCheck
            config.measureParam.wasteWaterEnvironment = defaultTable.wasteWaterEnvironment
            config.measureParam.cleanBefMeaBlankVol = defaultTable.cleanBefMeaBlankVol
            config.measureParam.cleanAftMeaBlankVol = defaultTable.cleanAftMeaBlankVol
            config.measureParam.cleanSampleVol = defaultTable.cleanSampleVol
            config.measureParam.extendSamplePipeVolume = defaultTable.extendSamplePipeVolume
            config.measureParam.sampleRenewVolume = defaultTable.sampleRenewVolume
            config.measureParam.sampleReduceVolume = defaultTable.sampleReduceVolume
            config.measureParam.reagentRenewVolume  = defaultTable.reagentRenewVolume
            config.measureParam.zeroAccurateCalibrate = defaultTable.zeroAccurateCalibrate
            config.measureParam.standardAccurateCalibrate = defaultTable.standardAccurateCalibrate

            config.measureParam.digestTemperature = defaultTable.digestTemperature
            config.measureParam.digestTime = defaultTable.digestTime
            config.measureParam.rangeAccurateCalibrate = defaultTable.rangeAccurateCalibrate
            config.measureParam.rangeCalibrateDeviation = defaultTable.rangeCalibrateDeviation
            config.measureParam.curveQualifiedDetermination = defaultTable.curveQualifiedDetermination
            config.measureParam.highClMode = defaultTable.highClMode
            config.measureParam.checkConsistency = defaultTable.checkConsistency
            config.measureParam.absCalibrateMode = defaultTable.absCalibrateMode
            log:info(Helper.GetRoleTypeStr().." 恢复默认"..setting.ui.profile.measureParam.text)
            config.modifyRecord.measureParam(true)
            ConfigLists.SaveMeasureParamConfig()

        elseif userType == RoleType.Maintain then

            local defaultTable = ConfigLists.LoadMeasureParamConfig(true)
            config.measureParam.currentRange = defaultTable.currentRange
            config.measureParam.calibrateRangeIndex = defaultTable.calibrateRangeIndex
            config.measureParam.zeroCheckRangeIndex = defaultTable.zeroCheckRangeIndex
            config.measureParam.rangeCheckRangeIndex = defaultTable.rangeCheckRangeIndex
            config.measureParam.autoChangeRange = defaultTable.autoChangeRange
            config.measureParam.activeRangeMode = defaultTable.activeRangeMode
            config.measureParam.range[1] = defaultTable.range[1]
            config.measureParam.range[2] = defaultTable.range[2]
            config.measureParam.range[3] = defaultTable.range[3]

            log:info(Helper.GetRoleTypeStr().." 恢复默认"..setting.ui.profile.measureParam.text)
            config.modifyRecord.measureParam(true)
            ConfigLists.SaveMeasureParamConfig()
        end
        setting.ui.profile.measureParam.updaterCurveParam(0,true)

        return false  --无需重启仪器
    end,
    saveFile = function(isUpdate, saveCurveParam)
        local flowManager = FlowManager.Instance()
        log:info(Helper.GetRoleTypeStr() .. " 修改" .. setting.ui.profile.measureParam.text)
        config.modifyRecord.measureParam(isUpdate)
        ConfigLists.SaveMeasureParamConfig()
        if saveCurveParam then
            setting.ui.profile.measureParam.checkCurveParamChange()
        end

        if dc:GetConnectStatus() == true then
            if config.measureParam.reactTemperature ~= config.measureParam.lastReactTemperature then
                setting.temperature.monitor.stoveAlarm = false
                setting.temperature.monitor.stoveLastTemperature = -1
                op:ReviseThermostatTemp(setting.temperature.indexStove, ThermostatMode.Heater, config.measureParam.reactTemperature, setting.temperature.toleranceTemp, setting.temperature.digestTempTimeout)
                log:info("重设恒温器温度： " .. config.measureParam.reactTemperature .. "--容差： " .. setting.temperature.toleranceTemp .. "--超时: " .. setting.temperature.digestTempTimeout)
            end

            if config.measureParam.coolTemperature ~= config.measureParam.lastCoolTemperature then
                setting.temperature.monitor.refrigeratorAlarm = false
                setting.temperature.monitor.refrigeratorLastTemperature = -1
                op:ReviseThermostatTemp(setting.temperature.indexRefrigerator,  ThermostatMode.Refrigerate, config.measureParam.coolTemperature, setting.temperature.coolToleranceTemp, setting.temperature.coolTempTimeout)
                log:info("重设恒温器温度： " .. config.measureParam.coolTemperature .. "--容差： " .. setting.temperature.coolToleranceTemp .. "--超时: " .. setting.temperature.coolTempTimeout)
            end

            if config.measureParam.measureModuleTemperature ~= config.measureParam.lastMeasureModuleTemperature then
                setting.temperature.monitor.NDIRAlarm = false
                setting.temperature.monitor.NDIRLastTemperature = -1
                op:ReviseThermostatTemp(setting.temperature.indexLNDIR,  ThermostatMode.Heater, config.measureParam.measureModuleTemperature, setting.temperature.NDIRToleranceTemp, setting.temperature.NDIRTempTimeout)
                log:info("重设恒温器温度： " .. config.measureParam.measureModuleTemperature .. "--容差： " .. setting.temperature.NDIRToleranceTemp .. "--超时: " .. setting.temperature.NDIRTempTimeout)
            end

            if config.measureParam.shortMeasureModuleTemperature ~= config.measureParam.lastShortMeasureModuleTemperature then
                op:ReviseThermostatTemp(setting.temperature.indexSNDIR,  ThermostatMode.Heater, config.measureParam.shortMeasureModuleTemperature, setting.temperature.NDIRToleranceTemp, setting.temperature.NDIRTempTimeout)
                log:info("重设恒温器温度： " .. config.measureParam.shortMeasureModuleTemperature .. "--容差： " .. setting.temperature.NDIRToleranceTemp .. "--超时: " .. setting.temperature.NDIRTempTimeout)
            end
            if config.measureParam.preCarryingPressure ~= config.measureParam.lastCarryingPressure then
                op:SetMonitorPressure(setting.pressure.indexCarryPressure, config.measureParam.preCarryingPressure)
                config.measureParam.lastCarryingPressure = config.measureParam.preCarryingPressure
                config.measureParam.carryingPressure = config.measureParam.preCarryingPressure
            end
        end

        ConfigLists.SaveMeasureParamConfig()
        ConfigLists.SaveMeasureStatus()

        return false  --无需重启仪器
    end,

    checkCurveParamChange = function()

        local currentRange  = config.measureParam.range[config.measureParam.currentRange+1]+1
        --config.measureParam.curveParam[currentRange].curveK = config.measureParam.curveK
        --config.measureParam.curveParam[currentRange].curveB = config.measureParam.curveB
        --config.measureParam.curveParam[currentRange].timeStr = config.measureParam.timeStr

        local calibrateRange= config.measureParam.range[config.measureParam.calibrateRangeIndex+1]+1
        --config.measureParam.curveParam[calibrateRange].ZeroConsistency = config.measureParam.ZeroConsistency
        --config.measureParam.curveParam[calibrateRange].RangeConsistency = config.measureParam.RangeConsistency

        local rangeNum =  setting.measure.range.rangeNum
        for i = 1, rangeNum do
            if math.abs(config.measureParam.curveParam[i].curveK - status.measure.calibrate[i].curveK) > 0.00001
                    or math.abs(config.measureParam.curveParam[i].curveB - status.measure.calibrate[i].curveB) > 0.00001 then
                local consistency = {config.measureParam.curveParam[i].ZeroConsistency,config.measureParam.curveParam[i].RangeConsistency}
                local saveTime = os.time()
                local absorbance1, absorbance2
                absorbance1, absorbance2 = op:CalculateAbsorbance(config.measureParam.curveParam[i].curveK,config.measureParam.curveParam[i].curveB,consistency[1],consistency[2])
                Helper.Result.OnCalibrateResultAdded(saveTime, saveTime, saveTime, config.measureParam.curveParam[i].curveK, config.measureParam.curveParam[i].curveB, consistency[1], consistency[2], absorbance1, absorbance2, i,true, ModelType.TC)
                op:SaveCalibrationTimeStr(saveTime,i)
                local calibrateDateTime = math.floor((2300+math.random()*300)+(2300+math.random()*300))
                op:SaveUserCurve(saveTime, config.measureParam.curveParam[i].curveK, config.measureParam.curveParam[i].curveB, absorbance1, absorbance2, consistency[1], consistency[2], calibrateDateTime, config.system.rangeViewMap[i].view, ModelType.TC)
                App.Sleep(100)
                config.measureParam.timeStr = config.measureParam.curveParam[i].timeStr
            end
            if math.abs(config.measureParam.curveParam[i].curveKIC - status.measure.calibrate[i].curveKIC) > 0.00001
                    or math.abs(config.measureParam.curveParam[i].curveBIC - status.measure.calibrate[i].curveBIC) > 0.00001 then
                local consistency = {config.measureParam.curveParam[i].ZeroConsistencyIC,config.measureParam.curveParam[i].RangeConsistencyIC}
                local saveTime = os.time()
                local absorbance1, absorbance2
                absorbance1, absorbance2 = op:CalculateAbsorbance(config.measureParam.curveParam[i].curveKIC,config.measureParam.curveParam[i].curveBIC,consistency[1],consistency[2])
                Helper.Result.OnCalibrateResultAdded(saveTime, saveTime, saveTime, config.measureParam.curveParam[i].curveKIC, config.measureParam.curveParam[i].curveBIC, consistency[1], consistency[2], absorbance1, absorbance2, i,true, ModelType.IC)
                op:SaveCalibrationTimeStr(saveTime,i, ModelType.IC)
                local calibrateDateTime = math.floor((2300+math.random()*300)+(2300+math.random()*300))
                op:SaveUserCurve(saveTime, config.measureParam.curveParam[i].curveKIC, config.measureParam.curveParam[i].curveBIC, absorbance1, absorbance2, consistency[1], consistency[2], calibrateDateTime, config.system.rangeViewMap[i].view, ModelType.IC)
                App.Sleep(100)
            end
            if math.abs(config.measureParam.curveParam[i].curveKNPOC - status.measure.calibrate[i].curveKNPOC) > 0.00001
                    or math.abs(config.measureParam.curveParam[i].curveBNPOC - status.measure.calibrate[i].curveBNPOC) > 0.00001 then
                local consistency = {config.measureParam.curveParam[i].ZeroConsistencyNPOC,config.measureParam.curveParam[i].RangeConsistencyNPOC}
                local saveTime = os.time()
                local absorbance1, absorbance2
                absorbance1, absorbance2 = op:CalculateAbsorbance(config.measureParam.curveParam[i].curveKNPOC,config.measureParam.curveParam[i].curveBNPOC,consistency[1],consistency[2])
                Helper.Result.OnCalibrateResultAdded(saveTime, saveTime, saveTime, config.measureParam.curveParam[i].curveKNPOC, config.measureParam.curveParam[i].curveBNPOC, consistency[1], consistency[2], absorbance1, absorbance2, i,true, ModelType.NPOC)
                op:SaveCalibrationTimeStr(saveTime,i, ModelType.NPOC)
                local calibrateDateTime = math.floor((2300+math.random()*300)+(2300+math.random()*300))
                op:SaveUserCurve(saveTime, config.measureParam.curveParam[i].curveKNPOC, config.measureParam.curveParam[i].curveBNPOC, absorbance1, absorbance2, consistency[1], consistency[2], calibrateDateTime, config.system.rangeViewMap[i].view, ModelType.NPOC)
                App.Sleep(100)
            end
        end
        setting.ui.profile.measureParam.updaterCurveParam(0,true)
        config.modifyRecord.measureParam(true)
        ConfigLists.SaveMeasureParamConfig()
        ConfigLists.SaveMeasureStatus()
    end,

    --获取KB值合理范围
    getCurveKBRange = function(rangeIndex,useMeasureParamConfig)
        local index
        if false == useMeasureParamConfig then
            index = tonumber(rangeIndex)+1
        else
            index = config.measureParam.range[config.measureParam.currentRange+1]+1
        end
        local curveKRange = ""
        local curveBRange = ""

        if nil ~= setting.measureResult.curve[index].curveKLowLimit and nil ~=setting.measureResult.curve[index].curveKUpLimit then
            curveKRange = setting.measureResult.curve[index].curveKLowLimit.."~"..setting.measureResult.curve[index].curveKUpLimit
        end

        if nil ~= setting.measureResult.curve[index].curveBLowLimit and nil ~=setting.measureResult.curve[index].curveBUpLimit then
            curveBRange = setting.measureResult.curve[index].curveBLowLimit.."~"..setting.measureResult.curve[index].curveBUpLimit
        end

        return curveKRange,curveBRange
    end,

    --更新当前标线参数
    updaterCurveParam = function(rangeIndex,useMeasureParamConfig, isCalibrateIndex)
        local currentRange
        local calibrateRange
        if false == useMeasureParamConfig then
            currentRange = tonumber(rangeIndex)+1
            calibrateRange = tonumber(rangeIndex)+1
        else
            currentRange = config.measureParam.range[config.measureParam.currentRange+1]+1
            calibrateRange = config.measureParam.range[config.measureParam.calibrateRangeIndex+1]+1
        end

        if nil ~= isCalibrateIndex and isCalibrateIndex then
            config.measureParam.ZeroConsistency = config.measureParam.curveParam[calibrateRange].ZeroConsistency
            config.measureParam.RangeConsistency = config.measureParam.curveParam[calibrateRange].RangeConsistency
        elseif true == useMeasureParamConfig then
            config.measureParam.curveK = config.measureParam.curveParam[currentRange].curveK
            config.measureParam.curveB = config.measureParam.curveParam[currentRange].curveB
            config.measureParam.timeStr = config.measureParam.curveParam[currentRange].timeStr
            config.measureParam.ZeroConsistency = config.measureParam.curveParam[calibrateRange].ZeroConsistency
            config.measureParam.RangeConsistency = config.measureParam.curveParam[calibrateRange].RangeConsistency
        else
            config.measureParam.curveK = config.measureParam.curveParam[currentRange].curveK
            config.measureParam.curveB = config.measureParam.curveParam[currentRange].curveB
            config.measureParam.timeStr = config.measureParam.curveParam[currentRange].timeStr
        end

        ConfigLists.SaveMeasureParamConfig()
    end,

    tempPattern = function(value)
        if type(value) == "string" then
            local ret = false
            local decimalPatterm = "^[+-]?[0-1]?%d?%d%.%d$"
            local integerPatterm = "^[+-]?[0-1]?%d?%d$"
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
    timePattern = function(value)
        if type(value) == "string" then
            local patterm = "^%d?%d?%d?%d$"
            if not string.find(value, patterm) then
                return false
            else
                return true
            end
        else
            return false
        end
    end,
    arguPattern = function(value)
        if type(value) == "string" then
            local ret = false
            local decimalPatterm = "^[-+]?%d?%d?%d?%d%.%d%d?%d?%d?%d?%d?$"
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
    fourDecimalPattern = function(value)
        if type(value) == "string" then
            local ret = false
            local decimalPatterm = "^%d?%d?%d?%d%.%d%d?%d?%d?$"
            local integerPatterm = "^%d?%d?%d?%d$"
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
    fourDecimalWithNegativePattern = function(value)
        if type(value) == "string" then
            local ret = false
            local decimalPatterm = "^%d?%d?%d?%d%.%d%d?%d?%d?$"
            local negativeDecimalPatterm = "^-%d?%d?%d?%d%.%d%d?%d?%d?$"
            local integerPatterm = "^%d?%d?%d?%d$"
            local negativeIntegerPatterm = "^-%d?%d?%d?%d$"
            if string.find(value, decimalPatterm) then
                ret = true
            elseif string.find(value, negativeDecimalPatterm) then
                ret = true
            elseif string.find(value, integerPatterm) then
                ret = true
            elseif string.find(value, negativeIntegerPatterm) then
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
            local decimalPatterm = "^%d?%d?%d?%d%.%d%d?%d?$"
            local integerPatterm = "^%d?%d?%d?%d$"
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
            local decimalPatterm = "^%d?%d?%d?%d?%d%.%d%d?$"
            local integerPatterm = "^%d?%d?%d?%d$"
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
            local integerPatterm = "^%d?%d?%d?%d?%d?%d?%d?%d$"
            if string.find(value, integerPatterm) then
                ret = true
            end
            return ret
        else
            return false
        end
    end,
    meterPointMultipleCheck = function(value)

        local pointNum = config.hardwareConfig.meterPoint.num
        local maxPoint = config.hardwareConfig.meterPoint.point[pointNum].setVolume
        local minPoint = config.hardwareConfig.meterPoint.point[1].setVolume
        local PRECISE = 0.000001
        local operateVol = 0

        local vol = tonumber(value)

        if not vol then
            return false, string.format("%.2f", 0)
        end


        local volList = {}

        for i = 1, pointNum do
            volList[i] = config.hardwareConfig.meterPoint.point[i].setVolume
        end

        if vol <= PRECISE then -- 输入体积为0

            operateVol = 0

        elseif volList[1] - vol >= -PRECISE then -- 输入体积小于或等于低定量点

            operateVol = minPoint

        elseif volList[1] - vol < -PRECISE  and
                volList[pointNum] - vol > PRECISE then -- 输入体积大于低定量点，小于高定量点

            pointNum = pointNum + 1
            volList[pointNum] = vol

            local temp = 0
            for i = 1, pointNum - 1 do
                for j = pointNum, i + 1, -1 do
                    if volList[j] < volList[j - 1] then
                        temp = volList[j - 1]
                        volList[j - 1] = volList[j]
                        volList[j] = temp
                    end
                end
            end

            local index = 1
            for i = 1, pointNum do
                if (-PRECISE <= volList[i] - vol) and
                        (volList[i] - vol <= PRECISE) then
                    break;
                end
                index = index + 1
            end

            local pPoint = volList[index - 1]
            local nPoint = volList[index + 1]
            local pD = vol - pPoint

            if pD < (nPoint - pPoint) / 2 then
                operateVol = pPoint
            else
                operateVol = nPoint
            end
        else -- 输入体积大于或等于高定量点

            local isMatch = false

            for i = 1, pointNum do
                local MP = volList[i]
                local fcount = vol / MP
                local count = math.floor(fcount + PRECISE)
                local residue = vol - count * MP

                if (-PRECISE <= residue) and (residue <= PRECISE) then
                    operateVol = vol
                    isMatch = true
                    break
                end
            end

            if isMatch == false then
                return false, string.format("%.2f", 0)
                --operateVol = maxPoint
            end

        end

        return true, string.format("%.2f", operateVol)
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
}
return setting.ui.profile.measureParam
