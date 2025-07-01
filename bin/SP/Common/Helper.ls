local _G = _ENV
local print = print
local Alarm = Alarm
local AlarmManager = AlarmManager
local RunStatus = RunStatus
local RunAction = RunAction
local type = type
local pairs = pairs
local Serialization = Serialization
local status = status
local config = config
local scriptsPath = scriptsPath
local ReportMode = ReportMode
local ResultMark = ResultMark
local ModelType = ModelType
local MeasureType = MeasureType
local setting = setting
local RelayControl = RelayControl
local RelayOut = RelayOut
local os = os
local CurrentResultManager = CurrentResultManager
local MeasureResultOutUpLimitException = MeasureResultOutUpLimitException
local ExceptionHandler = ExceptionHandler
local RoleType = RoleType
local App = App
local string = string

local P = {}
Helper = P
_ENV = P


StringSplit = function(str, splitChar)
    local subStrTab = {}
    while (true) do
        local pos = string.find(str, splitChar)
        if (not pos) then
            subStrTab[#subStrTab + 1] = str
            break
        end
        local sub_str = string.sub(str, 1, pos - 1)
        if sub_str ~= "" then
            subStrTab[#subStrTab + 1] = sub_str
        end
        str = string.sub(str, pos + 1, #str)
    end

    return subStrTab
end


GetRoleTypeStr = function()
    local roleType = App:GetCurrentRole()
    local str = ""

    if roleType == RoleType.General then
        str = "普通用户"
    elseif roleType == RoleType.Maintain then
        str = "运维员"
    elseif roleType == RoleType.Administrator then
        str = "管理员"
    elseif roleType == RoleType.Super then
        str = "超级管理员"
    end

    return str
end

MakeAlarm  = function (alarm, cause)
    return Alarm.new(alarm.type, alarm.name, cause, alarm.level)
end

DefaultRestore = function(defaultTable, destinationTable)

    if type(defaultTable) == "table" and type(destinationTable) == "table" then

        for k,v in pairs(defaultTable) do

            if type(v) == "table" then
                DefaultRestore(v, destinationTable[k])
            else
                destinationTable[k] = v
            end

        end
        return true
    else
        return false
    end
end

Status = {}

Status.SetStatus = function(statusTable)

    if type(statusTable.GetTime) == "function" then

        return RunStatus.new(statusTable.name, statusTable.text, statusTable:GetTime())

    else

        return RunStatus.new(statusTable.name, statusTable.text, 0)

    end
end

Status.SetAction = function(actionTable)

    if type(actionTable.GetTime) == "function" then

        return RunAction.new(actionTable.name, actionTable.text, actionTable.GetTime())

    else

        return RunAction.new(actionTable.name, actionTable.text, 0)

    end
end

Result = {}

Result.SetComplexResult = function(resultType, dateTime, consistency, mode, absorbance)
    if resultType == MeasureType.Sample then
        if mode == ReportMode.Calibrate then
            status.measure.report.complexResult.resultInfo = "C" --更新数据标识
        else
            status.measure.report.complexResult.resultInfo = status.measure.report.measure.resultInfo
        end

        status.measure.report.complexResult.dateTime = status.measure.report.measure.dateTime
        status.measure.report.complexResult.consistency = status.measure.report.measure.consistency
        status.measure.report.complexResult.resultType = status.measure.report.measure.resultType
        status.measure.report.complexResult.measureTime = status.measure.report.measure.measureTime
        status.measure.report.complexResult.absorbance = status.measure.report.measure.absorbance
        --status.measure.report.complexResult.deviceTypeNum = status.measure.report.measure.deviceTypeNum
        --status.measure.report.complexResult.oldTypeNum = status.measure.report.measure.oldTypeNum

    elseif resultType == MeasureType.Standard or resultType == MeasureType.Check or resultType == MeasureType.Blank or
            resultType == MeasureType.ZeroCheck or resultType == MeasureType.RangeCheck or  resultType == MeasureType.Addstandard or
            resultType == MeasureType.ExtAddstandard or resultType == MeasureType.Parallel or resultType == MeasureType.ExtParallel then

        if mode == ReportMode.OnLine  or mode == ReportMode.Calibrate then
            status.measure.report.complexResult.resultInfo = "C" --更新数据标识
        elseif mode == ReportMode.OffLine then
            status.measure.report.complexResult.resultInfo = "B"    --仪器离线
        elseif mode == ReportMode.Maintain or mode == ReportMode.Calibrate then
            status.measure.report.complexResult.resultInfo = "M"    --维护数据
        elseif mode == ReportMode.Fault then
            status.measure.report.complexResult.resultInfo = "D"    --故障数据
        end

        status.measure.report.complexResult.dateTime = dateTime
        status.measure.report.complexResult.consistency = consistency
        status.measure.report.complexResult.resultType = resultType
        status.measure.report.complexResult.measureTime = os.time() - dateTime
        status.measure.report.complexResult.absorbance = absorbance
        --status.measure.report.complexResult.deviceTypeNum = setting.instrument.deviceTypeNum.TOC
        --status.measure.report.complexResult.oldTypeNum = setting.instrument.oldTypeNum.TOC
    end
end

Result.OnMeasureProformaResultAdded = function(dateTime, consistency, absorbance, measureAD)
    status.measure.proformaResult.measure.dateTime = dateTime
    status.measure.proformaResult.measure.consistency = consistency
    status.measure.proformaResult.measure.absorbance = absorbance
    status.measure.proformaResult.measure.blankReference = measureAD.blankReference
    status.measure.proformaResult.measure.blankMeasure = measureAD.blankMeasure
    status.measure.proformaResult.measure.initReference = measureAD.initReference
    status.measure.proformaResult.measure.initMeasure = measureAD.initMeasure
    status.measure.proformaResult.measure.finalReference = measureAD.finalReference
    status.measure.proformaResult.measure.finalMeasure = measureAD.finalMeasure
end

Result.OnMeasureResultAdded = function(resultType, dateTime, consistency, mode, absorbance, isUseStart,isFault,resultMark,modbusStr,modelType)
    local currentResultManager = CurrentResultManager.Instance()

    local measureResultMark = ResultMark.N
    if nil ~= resultMark then
        measureResultMark = resultMark
    end

    local ModbusStr = ""
    if nil ~= modbusStr then
        ModbusStr = modbusStr
    end

    local isReporting = true
    if (resultType == MeasureType.ZeroCheck or resultType == MeasureType.RangeCheck) and false == config.measureParam.checkReporting then
        isReporting = false
    end

    if mode ~= ReportMode.OffLine and isReporting then
        status.measure.newResult.measure.dateTime = dateTime
        status.measure.newResult.measure.consistency = consistency
        status.measure.newResult.measure.resultType = resultType
        status.measure.newResult.measure.absorbance = absorbance
        status.measure.newResult.measure.peakArea = absorbance
        status.measure.newResult.measure.isUseStart = isUseStart
        status.measure.newResult.measure.isFault = isFault
        status.measure.newResult.measure.errorDateTime = dateTime
        status.measure.newResult.measure.modelType = modelType
    end

    if mode == ReportMode.OnLine then
        if measureResultMark == ResultMark.T or measureResultMark == ResultMark.E then
            status.measure.newResult.measure.resultInfo = "T"        --超仪器上限或者超量程（动态管控仅有T）
        elseif measureResultMark == ResultMark.K then
            status.measure.newResult.measure.resultInfo = "K"
        elseif measureResultMark == ResultMark.C then
            status.measure.newResult.measure.resultInfo = "C"
        else
            status.measure.newResult.measure.resultInfo = "N"        --正常
        end
    elseif mode == ReportMode.OffLine then
        status.measure.newResult.measure.resultInfo = "B"    --仪器离线
    elseif mode == ReportMode.Maintain then
        status.measure.newResult.measure.resultInfo = "M"    --维护数据
    elseif mode == ReportMode.Calibrate then
        status.measure.newResult.measure.resultInfo = "C"    --维护数据
    elseif mode == ReportMode.Fault then
        status.measure.newResult.measure.resultInfo = "D"    --故障数据
    elseif mode == ReportMode.Debugging then
        status.measure.newResult.measure.resultInfo = "A"    --调试数据
    end

    if mode == ReportMode.OnLine then
        if resultType == MeasureType.Blank then
            status.measure.newResult.measure.resultMark = "cz"           --测零点校准液(量程校准液一校准)
        elseif resultType == MeasureType.Standard or resultType == MeasureType.Check then
            status.measure.newResult.measure.resultMark = "cs"           --测量程校准液(量程校准液二校准)
        elseif resultType == MeasureType.ZeroCheck then
            status.measure.newResult.measure.resultMark = "bt"           --零点核查
        elseif resultType == MeasureType.RangeCheck then
            status.measure.newResult.measure.resultMark = "sc"           --量程核查
        elseif resultType == MeasureType.Parallel or resultType == MeasureType.ExtParallel then
            status.measure.newResult.measure.resultMark = "ps"           --平行样测试
        elseif resultType == MeasureType.Addstandard or resultType == MeasureType.ExtAddstandard then
            status.measure.newResult.measure.resultMark = "ra"           --加标回收率测试
        elseif resultType == MeasureType.Sample then
            if consistency > config.interconnection.meaUpLimit  then
                status.measure.newResult.measure.resultMark = "T"        --超仪器上限
            elseif consistency < config.interconnection.meaLowLimit then
                status.measure.newResult.measure.resultMark = "L"        --超仪器下限
            else
                status.measure.newResult.measure.resultMark = "N"        --正常
            end
        end
    elseif mode == ReportMode.OffLine then
        status.measure.newResult.measure.resultMark = "B"    --仪器离线
    elseif mode == ReportMode.Maintain or mode == ReportMode.Calibrate then
        status.measure.newResult.measure.resultMark = "M"    --维护数据
    elseif mode == ReportMode.Fault then
        status.measure.newResult.measure.resultMark = "D"    --故障数据
    end

    if mode ~= ReportMode.OffLine then
        status.measure.report.measure.resultType = resultType
    else
        status.measure.offline.measure.resultType = resultType
    end

    if resultType == MeasureType.Sample then
        status.measure.schedule.autoMeasure.dateTime = dateTime

        if mode ~= ReportMode.OffLine then
            status.measure.report.measure.resultInfo = status.measure.newResult.measure.resultInfo --更新数据标识
            status.measure.report.measure.dateTime = dateTime
            status.measure.report.measure.consistency = consistency
            status.measure.report.measure.resultType = resultType
            status.measure.report.measure.measureTime = os.time() - dateTime
            status.measure.report.measure.absorbance = absorbance
            --status.measure.report.measure.deviceTypeNum = setting.instrument.deviceTypeNum.COD
            --status.measure.report.measure.oldTypeNum = setting.instrument.oldTypeNum.COD
            currentResultManager:OutputSample(consistency)
            currentResultManager:OutputCheck(consistency)
            if mode == ReportMode.Calibrate and status.measure.report.measure.resultInfo ~= "D" then
                status.measure.report.measure.resultInfo = "C" --更新数据标识
            end
        else
            status.measure.offline.measure.resultInfo = status.measure.newResult.measure.resultInfo --更新数据标识
            status.measure.offline.measure.dateTime = dateTime
            status.measure.offline.measure.consistency = consistency
            status.measure.offline.measure.resultType = resultType
            status.measure.offline.measure.measureTime = os.time() - dateTime
            status.measure.offline.measure.absorbance = absorbance
            status.measure.offline.measure.deviceTypeNum = setting.instrument.deviceTypeNum.COD
            status.measure.offline.measure.oldTypeNum = setting.instrument.oldTypeNum.COD
        end
        --elseif resultType == MeasureType.Check then
        --    status.measure.schedule.autoAddstandard.dateTime = dateTime
    elseif resultType == MeasureType.Standard then
        status.measure.schedule.autoCheck.dateTime = dateTime

        if mode ~= ReportMode.OffLine then
            status.measure.report.check.resultInfo = status.measure.newResult.measure.resultInfo --更新数据标识
            status.measure.report.check.dateTime = dateTime
            status.measure.report.check.consistency = consistency
            status.measure.report.check.absorbance = absorbance
        else
            status.measure.offline.check.resultInfo = status.measure.newResult.measure.resultInfo --更新数据标识
            status.measure.offline.check.dateTime = dateTime
            status.measure.offline.check.consistency = consistency
            status.measure.offline.check.absorbance = absorbance
        end
    elseif resultType == MeasureType.Blank then
        status.measure.schedule.autoBlankCheck.dateTime = dateTime

        if mode ~= ReportMode.OffLine then
            status.measure.report.blankCheck.resultInfo = status.measure.newResult.measure.resultInfo --更新数据标识
            status.measure.report.blankCheck.dateTime = dateTime
            status.measure.report.blankCheck.consistency = consistency
            status.measure.report.blankCheck.absorbance = absorbance
        else
            status.measure.offline.blankCheck.resultInfo = status.measure.newResult.measure.resultInfo --更新数据标识
            status.measure.offline.blankCheck.dateTime = dateTime
            status.measure.offline.blankCheck.consistency = consistency
            status.measure.offline.blankCheck.absorbance = absorbance
        end
    elseif resultType == MeasureType.ZeroCheck then
        status.measure.schedule.zeroCheck.dateTime = dateTime

        if mode ~= ReportMode.OffLine and isReporting then
            status.measure.report.zeroCheck.resultInfo = status.measure.newResult.measure.resultInfo --更新数据标识
            status.measure.report.zeroCheck.dateTime = dateTime
            status.measure.report.zeroCheck.consistency = consistency
            status.measure.report.zeroCheck.absorbance = absorbance
        else
            status.measure.offline.zeroCheck.resultInfo = status.measure.newResult.measure.resultInfo --更新数据标识
            status.measure.offline.zeroCheck.dateTime = dateTime
            status.measure.offline.zeroCheck.consistency = consistency
            status.measure.offline.zeroCheck.absorbance = absorbance
        end
    elseif resultType == MeasureType.RangeCheck or resultType == MeasureType.Check then
        status.measure.schedule.rangeCheck.dateTime = dateTime

        if mode ~= ReportMode.OffLine and isReporting then
            status.measure.report.rangeCheck.resultInfo = status.measure.newResult.measure.resultInfo --更新数据标识
            status.measure.report.rangeCheck.dateTime = dateTime
            status.measure.report.rangeCheck.consistency = consistency
            status.measure.report.rangeCheck.absorbance = absorbance
        else
            status.measure.offline.rangeCheck.resultInfo = status.measure.newResult.measure.resultInfo --更新数据标识
            status.measure.offline.rangeCheck.dateTime = dateTime
            status.measure.offline.rangeCheck.consistency = consistency
            status.measure.offline.rangeCheck.absorbance = absorbance
        end
    elseif resultType == MeasureType.Addstandard or resultType == MeasureType.ExtAddstandard then
        status.measure.schedule.autoAddstandard.dateTime = dateTime

        if mode ~= ReportMode.OffLine then
            status.measure.report.addstandard.resultInfo = status.measure.newResult.measure.resultInfo --更新数据标识
            status.measure.report.addstandard.dateTime = dateTime
            status.measure.report.addstandard.consistency = consistency
            status.measure.report.addstandard.absorbance = absorbance
        else
            status.measure.offline.addstandard.resultInfo = status.measure.newResult.measure.resultInfo --更新数据标识
            status.measure.offline.addstandard.dateTime = dateTime
            status.measure.offline.addstandard.consistency = consistency
            status.measure.offline.addstandard.absorbance = absorbance
        end
    elseif resultType == MeasureType.Parallel or resultType == MeasureType.ExtParallel then
        status.measure.schedule.autoParallel.dateTime = dateTime

        if mode ~= ReportMode.OffLine then
            status.measure.report.parallel.resultInfo = status.measure.newResult.measure.resultInfo --更新数据标识
            status.measure.report.parallel.dateTime = dateTime
            status.measure.report.parallel.consistency = consistency
            status.measure.report.parallel.absorbance = absorbance
        else
            status.measure.offline.parallel.resultInfo = status.measure.newResult.measure.resultInfo --更新数据标识
            status.measure.offline.parallel.dateTime = dateTime
            status.measure.offline.parallel.consistency = consistency
            status.measure.offline.parallel.absorbance = absorbance
        end
    end

    Result.SetComplexResult(resultType, dateTime, consistency, mode, absorbance) --更新复合寄存器的结果

    if config.interconnection.alarmValue == true then
        if (consistency > 0)  and  measureResultMark == ResultMark.E and (resultType == MeasureType.Sample) then
            local alarm = MakeAlarm(setting.alarm.measureResultOutRange, "")
            AlarmManager.Instance():AddAlarm(alarm)
            if consistency > config.interconnection.meaUpLimit then
                Result.RelayOutOperate(setting.mode.relayOut.upLimit, true)
            end
        elseif consistency > config.interconnection.meaUpLimit and resultType == MeasureType.Sample then
            local alarm = MakeAlarm(setting.alarm.measureResultOutUpLimit, "")
            AlarmManager.Instance():AddAlarm(alarm)
            Result.RelayOutOperate(setting.mode.relayOut.upLimit, true)
        elseif (consistency > 0)  and  (config.interconnection.meaLowLimit - consistency > 0.001) and (resultType == MeasureType.Sample) then
            local alarm = MakeAlarm(setting.alarm.measureResultOutLowLimit, "")
            AlarmManager.Instance():AddAlarm(alarm)
            Result.RelayOutOperate(setting.mode.relayOut.lowLimit, true)
        else
            Result.RelayOutOperate(setting.mode.relayOut.upLimit, false)
            Result.RelayOutOperate(setting.mode.relayOut.lowLimit, false)
        end
    end

end

Result.OnMeasureResultAddedChannelOne = function(resultType, dateTime, consistency, mode, absorbance, isUseStart,isFault,resultMark,modbusStr,modelType)
    local currentResultManager = CurrentResultManager.Instance()

    local measureResultMark = ResultMark.N
    if nil ~= resultMark then
        measureResultMark = resultMark
    end

    local ModbusStr = ""
    if nil ~= modbusStr then
        ModbusStr = modbusStr
    end

    local isReporting = true
    if (resultType == MeasureType.ZeroCheck or resultType == MeasureType.RangeCheck) and false == config.measureParam.checkReporting then
        isReporting = false
    end

    if mode ~= ReportMode.OffLine and isReporting then
        status.measure.newResult.measureChannelOne.dateTime = dateTime
        status.measure.newResult.measureChannelOne.consistency = consistency
        status.measure.newResult.measureChannelOne.resultType = resultType
        status.measure.newResult.measureChannelOne.absorbance = absorbance
        status.measure.newResult.measureChannelOne.peakArea = absorbance
        status.measure.newResult.measureChannelOne.isUseStart = isUseStart
        status.measure.newResult.measureChannelOne.isFault = isFault
        status.measure.newResult.measureChannelOne.errorDateTime = dateTime
        status.measure.newResult.measureChannelOne.modelType = modelType
    end

    if mode == ReportMode.OnLine then
        if measureResultMark == ResultMark.T or measureResultMark == ResultMark.E then
            status.measure.newResult.measureChannelOne.resultInfo = "T"        --超仪器上限或者超量程（动态管控仅有T）
        elseif measureResultMark == ResultMark.K then
            status.measure.newResult.measureChannelOne.resultInfo = "K"
        elseif measureResultMark == ResultMark.C then
            status.measure.newResult.measureChannelOne.resultInfo = "C"
        else
            status.measure.newResult.measureChannelOne.resultInfo = "N"        --正常
        end
    elseif mode == ReportMode.OffLine then
        status.measure.newResult.measureChannelOne.resultInfo = "B"    --仪器离线
    elseif mode == ReportMode.Maintain then
        status.measure.newResult.measureChannelOne.resultInfo = "M"    --维护数据
    elseif mode == ReportMode.Calibrate then
        status.measure.newResult.measureChannelOne.resultInfo = "C"    --维护数据
    elseif mode == ReportMode.Fault then
        status.measure.newResult.measureChannelOne.resultInfo = "D"    --故障数据
    elseif mode == ReportMode.Debugging then
        status.measure.newResult.measureChannelOne.resultInfo = "A"    --调试数据
    end

    if mode == ReportMode.OnLine then
        if resultType == MeasureType.Blank then
            status.measure.newResult.measureChannelOne.resultMark = "cz"           --测零点校准液(量程校准液一校准)
        elseif resultType == MeasureType.Standard or resultType == MeasureType.Check then
            status.measure.newResult.measureChannelOne.resultMark = "cs"           --测量程校准液(量程校准液二校准)
        elseif resultType == MeasureType.ZeroCheck then
            status.measure.newResult.measureChannelOne.resultMark = "bt"           --零点核查
        elseif resultType == MeasureType.RangeCheck then
            status.measure.newResult.measureChannelOne.resultMark = "sc"           --量程核查
        elseif resultType == MeasureType.Parallel or resultType == MeasureType.ExtParallel then
            status.measure.newResult.measureChannelOne.resultMark = "ps"           --平行样测试
        elseif resultType == MeasureType.Addstandard or resultType == MeasureType.ExtAddstandard then
            status.measure.newResult.measureChannelOne.resultMark = "ra"           --加标回收率测试
        elseif resultType == MeasureType.Sample then
            if consistency > config.interconnection.meaUpLimit  then
                status.measure.newResult.measureChannelOne.resultMark = "T"        --超仪器上限
            elseif consistency < config.interconnection.meaLowLimit then
                status.measure.newResult.measureChannelOne.resultMark = "L"        --超仪器下限
            else
                status.measure.newResult.measureChannelOne.resultMark = "N"        --正常
            end
        end
    elseif mode == ReportMode.OffLine then
        status.measure.newResult.measureChannelOne.resultMark = "B"    --仪器离线
    elseif mode == ReportMode.Maintain or mode == ReportMode.Calibrate then
        status.measure.newResult.measureChannelOne.resultMark = "M"    --维护数据
    elseif mode == ReportMode.Fault then
        status.measure.newResult.measureChannelOne.resultMark = "D"    --故障数据
    end

    if mode ~= ReportMode.OffLine then
        status.measure.report.measureChannelOne.resultType = resultType
    else
        status.measure.offline.measureChannelOne.resultType = resultType
    end

    if resultType == MeasureType.Sample then
        status.measure.schedule.autoMeasureChannelOne.dateTime = dateTime

        if mode ~= ReportMode.OffLine then
            status.measure.report.measureChannelOne.resultInfo = status.measure.newResult.measureChannelOne.resultInfo --更新数据标识
            status.measure.report.measureChannelOne.dateTime = dateTime
            status.measure.report.measureChannelOne.consistency = consistency
            status.measure.report.measureChannelOne.resultType = resultType
            status.measure.report.measureChannelOne.measureTime = os.time() - dateTime
            status.measure.report.measureChannelOne.absorbance = absorbance
            --status.measure.report.measureChannelOne.deviceTypeNum = setting.instrument.deviceTypeNum.COD
            --status.measure.report.measureChannelOne.oldTypeNum = setting.instrument.oldTypeNum.COD
            currentResultManager:OutputSample(consistency)
            currentResultManager:OutputCheck(consistency)
            if mode == ReportMode.Calibrate and status.measure.report.measureChannelOne.resultInfo ~= "D" then
                status.measure.report.measureChannelOne.resultInfo = "C" --更新数据标识
            end
        else
            status.measure.offline.measureChannelOne.resultInfo = status.measure.newResult.measureChannelOne.resultInfo --更新数据标识
            status.measure.offline.measureChannelOne.dateTime = dateTime
            status.measure.offline.measureChannelOne.consistency = consistency
            status.measure.offline.measureChannelOne.resultType = resultType
            status.measure.offline.measureChannelOne.measureTime = os.time() - dateTime
            status.measure.offline.measureChannelOne.absorbance = absorbance
            status.measure.offline.measureChannelOne.deviceTypeNum = setting.instrument.deviceTypeNum.COD
            status.measure.offline.measureChannelOne.oldTypeNum = setting.instrument.oldTypeNum.COD
        end
        --elseif resultType == MeasureType.Check then
        --    status.measure.schedule.autoAddstandard.dateTime = dateTime
    elseif resultType == MeasureType.Standard then
        status.measure.schedule.autoCheckChannelOne.dateTime = dateTime

        if mode ~= ReportMode.OffLine then
            status.measure.report.checkChannelOne.resultInfo = status.measure.newResult.measureChannelOne.resultInfo --更新数据标识
            status.measure.report.checkChannelOne.dateTime = dateTime
            status.measure.report.checkChannelOne.consistency = consistency
            status.measure.report.checkChannelOne.absorbance = absorbance
        else
            status.measure.offline.checkChannelOne.resultInfo = status.measure.newResult.measureChannelOne.resultInfo --更新数据标识
            status.measure.offline.checkChannelOne.dateTime = dateTime
            status.measure.offline.checkChannelOne.consistency = consistency
            status.measure.offline.checkChannelOne.absorbance = absorbance
        end
    elseif resultType == MeasureType.Blank then
        status.measure.schedule.autoBlankCheckChannelOne.dateTime = dateTime

        if mode ~= ReportMode.OffLine then
            status.measure.report.blankCheckChannelOne.resultInfo = status.measure.newResult.measureChannelOne.resultInfo --更新数据标识
            status.measure.report.blankCheckChannelOne.dateTime = dateTime
            status.measure.report.blankCheckChannelOne.consistency = consistency
            status.measure.report.blankCheckChannelOne.absorbance = absorbance
        else
            status.measure.offline.blankCheckChannelOne.resultInfo = status.measure.newResult.measureChannelOne.resultInfo --更新数据标识
            status.measure.offline.blankCheckChannelOne.dateTime = dateTime
            status.measure.offline.blankCheckChannelOne.consistency = consistency
            status.measure.offline.blankCheckChannelOne.absorbance = absorbance
        end
    elseif resultType == MeasureType.ZeroCheck then
        status.measure.schedule.zeroCheckChannelOne.dateTime = dateTime

        if mode ~= ReportMode.OffLine and isReporting then
            status.measure.report.zeroCheckChannelOne.resultInfo = status.measure.newResult.measureChannelOne.resultInfo --更新数据标识
            status.measure.report.zeroCheckChannelOne.dateTime = dateTime
            status.measure.report.zeroCheckChannelOne.consistency = consistency
            status.measure.report.zeroCheckChannelOne.absorbance = absorbance
        else
            status.measure.offline.zeroCheckChannelOne.resultInfo = status.measure.newResult.measureChannelOne.resultInfo --更新数据标识
            status.measure.offline.zeroCheckChannelOne.dateTime = dateTime
            status.measure.offline.zeroCheckChannelOne.consistency = consistency
            status.measure.offline.zeroCheckChannelOne.absorbance = absorbance
        end
    elseif resultType == MeasureType.RangeCheck or resultType == MeasureType.Check then
        status.measure.schedule.rangeCheckChannelOne.dateTime = dateTime

        if mode ~= ReportMode.OffLine and isReporting then
            status.measure.report.rangeCheckChannelOne.resultInfo = status.measure.newResult.measureChannelOne.resultInfo --更新数据标识
            status.measure.report.rangeCheckChannelOne.dateTime = dateTime
            status.measure.report.rangeCheckChannelOne.consistency = consistency
            status.measure.report.rangeCheckChannelOne.absorbance = absorbance
        else
            status.measure.offline.rangeCheckChannelOne.resultInfo = status.measure.newResult.measureChannelOne.resultInfo --更新数据标识
            status.measure.offline.rangeCheckChannelOne.dateTime = dateTime
            status.measure.offline.rangeCheckChannelOne.consistency = consistency
            status.measure.offline.rangeCheckChannelOne.absorbance = absorbance
        end
    elseif resultType == MeasureType.Addstandard or resultType == MeasureType.ExtAddstandard then
        status.measure.schedule.autoAddstandardChannelOne.dateTime = dateTime

        if mode ~= ReportMode.OffLine then
            status.measure.report.addstandardChannelOne.resultInfo = status.measure.newResult.measureChannelOne.resultInfo --更新数据标识
            status.measure.report.addstandardChannelOne.dateTime = dateTime
            status.measure.report.addstandardChannelOne.consistency = consistency
            status.measure.report.addstandardChannelOne.absorbance = absorbance
        else
            status.measure.offline.addstandardChannelOne.resultInfo = status.measure.newResult.measureChannelOne.resultInfo --更新数据标识
            status.measure.offline.addstandardChannelOne.dateTime = dateTime
            status.measure.offline.addstandardChannelOne.consistency = consistency
            status.measure.offline.addstandardChannelOne.absorbance = absorbance
        end
    elseif resultType == MeasureType.Parallel or resultType == MeasureType.ExtParallel then
        status.measure.schedule.autoParallelChannelOne.dateTime = dateTime

        if mode ~= ReportMode.OffLine then
            status.measure.report.parallelChannelOne.resultInfo = status.measure.newResult.measureChannelOne.resultInfo --更新数据标识
            status.measure.report.parallelChannelOne.dateTime = dateTime
            status.measure.report.parallelChannelOne.consistency = consistency
            status.measure.report.parallelChannelOne.absorbance = absorbance
        else
            status.measure.offline.parallelChannelOne.resultInfo = status.measure.newResult.measureChannelOne.resultInfo --更新数据标识
            status.measure.offline.parallelChannelOne.dateTime = dateTime
            status.measure.offline.parallelChannelOne.consistency = consistency
            status.measure.offline.parallelChannelOne.absorbance = absorbance
        end
    end

    Result.SetComplexResult(resultType, dateTime, consistency, mode, absorbance) --更新复合寄存器的结果

    if config.interconnection.alarmValue == true then
        if (consistency > 0)  and  measureResultMark == ResultMark.E and (resultType == MeasureType.Sample) then
            local alarm = MakeAlarm(setting.alarm.measureResultOutRange, "")
            AlarmManager.Instance():AddAlarm(alarm)
            if consistency > config.interconnection.meaUpLimit then
                Result.RelayOutOperate(setting.mode.relayOut.upLimit, true)
            end
        elseif consistency > config.interconnection.meaUpLimit and resultType == MeasureType.Sample then
            local alarm = MakeAlarm(setting.alarm.measureResultOutUpLimit, "")
            AlarmManager.Instance():AddAlarm(alarm)
            Result.RelayOutOperate(setting.mode.relayOut.upLimit, true)
        elseif (consistency > 0)  and  (config.interconnection.meaLowLimit - consistency > 0.001) and (resultType == MeasureType.Sample) then
            local alarm = MakeAlarm(setting.alarm.measureResultOutLowLimit, "")
            AlarmManager.Instance():AddAlarm(alarm)
            Result.RelayOutOperate(setting.mode.relayOut.lowLimit, true)
        else
            Result.RelayOutOperate(setting.mode.relayOut.upLimit, false)
            Result.RelayOutOperate(setting.mode.relayOut.lowLimit, false)
        end
    end

end

Result.OnMeasureResultAddedChannelTwo = function(resultType, dateTime, consistency, mode, absorbance, isUseStart,isFault,resultMark,modbusStr,modelType)
    local currentResultManager = CurrentResultManager.Instance()

    local measureResultMark = ResultMark.N
    if nil ~= resultMark then
        measureResultMark = resultMark
    end

    local ModbusStr = ""
    if nil ~= modbusStr then
        ModbusStr = modbusStr
    end

    local isReporting = true
    if (resultType == MeasureType.ZeroCheck or resultType == MeasureType.RangeCheck) and false == config.measureParam.checkReporting then
        isReporting = false
    end

    if mode ~= ReportMode.OffLine and isReporting then
        status.measure.newResult.measureChannelTwo.dateTime = dateTime
        status.measure.newResult.measureChannelTwo.consistency = consistency
        status.measure.newResult.measureChannelTwo.resultType = resultType
        status.measure.newResult.measureChannelTwo.absorbance = absorbance
        status.measure.newResult.measureChannelTwo.peakArea = absorbance
        status.measure.newResult.measureChannelTwo.isUseStart = isUseStart
        status.measure.newResult.measureChannelTwo.isFault = isFault
        status.measure.newResult.measureChannelTwo.errorDateTime = dateTime
        status.measure.newResult.measureChannelTwo.modelType = modelType
    end

    if mode == ReportMode.OnLine then
        if measureResultMark == ResultMark.T or measureResultMark == ResultMark.E then
            status.measure.newResult.measureChannelTwo.resultInfo = "T"        --超仪器上限或者超量程（动态管控仅有T）
        elseif measureResultMark == ResultMark.K then
            status.measure.newResult.measureChannelTwo.resultInfo = "K"
        elseif measureResultMark == ResultMark.C then
            status.measure.newResult.measureChannelTwo.resultInfo = "C"
        else
            status.measure.newResult.measureChannelTwo.resultInfo = "N"        --正常
        end
    elseif mode == ReportMode.OffLine then
        status.measure.newResult.measureChannelTwo.resultInfo = "B"    --仪器离线
    elseif mode == ReportMode.Maintain then
        status.measure.newResult.measureChannelTwo.resultInfo = "M"    --维护数据
    elseif mode == ReportMode.Calibrate then
        status.measure.newResult.measureChannelTwo.resultInfo = "C"    --维护数据
    elseif mode == ReportMode.Fault then
        status.measure.newResult.measureChannelTwo.resultInfo = "D"    --故障数据
    elseif mode == ReportMode.Debugging then
        status.measure.newResult.measureChannelTwo.resultInfo = "A"    --调试数据
    end

    if mode == ReportMode.OnLine then
        if resultType == MeasureType.Blank then
            status.measure.newResult.measureChannelTwo.resultMark = "cz"           --测零点校准液(量程校准液一校准)
        elseif resultType == MeasureType.Standard or resultType == MeasureType.Check then
            status.measure.newResult.measureChannelTwo.resultMark = "cs"           --测量程校准液(量程校准液二校准)
        elseif resultType == MeasureType.ZeroCheck then
            status.measure.newResult.measureChannelTwo.resultMark = "bt"           --零点核查
        elseif resultType == MeasureType.RangeCheck then
            status.measure.newResult.measureChannelTwo.resultMark = "sc"           --量程核查
        elseif resultType == MeasureType.Parallel or resultType == MeasureType.ExtParallel then
            status.measure.newResult.measureChannelTwo.resultMark = "ps"           --平行样测试
        elseif resultType == MeasureType.Addstandard or resultType == MeasureType.ExtAddstandard then
            status.measure.newResult.measureChannelTwo.resultMark = "ra"           --加标回收率测试
        elseif resultType == MeasureType.Sample then
            if consistency > config.interconnection.meaUpLimit  then
                status.measure.newResult.measureChannelTwo.resultMark = "T"        --超仪器上限
            elseif consistency < config.interconnection.meaLowLimit then
                status.measure.newResult.measureChannelTwo.resultMark = "L"        --超仪器下限
            else
                status.measure.newResult.measureChannelTwo.resultMark = "N"        --正常
            end
        end
    elseif mode == ReportMode.OffLine then
        status.measure.newResult.measureChannelTwo.resultMark = "B"    --仪器离线
    elseif mode == ReportMode.Maintain or mode == ReportMode.Calibrate then
        status.measure.newResult.measureChannelTwo.resultMark = "M"    --维护数据
    elseif mode == ReportMode.Fault then
        status.measure.newResult.measureChannelTwo.resultMark = "D"    --故障数据
    end

    if mode ~= ReportMode.OffLine then
        status.measure.report.measureChannelTwo.resultType = resultType
    else
        status.measure.offline.measureChannelTwo.resultType = resultType
    end

    if resultType == MeasureType.Sample then
        status.measure.schedule.autoMeasureChannelTwo.dateTime = dateTime

        if mode ~= ReportMode.OffLine then
            status.measure.report.measureChannelTwo.resultInfo = status.measure.newResult.measureChannelTwo.resultInfo --更新数据标识
            status.measure.report.measureChannelTwo.dateTime = dateTime
            status.measure.report.measureChannelTwo.consistency = consistency
            status.measure.report.measureChannelTwo.resultType = resultType
            status.measure.report.measureChannelTwo.measureTime = os.time() - dateTime
            status.measure.report.measureChannelTwo.absorbance = absorbance
            --status.measure.report.measureChannelTwo.deviceTypeNum = setting.instrument.deviceTypeNum.COD
            --status.measure.report.measureChannelTwo.oldTypeNum = setting.instrument.oldTypeNum.COD
            currentResultManager:OutputSample(consistency)
            currentResultManager:OutputCheck(consistency)
            if mode == ReportMode.Calibrate and status.measure.report.measureChannelTwo.resultInfo ~= "D" then
                status.measure.report.measureChannelTwo.resultInfo = "C" --更新数据标识
            end
        else
            status.measure.offline.measureChannelTwo.resultInfo = status.measure.newResult.measureChannelTwo.resultInfo --更新数据标识
            status.measure.offline.measureChannelTwo.dateTime = dateTime
            status.measure.offline.measureChannelTwo.consistency = consistency
            status.measure.offline.measureChannelTwo.resultType = resultType
            status.measure.offline.measureChannelTwo.measureTime = os.time() - dateTime
            status.measure.offline.measureChannelTwo.absorbance = absorbance
            status.measure.offline.measureChannelTwo.deviceTypeNum = setting.instrument.deviceTypeNum.COD
            status.measure.offline.measureChannelTwo.oldTypeNum = setting.instrument.oldTypeNum.COD
        end
        --elseif resultType == MeasureType.Check then
        --    status.measure.schedule.autoAddstandard.dateTime = dateTime
    elseif resultType == MeasureType.Standard then
        status.measure.schedule.autoCheckChannelTwo.dateTime = dateTime

        if mode ~= ReportMode.OffLine then
            status.measure.report.checkChannelTwo.resultInfo = status.measure.newResult.measureChannelTwo.resultInfo --更新数据标识
            status.measure.report.checkChannelTwo.dateTime = dateTime
            status.measure.report.checkChannelTwo.consistency = consistency
            status.measure.report.checkChannelTwo.absorbance = absorbance
        else
            status.measure.offline.checkChannelTwo.resultInfo = status.measure.newResult.measureChannelTwo.resultInfo --更新数据标识
            status.measure.offline.checkChannelTwo.dateTime = dateTime
            status.measure.offline.checkChannelTwo.consistency = consistency
            status.measure.offline.checkChannelTwo.absorbance = absorbance
        end
    elseif resultType == MeasureType.Blank then
        status.measure.schedule.autoBlankCheckChannelTwo.dateTime = dateTime

        if mode ~= ReportMode.OffLine then
            status.measure.report.blankCheckChannelTwo.resultInfo = status.measure.newResult.measureChannelTwo.resultInfo --更新数据标识
            status.measure.report.blankCheckChannelTwo.dateTime = dateTime
            status.measure.report.blankCheckChannelTwo.consistency = consistency
            status.measure.report.blankCheckChannelTwo.absorbance = absorbance
        else
            status.measure.offline.blankCheckChannelTwo.resultInfo = status.measure.newResult.measureChannelTwo.resultInfo --更新数据标识
            status.measure.offline.blankCheckChannelTwo.dateTime = dateTime
            status.measure.offline.blankCheckChannelTwo.consistency = consistency
            status.measure.offline.blankCheckChannelTwo.absorbance = absorbance
        end
    elseif resultType == MeasureType.ZeroCheck then
        status.measure.schedule.zeroCheckChannelTwo.dateTime = dateTime

        if mode ~= ReportMode.OffLine and isReporting then
            status.measure.report.zeroCheckChannelTwo.resultInfo = status.measure.newResult.measureChannelTwo.resultInfo --更新数据标识
            status.measure.report.zeroCheckChannelTwo.dateTime = dateTime
            status.measure.report.zeroCheckChannelTwo.consistency = consistency
            status.measure.report.zeroCheckChannelTwo.absorbance = absorbance
        else
            status.measure.offline.zeroCheckChannelTwo.resultInfo = status.measure.newResult.measureChannelTwo.resultInfo --更新数据标识
            status.measure.offline.zeroCheckChannelTwo.dateTime = dateTime
            status.measure.offline.zeroCheckChannelTwo.consistency = consistency
            status.measure.offline.zeroCheckChannelTwo.absorbance = absorbance
        end
    elseif resultType == MeasureType.RangeCheck or resultType == MeasureType.Check then
        status.measure.schedule.rangeCheckChannelTwo.dateTime = dateTime

        if mode ~= ReportMode.OffLine and isReporting then
            status.measure.report.rangeCheckChannelTwo.resultInfo = status.measure.newResult.measureChannelTwo.resultInfo --更新数据标识
            status.measure.report.rangeCheckChannelTwo.dateTime = dateTime
            status.measure.report.rangeCheckChannelTwo.consistency = consistency
            status.measure.report.rangeCheckChannelTwo.absorbance = absorbance
        else
            status.measure.offline.rangeCheckChannelTwo.resultInfo = status.measure.newResult.measureChannelTwo.resultInfo --更新数据标识
            status.measure.offline.rangeCheckChannelTwo.dateTime = dateTime
            status.measure.offline.rangeCheckChannelTwo.consistency = consistency
            status.measure.offline.rangeCheckChannelTwo.absorbance = absorbance
        end
    elseif resultType == MeasureType.Addstandard or resultType == MeasureType.ExtAddstandard then
        status.measure.schedule.autoAddstandardChannelTwo.dateTime = dateTime

        if mode ~= ReportMode.OffLine then
            status.measure.report.addstandardChannelTwo.resultInfo = status.measure.newResult.measureChannelTwo.resultInfo --更新数据标识
            status.measure.report.addstandardChannelTwo.dateTime = dateTime
            status.measure.report.addstandardChannelTwo.consistency = consistency
            status.measure.report.addstandardChannelTwo.absorbance = absorbance
        else
            status.measure.offline.addstandardChannelTwo.resultInfo = status.measure.newResult.measureChannelTwo.resultInfo --更新数据标识
            status.measure.offline.addstandardChannelTwo.dateTime = dateTime
            status.measure.offline.addstandardChannelTwo.consistency = consistency
            status.measure.offline.addstandardChannelTwo.absorbance = absorbance
        end
    elseif resultType == MeasureType.Parallel or resultType == MeasureType.ExtParallel then
        status.measure.schedule.autoParallelChannelTwo.dateTime = dateTime

        if mode ~= ReportMode.OffLine then
            status.measure.report.parallelChannelTwo.resultInfo = status.measure.newResult.measureChannelTwo.resultInfo --更新数据标识
            status.measure.report.parallelChannelTwo.dateTime = dateTime
            status.measure.report.parallelChannelTwo.consistency = consistency
            status.measure.report.parallelChannelTwo.absorbance = absorbance
        else
            status.measure.offline.parallelChannelTwo.resultInfo = status.measure.newResult.measureChannelTwo.resultInfo --更新数据标识
            status.measure.offline.parallelChannelTwo.dateTime = dateTime
            status.measure.offline.parallelChannelTwo.consistency = consistency
            status.measure.offline.parallelChannelTwo.absorbance = absorbance
        end
    end

    Result.SetComplexResult(resultType, dateTime, consistency, mode, absorbance) --更新复合寄存器的结果

    if config.interconnection.alarmValue == true then
        if (consistency > 0)  and  measureResultMark == ResultMark.E and (resultType == MeasureType.Sample) then
            local alarm = MakeAlarm(setting.alarm.measureResultOutRange, "")
            AlarmManager.Instance():AddAlarm(alarm)
            if consistency > config.interconnection.meaUpLimit then
                Result.RelayOutOperate(setting.mode.relayOut.upLimit, true)
            end
        elseif consistency > config.interconnection.meaUpLimit and resultType == MeasureType.Sample then
            local alarm = MakeAlarm(setting.alarm.measureResultOutUpLimit, "")
            AlarmManager.Instance():AddAlarm(alarm)
            Result.RelayOutOperate(setting.mode.relayOut.upLimit, true)
        elseif (consistency > 0)  and  (config.interconnection.meaLowLimit - consistency > 0.001) and (resultType == MeasureType.Sample) then
            local alarm = MakeAlarm(setting.alarm.measureResultOutLowLimit, "")
            AlarmManager.Instance():AddAlarm(alarm)
            Result.RelayOutOperate(setting.mode.relayOut.lowLimit, true)
        else
            Result.RelayOutOperate(setting.mode.relayOut.upLimit, false)
            Result.RelayOutOperate(setting.mode.relayOut.lowLimit, false)
        end
    end

end

Result.OnMeasureResultAddedChannelThree = function(resultType, dateTime, consistency, mode, absorbance, isUseStart,isFault,resultMark,modbusStr,modelType)
    local currentResultManager = CurrentResultManager.Instance()

    local measureResultMark = ResultMark.N
    if nil ~= resultMark then
        measureResultMark = resultMark
    end

    local ModbusStr = ""
    if nil ~= modbusStr then
        ModbusStr = modbusStr
    end

    local isReporting = true
    if (resultType == MeasureType.ZeroCheck or resultType == MeasureType.RangeCheck) and false == config.measureParam.checkReporting then
        isReporting = false
    end

    if mode ~= ReportMode.OffLine and isReporting then
        status.measure.newResult.measureChannelThree.dateTime = dateTime
        status.measure.newResult.measureChannelThree.consistency = consistency
        status.measure.newResult.measureChannelThree.resultType = resultType
        status.measure.newResult.measureChannelThree.absorbance = absorbance
        status.measure.newResult.measureChannelThree.peakArea = absorbance
        status.measure.newResult.measureChannelThree.isUseStart = isUseStart
        status.measure.newResult.measureChannelThree.isFault = isFault
        status.measure.newResult.measureChannelThree.errorDateTime = dateTime
        status.measure.newResult.measureChannelThree.modelType = modelType
    end

    if mode == ReportMode.OnLine then
        if measureResultMark == ResultMark.T or measureResultMark == ResultMark.E then
            status.measure.newResult.measureChannelThree.resultInfo = "T"        --超仪器上限或者超量程（动态管控仅有T）
        elseif measureResultMark == ResultMark.K then
            status.measure.newResult.measureChannelThree.resultInfo = "K"
        elseif measureResultMark == ResultMark.C then
            status.measure.newResult.measureChannelThree.resultInfo = "C"
        else
            status.measure.newResult.measureChannelThree.resultInfo = "N"        --正常
        end
    elseif mode == ReportMode.OffLine then
        status.measure.newResult.measureChannelThree.resultInfo = "B"    --仪器离线
    elseif mode == ReportMode.Maintain then
        status.measure.newResult.measureChannelThree.resultInfo = "M"    --维护数据
    elseif mode == ReportMode.Calibrate then
        status.measure.newResult.measureChannelThree.resultInfo = "C"    --维护数据
    elseif mode == ReportMode.Fault then
        status.measure.newResult.measureChannelThree.resultInfo = "D"    --故障数据
    elseif mode == ReportMode.Debugging then
        status.measure.newResult.measureChannelThree.resultInfo = "A"    --调试数据
    end

    if mode == ReportMode.OnLine then
        if resultType == MeasureType.Blank then
            status.measure.newResult.measureChannelThree.resultMark = "cz"           --测零点校准液(量程校准液一校准)
        elseif resultType == MeasureType.Standard or resultType == MeasureType.Check then
            status.measure.newResult.measureChannelThree.resultMark = "cs"           --测量程校准液(量程校准液二校准)
        elseif resultType == MeasureType.ZeroCheck then
            status.measure.newResult.measureChannelThree.resultMark = "bt"           --零点核查
        elseif resultType == MeasureType.RangeCheck then
            status.measure.newResult.measureChannelThree.resultMark = "sc"           --量程核查
        elseif resultType == MeasureType.Parallel or resultType == MeasureType.ExtParallel then
            status.measure.newResult.measureChannelThree.resultMark = "ps"           --平行样测试
        elseif resultType == MeasureType.Addstandard or resultType == MeasureType.ExtAddstandard then
            status.measure.newResult.measureChannelThree.resultMark = "ra"           --加标回收率测试
        elseif resultType == MeasureType.Sample then
            if consistency > config.interconnection.meaUpLimit  then
                status.measure.newResult.measureChannelThree.resultMark = "T"        --超仪器上限
            elseif consistency < config.interconnection.meaLowLimit then
                status.measure.newResult.measureChannelThree.resultMark = "L"        --超仪器下限
            else
                status.measure.newResult.measureChannelThree.resultMark = "N"        --正常
            end
        end
    elseif mode == ReportMode.OffLine then
        status.measure.newResult.measureChannelThree.resultMark = "B"    --仪器离线
    elseif mode == ReportMode.Maintain or mode == ReportMode.Calibrate then
        status.measure.newResult.measureChannelThree.resultMark = "M"    --维护数据
    elseif mode == ReportMode.Fault then
        status.measure.newResult.measureChannelThree.resultMark = "D"    --故障数据
    end

    if mode ~= ReportMode.OffLine then
        status.measure.report.measureChannelThree.resultType = resultType
    else
        status.measure.offline.measureChannelThree.resultType = resultType
    end

    if resultType == MeasureType.Sample then
        status.measure.schedule.autoMeasureChannelThree.dateTime = dateTime

        if mode ~= ReportMode.OffLine then
            status.measure.report.measureChannelThree.resultInfo = status.measure.newResult.measureChannelThree.resultInfo --更新数据标识
            status.measure.report.measureChannelThree.dateTime = dateTime
            status.measure.report.measureChannelThree.consistency = consistency
            status.measure.report.measureChannelThree.resultType = resultType
            status.measure.report.measureChannelThree.measureTime = os.time() - dateTime
            status.measure.report.measureChannelThree.absorbance = absorbance
            --status.measure.report.measureChannelThree.deviceTypeNum = setting.instrument.deviceTypeNum.COD
            --status.measure.report.measureChannelThree.oldTypeNum = setting.instrument.oldTypeNum.COD
            currentResultManager:OutputSample(consistency)
            currentResultManager:OutputCheck(consistency)
            if mode == ReportMode.Calibrate and status.measure.report.measureChannelThree.resultInfo ~= "D" then
                status.measure.report.measureChannelThree.resultInfo = "C" --更新数据标识
            end
        else
            status.measure.offline.measureChannelThree.resultInfo = status.measure.newResult.measureChannelThree.resultInfo --更新数据标识
            status.measure.offline.measureChannelThree.dateTime = dateTime
            status.measure.offline.measureChannelThree.consistency = consistency
            status.measure.offline.measureChannelThree.resultType = resultType
            status.measure.offline.measureChannelThree.measureTime = os.time() - dateTime
            status.measure.offline.measureChannelThree.absorbance = absorbance
            status.measure.offline.measureChannelThree.deviceTypeNum = setting.instrument.deviceTypeNum.COD
            status.measure.offline.measureChannelThree.oldTypeNum = setting.instrument.oldTypeNum.COD
        end
        --elseif resultType == MeasureType.Check then
        --    status.measure.schedule.autoAddstandard.dateTime = dateTime
    elseif resultType == MeasureType.Standard then
        status.measure.schedule.autoCheckChannelThree.dateTime = dateTime

        if mode ~= ReportMode.OffLine then
            status.measure.report.checkChannelThree.resultInfo = status.measure.newResult.measureChannelThree.resultInfo --更新数据标识
            status.measure.report.checkChannelThree.dateTime = dateTime
            status.measure.report.checkChannelThree.consistency = consistency
            status.measure.report.checkChannelThree.absorbance = absorbance
        else
            status.measure.offline.checkChannelThree.resultInfo = status.measure.newResult.measureChannelThree.resultInfo --更新数据标识
            status.measure.offline.checkChannelThree.dateTime = dateTime
            status.measure.offline.checkChannelThree.consistency = consistency
            status.measure.offline.checkChannelThree.absorbance = absorbance
        end
    elseif resultType == MeasureType.Blank then
        status.measure.schedule.autoBlankCheckChannelThree.dateTime = dateTime

        if mode ~= ReportMode.OffLine then
            status.measure.report.blankCheckChannelThree.resultInfo = status.measure.newResult.measureChannelThree.resultInfo --更新数据标识
            status.measure.report.blankCheckChannelThree.dateTime = dateTime
            status.measure.report.blankCheckChannelThree.consistency = consistency
            status.measure.report.blankCheckChannelThree.absorbance = absorbance
        else
            status.measure.offline.blankCheckChannelThree.resultInfo = status.measure.newResult.measureChannelThree.resultInfo --更新数据标识
            status.measure.offline.blankCheckChannelThree.dateTime = dateTime
            status.measure.offline.blankCheckChannelThree.consistency = consistency
            status.measure.offline.blankCheckChannelThree.absorbance = absorbance
        end
    elseif resultType == MeasureType.ZeroCheck then
        status.measure.schedule.zeroCheckChannelThree.dateTime = dateTime

        if mode ~= ReportMode.OffLine and isReporting then
            status.measure.report.zeroCheckChannelThree.resultInfo = status.measure.newResult.measureChannelThree.resultInfo --更新数据标识
            status.measure.report.zeroCheckChannelThree.dateTime = dateTime
            status.measure.report.zeroCheckChannelThree.consistency = consistency
            status.measure.report.zeroCheckChannelThree.absorbance = absorbance
        else
            status.measure.offline.zeroCheckChannelThree.resultInfo = status.measure.newResult.measureChannelThree.resultInfo --更新数据标识
            status.measure.offline.zeroCheckChannelThree.dateTime = dateTime
            status.measure.offline.zeroCheckChannelThree.consistency = consistency
            status.measure.offline.zeroCheckChannelThree.absorbance = absorbance
        end
    elseif resultType == MeasureType.RangeCheck or resultType == MeasureType.Check then
        status.measure.schedule.rangeCheckChannelThree.dateTime = dateTime

        if mode ~= ReportMode.OffLine and isReporting then
            status.measure.report.rangeCheckChannelThree.resultInfo = status.measure.newResult.measureChannelThree.resultInfo --更新数据标识
            status.measure.report.rangeCheckChannelThree.dateTime = dateTime
            status.measure.report.rangeCheckChannelThree.consistency = consistency
            status.measure.report.rangeCheckChannelThree.absorbance = absorbance
        else
            status.measure.offline.rangeCheckChannelThree.resultInfo = status.measure.newResult.measureChannelThree.resultInfo --更新数据标识
            status.measure.offline.rangeCheckChannelThree.dateTime = dateTime
            status.measure.offline.rangeCheckChannelThree.consistency = consistency
            status.measure.offline.rangeCheckChannelThree.absorbance = absorbance
        end
    elseif resultType == MeasureType.Addstandard or resultType == MeasureType.ExtAddstandard then
        status.measure.schedule.autoAddstandardChannelThree.dateTime = dateTime

        if mode ~= ReportMode.OffLine then
            status.measure.report.addstandardChannelThree.resultInfo = status.measure.newResult.measureChannelThree.resultInfo --更新数据标识
            status.measure.report.addstandardChannelThree.dateTime = dateTime
            status.measure.report.addstandardChannelThree.consistency = consistency
            status.measure.report.addstandardChannelThree.absorbance = absorbance
        else
            status.measure.offline.addstandardChannelThree.resultInfo = status.measure.newResult.measureChannelThree.resultInfo --更新数据标识
            status.measure.offline.addstandardChannelThree.dateTime = dateTime
            status.measure.offline.addstandardChannelThree.consistency = consistency
            status.measure.offline.addstandardChannelThree.absorbance = absorbance
        end
    elseif resultType == MeasureType.Parallel or resultType == MeasureType.ExtParallel then
        status.measure.schedule.autoParallelChannelThree.dateTime = dateTime

        if mode ~= ReportMode.OffLine then
            status.measure.report.parallelChannelThree.resultInfo = status.measure.newResult.measureChannelThree.resultInfo --更新数据标识
            status.measure.report.parallelChannelThree.dateTime = dateTime
            status.measure.report.parallelChannelThree.consistency = consistency
            status.measure.report.parallelChannelThree.absorbance = absorbance
        else
            status.measure.offline.parallelChannelThree.resultInfo = status.measure.newResult.measureChannelThree.resultInfo --更新数据标识
            status.measure.offline.parallelChannelThree.dateTime = dateTime
            status.measure.offline.parallelChannelThree.consistency = consistency
            status.measure.offline.parallelChannelThree.absorbance = absorbance
        end
    end

    Result.SetComplexResult(resultType, dateTime, consistency, mode, absorbance) --更新复合寄存器的结果

    if config.interconnection.alarmValue == true then
        if (consistency > 0)  and  measureResultMark == ResultMark.E and (resultType == MeasureType.Sample) then
            local alarm = MakeAlarm(setting.alarm.measureResultOutRange, "")
            AlarmManager.Instance():AddAlarm(alarm)
            if consistency > config.interconnection.meaUpLimit then
                Result.RelayOutOperate(setting.mode.relayOut.upLimit, true)
            end
        elseif consistency > config.interconnection.meaUpLimit and resultType == MeasureType.Sample then
            local alarm = MakeAlarm(setting.alarm.measureResultOutUpLimit, "")
            AlarmManager.Instance():AddAlarm(alarm)
            Result.RelayOutOperate(setting.mode.relayOut.upLimit, true)
        elseif (consistency > 0)  and  (config.interconnection.meaLowLimit - consistency > 0.001) and (resultType == MeasureType.Sample) then
            local alarm = MakeAlarm(setting.alarm.measureResultOutLowLimit, "")
            AlarmManager.Instance():AddAlarm(alarm)
            Result.RelayOutOperate(setting.mode.relayOut.lowLimit, true)
        else
            Result.RelayOutOperate(setting.mode.relayOut.upLimit, false)
            Result.RelayOutOperate(setting.mode.relayOut.lowLimit, false)
        end
    end

end

Result.OnMeasureResultAddedChannelFour = function(resultType, dateTime, consistency, mode, absorbance, isUseStart,isFault,resultMark,modbusStr,modelType)
    local currentResultManager = CurrentResultManager.Instance()

    local measureResultMark = ResultMark.N
    if nil ~= resultMark then
        measureResultMark = resultMark
    end

    local ModbusStr = ""
    if nil ~= modbusStr then
        ModbusStr = modbusStr
    end

    local isReporting = true
    if (resultType == MeasureType.ZeroCheck or resultType == MeasureType.RangeCheck) and false == config.measureParam.checkReporting then
        isReporting = false
    end

    if mode ~= ReportMode.OffLine and isReporting then
        status.measure.newResult.measureChannelFour.dateTime = dateTime
        status.measure.newResult.measureChannelFour.consistency = consistency
        status.measure.newResult.measureChannelFour.resultType = resultType
        status.measure.newResult.measureChannelFour.absorbance = absorbance
        status.measure.newResult.measureChannelFour.peakArea = absorbance
        status.measure.newResult.measureChannelFour.isUseStart = isUseStart
        status.measure.newResult.measureChannelFour.isFault = isFault
        status.measure.newResult.measureChannelFour.errorDateTime = dateTime
        status.measure.newResult.measureChannelFour.modelType = modelType
    end

    if mode == ReportMode.OnLine then
        if measureResultMark == ResultMark.T or measureResultMark == ResultMark.E then
            status.measure.newResult.measureChannelFour.resultInfo = "T"        --超仪器上限或者超量程（动态管控仅有T）
        elseif measureResultMark == ResultMark.K then
            status.measure.newResult.measureChannelFour.resultInfo = "K"
        elseif measureResultMark == ResultMark.C then
            status.measure.newResult.measureChannelFour.resultInfo = "C"
        else
            status.measure.newResult.measureChannelFour.resultInfo = "N"        --正常
        end
    elseif mode == ReportMode.OffLine then
        status.measure.newResult.measureChannelFour.resultInfo = "B"    --仪器离线
    elseif mode == ReportMode.Maintain then
        status.measure.newResult.measureChannelFour.resultInfo = "M"    --维护数据
    elseif mode == ReportMode.Calibrate then
        status.measure.newResult.measureChannelFour.resultInfo = "C"    --维护数据
    elseif mode == ReportMode.Fault then
        status.measure.newResult.measureChannelFour.resultInfo = "D"    --故障数据
    elseif mode == ReportMode.Debugging then
        status.measure.newResult.measureChannelFour.resultInfo = "A"    --调试数据
    end

    if mode == ReportMode.OnLine then
        if resultType == MeasureType.Blank then
            status.measure.newResult.measureChannelFour.resultMark = "cz"           --测零点校准液(量程校准液一校准)
        elseif resultType == MeasureType.Standard or resultType == MeasureType.Check then
            status.measure.newResult.measureChannelFour.resultMark = "cs"           --测量程校准液(量程校准液二校准)
        elseif resultType == MeasureType.ZeroCheck then
            status.measure.newResult.measureChannelFour.resultMark = "bt"           --零点核查
        elseif resultType == MeasureType.RangeCheck then
            status.measure.newResult.measureChannelFour.resultMark = "sc"           --量程核查
        elseif resultType == MeasureType.Parallel or resultType == MeasureType.ExtParallel then
            status.measure.newResult.measureChannelFour.resultMark = "ps"           --平行样测试
        elseif resultType == MeasureType.Addstandard or resultType == MeasureType.ExtAddstandard then
            status.measure.newResult.measureChannelFour.resultMark = "ra"           --加标回收率测试
        elseif resultType == MeasureType.Sample then
            if consistency > config.interconnection.meaUpLimit  then
                status.measure.newResult.measureChannelFour.resultMark = "T"        --超仪器上限
            elseif consistency < config.interconnection.meaLowLimit then
                status.measure.newResult.measureChannelFour.resultMark = "L"        --超仪器下限
            else
                status.measure.newResult.measureChannelFour.resultMark = "N"        --正常
            end
        end
    elseif mode == ReportMode.OffLine then
        status.measure.newResult.measureChannelFour.resultMark = "B"    --仪器离线
    elseif mode == ReportMode.Maintain or mode == ReportMode.Calibrate then
        status.measure.newResult.measureChannelFour.resultMark = "M"    --维护数据
    elseif mode == ReportMode.Fault then
        status.measure.newResult.measureChannelFour.resultMark = "D"    --故障数据
    end

    if mode ~= ReportMode.OffLine then
        status.measure.report.measureChannelFour.resultType = resultType
    else
        status.measure.offline.measureChannelFour.resultType = resultType
    end

    if resultType == MeasureType.Sample then
        status.measure.schedule.autoMeasureChannelFour.dateTime = dateTime

        if mode ~= ReportMode.OffLine then
            status.measure.report.measureChannelFour.resultInfo = status.measure.newResult.measureChannelFour.resultInfo --更新数据标识
            status.measure.report.measureChannelFour.dateTime = dateTime
            status.measure.report.measureChannelFour.consistency = consistency
            status.measure.report.measureChannelFour.resultType = resultType
            status.measure.report.measureChannelFour.measureTime = os.time() - dateTime
            status.measure.report.measureChannelFour.absorbance = absorbance
            --status.measure.report.measureChannelFour.deviceTypeNum = setting.instrument.deviceTypeNum.COD
            --status.measure.report.measureChannelFour.oldTypeNum = setting.instrument.oldTypeNum.COD
            currentResultManager:OutputSample(consistency)
            currentResultManager:OutputCheck(consistency)
            if mode == ReportMode.Calibrate and status.measure.report.measureChannelFour.resultInfo ~= "D" then
                status.measure.report.measureChannelFour.resultInfo = "C" --更新数据标识
            end
        else
            status.measure.offline.measureChannelFour.resultInfo = status.measure.newResult.measureChannelFour.resultInfo --更新数据标识
            status.measure.offline.measureChannelFour.dateTime = dateTime
            status.measure.offline.measureChannelFour.consistency = consistency
            status.measure.offline.measureChannelFour.resultType = resultType
            status.measure.offline.measureChannelFour.measureTime = os.time() - dateTime
            status.measure.offline.measureChannelFour.absorbance = absorbance
            status.measure.offline.measureChannelFour.deviceTypeNum = setting.instrument.deviceTypeNum.COD
            status.measure.offline.measureChannelFour.oldTypeNum = setting.instrument.oldTypeNum.COD
        end
        --elseif resultType == MeasureType.Check then
        --    status.measure.schedule.autoAddstandard.dateTime = dateTime
    elseif resultType == MeasureType.Standard then
        status.measure.schedule.autoCheckChannelFour.dateTime = dateTime

        if mode ~= ReportMode.OffLine then
            status.measure.report.checkChannelFour.resultInfo = status.measure.newResult.measureChannelFour.resultInfo --更新数据标识
            status.measure.report.checkChannelFour.dateTime = dateTime
            status.measure.report.checkChannelFour.consistency = consistency
            status.measure.report.checkChannelFour.absorbance = absorbance
        else
            status.measure.offline.checkChannelFour.resultInfo = status.measure.newResult.measureChannelFour.resultInfo --更新数据标识
            status.measure.offline.checkChannelFour.dateTime = dateTime
            status.measure.offline.checkChannelFour.consistency = consistency
            status.measure.offline.checkChannelFour.absorbance = absorbance
        end
    elseif resultType == MeasureType.Blank then
        status.measure.schedule.autoBlankCheckChannelFour.dateTime = dateTime

        if mode ~= ReportMode.OffLine then
            status.measure.report.blankCheckChannelFour.resultInfo = status.measure.newResult.measureChannelFour.resultInfo --更新数据标识
            status.measure.report.blankCheckChannelFour.dateTime = dateTime
            status.measure.report.blankCheckChannelFour.consistency = consistency
            status.measure.report.blankCheckChannelFour.absorbance = absorbance
        else
            status.measure.offline.blankCheckChannelFour.resultInfo = status.measure.newResult.measureChannelFour.resultInfo --更新数据标识
            status.measure.offline.blankCheckChannelFour.dateTime = dateTime
            status.measure.offline.blankCheckChannelFour.consistency = consistency
            status.measure.offline.blankCheckChannelFour.absorbance = absorbance
        end
    elseif resultType == MeasureType.ZeroCheck then
        status.measure.schedule.zeroCheckChannelFour.dateTime = dateTime

        if mode ~= ReportMode.OffLine and isReporting then
            status.measure.report.zeroCheckChannelFour.resultInfo = status.measure.newResult.measureChannelFour.resultInfo --更新数据标识
            status.measure.report.zeroCheckChannelFour.dateTime = dateTime
            status.measure.report.zeroCheckChannelFour.consistency = consistency
            status.measure.report.zeroCheckChannelFour.absorbance = absorbance
        else
            status.measure.offline.zeroCheckChannelFour.resultInfo = status.measure.newResult.measureChannelFour.resultInfo --更新数据标识
            status.measure.offline.zeroCheckChannelFour.dateTime = dateTime
            status.measure.offline.zeroCheckChannelFour.consistency = consistency
            status.measure.offline.zeroCheckChannelFour.absorbance = absorbance
        end
    elseif resultType == MeasureType.RangeCheck or resultType == MeasureType.Check then
        status.measure.schedule.rangeCheckChannelFour.dateTime = dateTime

        if mode ~= ReportMode.OffLine and isReporting then
            status.measure.report.rangeCheckChannelFour.resultInfo = status.measure.newResult.measureChannelFour.resultInfo --更新数据标识
            status.measure.report.rangeCheckChannelFour.dateTime = dateTime
            status.measure.report.rangeCheckChannelFour.consistency = consistency
            status.measure.report.rangeCheckChannelFour.absorbance = absorbance
        else
            status.measure.offline.rangeCheckChannelFour.resultInfo = status.measure.newResult.measureChannelFour.resultInfo --更新数据标识
            status.measure.offline.rangeCheckChannelFour.dateTime = dateTime
            status.measure.offline.rangeCheckChannelFour.consistency = consistency
            status.measure.offline.rangeCheckChannelFour.absorbance = absorbance
        end
    elseif resultType == MeasureType.Addstandard or resultType == MeasureType.ExtAddstandard then
        status.measure.schedule.autoAddstandardChannelFour.dateTime = dateTime

        if mode ~= ReportMode.OffLine then
            status.measure.report.addstandardChannelFour.resultInfo = status.measure.newResult.measureChannelFour.resultInfo --更新数据标识
            status.measure.report.addstandardChannelFour.dateTime = dateTime
            status.measure.report.addstandardChannelFour.consistency = consistency
            status.measure.report.addstandardChannelFour.absorbance = absorbance
        else
            status.measure.offline.addstandardChannelFour.resultInfo = status.measure.newResult.measureChannelFour.resultInfo --更新数据标识
            status.measure.offline.addstandardChannelFour.dateTime = dateTime
            status.measure.offline.addstandardChannelFour.consistency = consistency
            status.measure.offline.addstandardChannelFour.absorbance = absorbance
        end
    elseif resultType == MeasureType.Parallel or resultType == MeasureType.ExtParallel then
        status.measure.schedule.autoParallelChannelFour.dateTime = dateTime

        if mode ~= ReportMode.OffLine then
            status.measure.report.parallelChannelFour.resultInfo = status.measure.newResult.measureChannelFour.resultInfo --更新数据标识
            status.measure.report.parallelChannelFour.dateTime = dateTime
            status.measure.report.parallelChannelFour.consistency = consistency
            status.measure.report.parallelChannelFour.absorbance = absorbance
        else
            status.measure.offline.parallelChannelFour.resultInfo = status.measure.newResult.measureChannelFour.resultInfo --更新数据标识
            status.measure.offline.parallelChannelFour.dateTime = dateTime
            status.measure.offline.parallelChannelFour.consistency = consistency
            status.measure.offline.parallelChannelFour.absorbance = absorbance
        end
    end

    Result.SetComplexResult(resultType, dateTime, consistency, mode, absorbance) --更新复合寄存器的结果

    if config.interconnection.alarmValue == true then
        if (consistency > 0)  and  measureResultMark == ResultMark.E and (resultType == MeasureType.Sample) then
            local alarm = MakeAlarm(setting.alarm.measureResultOutRange, "")
            AlarmManager.Instance():AddAlarm(alarm)
            if consistency > config.interconnection.meaUpLimit then
                Result.RelayOutOperate(setting.mode.relayOut.upLimit, true)
            end
        elseif consistency > config.interconnection.meaUpLimit and resultType == MeasureType.Sample then
            local alarm = MakeAlarm(setting.alarm.measureResultOutUpLimit, "")
            AlarmManager.Instance():AddAlarm(alarm)
            Result.RelayOutOperate(setting.mode.relayOut.upLimit, true)
        elseif (consistency > 0)  and  (config.interconnection.meaLowLimit - consistency > 0.001) and (resultType == MeasureType.Sample) then
            local alarm = MakeAlarm(setting.alarm.measureResultOutLowLimit, "")
            AlarmManager.Instance():AddAlarm(alarm)
            Result.RelayOutOperate(setting.mode.relayOut.lowLimit, true)
        else
            Result.RelayOutOperate(setting.mode.relayOut.upLimit, false)
            Result.RelayOutOperate(setting.mode.relayOut.lowLimit, false)
        end
    end

end

Result.OnMeasureResultAddedChannelFive = function(resultType, dateTime, consistency, mode, absorbance, isUseStart,isFault,resultMark,modbusStr,modelType)
    local currentResultManager = CurrentResultManager.Instance()

    local measureResultMark = ResultMark.N
    if nil ~= resultMark then
        measureResultMark = resultMark
    end

    local ModbusStr = ""
    if nil ~= modbusStr then
        ModbusStr = modbusStr
    end

    local isReporting = true
    if (resultType == MeasureType.ZeroCheck or resultType == MeasureType.RangeCheck) and false == config.measureParam.checkReporting then
        isReporting = false
    end

    if mode ~= ReportMode.OffLine and isReporting then
        status.measure.newResult.measureChannelFive.dateTime = dateTime
        status.measure.newResult.measureChannelFive.consistency = consistency
        status.measure.newResult.measureChannelFive.resultType = resultType
        status.measure.newResult.measureChannelFive.absorbance = absorbance
        status.measure.newResult.measureChannelFive.peakArea = absorbance
        status.measure.newResult.measureChannelFive.isUseStart = isUseStart
        status.measure.newResult.measureChannelFive.isFault = isFault
        status.measure.newResult.measureChannelFive.errorDateTime = dateTime
        status.measure.newResult.measureChannelFive.modelType = modelType
    end

    if mode == ReportMode.OnLine then
        if measureResultMark == ResultMark.T or measureResultMark == ResultMark.E then
            status.measure.newResult.measureChannelFive.resultInfo = "T"        --超仪器上限或者超量程（动态管控仅有T）
        elseif measureResultMark == ResultMark.K then
            status.measure.newResult.measureChannelFive.resultInfo = "K"
        elseif measureResultMark == ResultMark.C then
            status.measure.newResult.measureChannelFive.resultInfo = "C"
        else
            status.measure.newResult.measureChannelFive.resultInfo = "N"        --正常
        end
    elseif mode == ReportMode.OffLine then
        status.measure.newResult.measureChannelFive.resultInfo = "B"    --仪器离线
    elseif mode == ReportMode.Maintain then
        status.measure.newResult.measureChannelFive.resultInfo = "M"    --维护数据
    elseif mode == ReportMode.Calibrate then
        status.measure.newResult.measureChannelFive.resultInfo = "C"    --维护数据
    elseif mode == ReportMode.Fault then
        status.measure.newResult.measureChannelFive.resultInfo = "D"    --故障数据
    elseif mode == ReportMode.Debugging then
        status.measure.newResult.measureChannelFive.resultInfo = "A"    --调试数据
    end

    if mode == ReportMode.OnLine then
        if resultType == MeasureType.Blank then
            status.measure.newResult.measureChannelFive.resultMark = "cz"           --测零点校准液(量程校准液一校准)
        elseif resultType == MeasureType.Standard or resultType == MeasureType.Check then
            status.measure.newResult.measureChannelFive.resultMark = "cs"           --测量程校准液(量程校准液二校准)
        elseif resultType == MeasureType.ZeroCheck then
            status.measure.newResult.measureChannelFive.resultMark = "bt"           --零点核查
        elseif resultType == MeasureType.RangeCheck then
            status.measure.newResult.measureChannelFive.resultMark = "sc"           --量程核查
        elseif resultType == MeasureType.Parallel or resultType == MeasureType.ExtParallel then
            status.measure.newResult.measureChannelFive.resultMark = "ps"           --平行样测试
        elseif resultType == MeasureType.Addstandard or resultType == MeasureType.ExtAddstandard then
            status.measure.newResult.measureChannelFive.resultMark = "ra"           --加标回收率测试
        elseif resultType == MeasureType.Sample then
            if consistency > config.interconnection.meaUpLimit  then
                status.measure.newResult.measureChannelFive.resultMark = "T"        --超仪器上限
            elseif consistency < config.interconnection.meaLowLimit then
                status.measure.newResult.measureChannelFive.resultMark = "L"        --超仪器下限
            else
                status.measure.newResult.measureChannelFive.resultMark = "N"        --正常
            end
        end
    elseif mode == ReportMode.OffLine then
        status.measure.newResult.measureChannelFive.resultMark = "B"    --仪器离线
    elseif mode == ReportMode.Maintain or mode == ReportMode.Calibrate then
        status.measure.newResult.measureChannelFive.resultMark = "M"    --维护数据
    elseif mode == ReportMode.Fault then
        status.measure.newResult.measureChannelFive.resultMark = "D"    --故障数据
    end

    if mode ~= ReportMode.OffLine then
        status.measure.report.measureChannelFive.resultType = resultType
    else
        status.measure.offline.measureChannelFive.resultType = resultType
    end

    if resultType == MeasureType.Sample then
        status.measure.schedule.autoMeasureChannelFive.dateTime = dateTime

        if mode ~= ReportMode.OffLine then
            status.measure.report.measureChannelFive.resultInfo = status.measure.newResult.measureChannelFive.resultInfo --更新数据标识
            status.measure.report.measureChannelFive.dateTime = dateTime
            status.measure.report.measureChannelFive.consistency = consistency
            status.measure.report.measureChannelFive.resultType = resultType
            status.measure.report.measureChannelFive.measureTime = os.time() - dateTime
            status.measure.report.measureChannelFive.absorbance = absorbance
            --status.measure.report.measureChannelFive.deviceTypeNum = setting.instrument.deviceTypeNum.COD
            --status.measure.report.measureChannelFive.oldTypeNum = setting.instrument.oldTypeNum.COD
            currentResultManager:OutputSample(consistency)
            currentResultManager:OutputCheck(consistency)
            if mode == ReportMode.Calibrate and status.measure.report.measureChannelFive.resultInfo ~= "D" then
                status.measure.report.measureChannelFive.resultInfo = "C" --更新数据标识
            end
        else
            status.measure.offline.measureChannelFive.resultInfo = status.measure.newResult.measureChannelFive.resultInfo --更新数据标识
            status.measure.offline.measureChannelFive.dateTime = dateTime
            status.measure.offline.measureChannelFive.consistency = consistency
            status.measure.offline.measureChannelFive.resultType = resultType
            status.measure.offline.measureChannelFive.measureTime = os.time() - dateTime
            status.measure.offline.measureChannelFive.absorbance = absorbance
            status.measure.offline.measureChannelFive.deviceTypeNum = setting.instrument.deviceTypeNum.COD
            status.measure.offline.measureChannelFive.oldTypeNum = setting.instrument.oldTypeNum.COD
        end
        --elseif resultType == MeasureType.Check then
        --    status.measure.schedule.autoAddstandard.dateTime = dateTime
    elseif resultType == MeasureType.Standard then
        status.measure.schedule.autoCheckChannelFive.dateTime = dateTime

        if mode ~= ReportMode.OffLine then
            status.measure.report.checkChannelFive.resultInfo = status.measure.newResult.measureChannelFive.resultInfo --更新数据标识
            status.measure.report.checkChannelFive.dateTime = dateTime
            status.measure.report.checkChannelFive.consistency = consistency
            status.measure.report.checkChannelFive.absorbance = absorbance
        else
            status.measure.offline.checkChannelFive.resultInfo = status.measure.newResult.measureChannelFive.resultInfo --更新数据标识
            status.measure.offline.checkChannelFive.dateTime = dateTime
            status.measure.offline.checkChannelFive.consistency = consistency
            status.measure.offline.checkChannelFive.absorbance = absorbance
        end
    elseif resultType == MeasureType.Blank then
        status.measure.schedule.autoBlankCheckChannelFive.dateTime = dateTime

        if mode ~= ReportMode.OffLine then
            status.measure.report.blankCheckChannelFive.resultInfo = status.measure.newResult.measureChannelFive.resultInfo --更新数据标识
            status.measure.report.blankCheckChannelFive.dateTime = dateTime
            status.measure.report.blankCheckChannelFive.consistency = consistency
            status.measure.report.blankCheckChannelFive.absorbance = absorbance
        else
            status.measure.offline.blankCheckChannelFive.resultInfo = status.measure.newResult.measureChannelFive.resultInfo --更新数据标识
            status.measure.offline.blankCheckChannelFive.dateTime = dateTime
            status.measure.offline.blankCheckChannelFive.consistency = consistency
            status.measure.offline.blankCheckChannelFive.absorbance = absorbance
        end
    elseif resultType == MeasureType.ZeroCheck then
        status.measure.schedule.zeroCheckChannelFive.dateTime = dateTime

        if mode ~= ReportMode.OffLine and isReporting then
            status.measure.report.zeroCheckChannelFive.resultInfo = status.measure.newResult.measureChannelFive.resultInfo --更新数据标识
            status.measure.report.zeroCheckChannelFive.dateTime = dateTime
            status.measure.report.zeroCheckChannelFive.consistency = consistency
            status.measure.report.zeroCheckChannelFive.absorbance = absorbance
        else
            status.measure.offline.zeroCheckChannelFive.resultInfo = status.measure.newResult.measureChannelFive.resultInfo --更新数据标识
            status.measure.offline.zeroCheckChannelFive.dateTime = dateTime
            status.measure.offline.zeroCheckChannelFive.consistency = consistency
            status.measure.offline.zeroCheckChannelFive.absorbance = absorbance
        end
    elseif resultType == MeasureType.RangeCheck or resultType == MeasureType.Check then
        status.measure.schedule.rangeCheckChannelFive.dateTime = dateTime

        if mode ~= ReportMode.OffLine and isReporting then
            status.measure.report.rangeCheckChannelFive.resultInfo = status.measure.newResult.measureChannelFive.resultInfo --更新数据标识
            status.measure.report.rangeCheckChannelFive.dateTime = dateTime
            status.measure.report.rangeCheckChannelFive.consistency = consistency
            status.measure.report.rangeCheckChannelFive.absorbance = absorbance
        else
            status.measure.offline.rangeCheckChannelFive.resultInfo = status.measure.newResult.measureChannelFive.resultInfo --更新数据标识
            status.measure.offline.rangeCheckChannelFive.dateTime = dateTime
            status.measure.offline.rangeCheckChannelFive.consistency = consistency
            status.measure.offline.rangeCheckChannelFive.absorbance = absorbance
        end
    elseif resultType == MeasureType.Addstandard or resultType == MeasureType.ExtAddstandard then
        status.measure.schedule.autoAddstandardChannelFive.dateTime = dateTime

        if mode ~= ReportMode.OffLine then
            status.measure.report.addstandardChannelFive.resultInfo = status.measure.newResult.measureChannelFive.resultInfo --更新数据标识
            status.measure.report.addstandardChannelFive.dateTime = dateTime
            status.measure.report.addstandardChannelFive.consistency = consistency
            status.measure.report.addstandardChannelFive.absorbance = absorbance
        else
            status.measure.offline.addstandardChannelFive.resultInfo = status.measure.newResult.measureChannelFive.resultInfo --更新数据标识
            status.measure.offline.addstandardChannelFive.dateTime = dateTime
            status.measure.offline.addstandardChannelFive.consistency = consistency
            status.measure.offline.addstandardChannelFive.absorbance = absorbance
        end
    elseif resultType == MeasureType.Parallel or resultType == MeasureType.ExtParallel then
        status.measure.schedule.autoParallelChannelFive.dateTime = dateTime

        if mode ~= ReportMode.OffLine then
            status.measure.report.parallelChannelFive.resultInfo = status.measure.newResult.measureChannelFive.resultInfo --更新数据标识
            status.measure.report.parallelChannelFive.dateTime = dateTime
            status.measure.report.parallelChannelFive.consistency = consistency
            status.measure.report.parallelChannelFive.absorbance = absorbance
        else
            status.measure.offline.parallelChannelFive.resultInfo = status.measure.newResult.measureChannelFive.resultInfo --更新数据标识
            status.measure.offline.parallelChannelFive.dateTime = dateTime
            status.measure.offline.parallelChannelFive.consistency = consistency
            status.measure.offline.parallelChannelFive.absorbance = absorbance
        end
    end

    Result.SetComplexResult(resultType, dateTime, consistency, mode, absorbance) --更新复合寄存器的结果

    if config.interconnection.alarmValue == true then
        if (consistency > 0)  and  measureResultMark == ResultMark.E and (resultType == MeasureType.Sample) then
            local alarm = MakeAlarm(setting.alarm.measureResultOutRange, "")
            AlarmManager.Instance():AddAlarm(alarm)
            if consistency > config.interconnection.meaUpLimit then
                Result.RelayOutOperate(setting.mode.relayOut.upLimit, true)
            end
        elseif consistency > config.interconnection.meaUpLimit and resultType == MeasureType.Sample then
            local alarm = MakeAlarm(setting.alarm.measureResultOutUpLimit, "")
            AlarmManager.Instance():AddAlarm(alarm)
            Result.RelayOutOperate(setting.mode.relayOut.upLimit, true)
        elseif (consistency > 0)  and  (config.interconnection.meaLowLimit - consistency > 0.001) and (resultType == MeasureType.Sample) then
            local alarm = MakeAlarm(setting.alarm.measureResultOutLowLimit, "")
            AlarmManager.Instance():AddAlarm(alarm)
            Result.RelayOutOperate(setting.mode.relayOut.lowLimit, true)
        else
            Result.RelayOutOperate(setting.mode.relayOut.upLimit, false)
            Result.RelayOutOperate(setting.mode.relayOut.lowLimit, false)
        end
    end

end

Result.OnMeasureResultAddedChannelSix = function(resultType, dateTime, consistency, mode, absorbance, isUseStart,isFault,resultMark,modbusStr,modelType)
    local currentResultManager = CurrentResultManager.Instance()

    local measureResultMark = ResultMark.N
    if nil ~= resultMark then
        measureResultMark = resultMark
    end

    local ModbusStr = ""
    if nil ~= modbusStr then
        ModbusStr = modbusStr
    end

    local isReporting = true
    if (resultType == MeasureType.ZeroCheck or resultType == MeasureType.RangeCheck) and false == config.measureParam.checkReporting then
        isReporting = false
    end

    if mode ~= ReportMode.OffLine and isReporting then
        status.measure.newResult.measureChannelSix.dateTime = dateTime
        status.measure.newResult.measureChannelSix.consistency = consistency
        status.measure.newResult.measureChannelSix.resultType = resultType
        status.measure.newResult.measureChannelSix.absorbance = absorbance
        status.measure.newResult.measureChannelSix.peakArea = absorbance
        status.measure.newResult.measureChannelSix.isUseStart = isUseStart
        status.measure.newResult.measureChannelSix.isFault = isFault
        status.measure.newResult.measureChannelSix.errorDateTime = dateTime
        status.measure.newResult.measureChannelSix.modelType = modelType
    end

    if mode == ReportMode.OnLine then
        if measureResultMark == ResultMark.T or measureResultMark == ResultMark.E then
            status.measure.newResult.measureChannelSix.resultInfo = "T"        --超仪器上限或者超量程（动态管控仅有T）
        elseif measureResultMark == ResultMark.K then
            status.measure.newResult.measureChannelSix.resultInfo = "K"
        elseif measureResultMark == ResultMark.C then
            status.measure.newResult.measureChannelSix.resultInfo = "C"
        else
            status.measure.newResult.measureChannelSix.resultInfo = "N"        --正常
        end
    elseif mode == ReportMode.OffLine then
        status.measure.newResult.measureChannelSix.resultInfo = "B"    --仪器离线
    elseif mode == ReportMode.Maintain then
        status.measure.newResult.measureChannelSix.resultInfo = "M"    --维护数据
    elseif mode == ReportMode.Calibrate then
        status.measure.newResult.measureChannelSix.resultInfo = "C"    --维护数据
    elseif mode == ReportMode.Fault then
        status.measure.newResult.measureChannelSix.resultInfo = "D"    --故障数据
    elseif mode == ReportMode.Debugging then
        status.measure.newResult.measureChannelSix.resultInfo = "A"    --调试数据
    end

    if mode == ReportMode.OnLine then
        if resultType == MeasureType.Blank then
            status.measure.newResult.measureChannelSix.resultMark = "cz"           --测零点校准液(量程校准液一校准)
        elseif resultType == MeasureType.Standard or resultType == MeasureType.Check then
            status.measure.newResult.measureChannelSix.resultMark = "cs"           --测量程校准液(量程校准液二校准)
        elseif resultType == MeasureType.ZeroCheck then
            status.measure.newResult.measureChannelSix.resultMark = "bt"           --零点核查
        elseif resultType == MeasureType.RangeCheck then
            status.measure.newResult.measureChannelSix.resultMark = "sc"           --量程核查
        elseif resultType == MeasureType.Parallel or resultType == MeasureType.ExtParallel then
            status.measure.newResult.measureChannelSix.resultMark = "ps"           --平行样测试
        elseif resultType == MeasureType.Addstandard or resultType == MeasureType.ExtAddstandard then
            status.measure.newResult.measureChannelSix.resultMark = "ra"           --加标回收率测试
        elseif resultType == MeasureType.Sample then
            if consistency > config.interconnection.meaUpLimit  then
                status.measure.newResult.measureChannelSix.resultMark = "T"        --超仪器上限
            elseif consistency < config.interconnection.meaLowLimit then
                status.measure.newResult.measureChannelSix.resultMark = "L"        --超仪器下限
            else
                status.measure.newResult.measureChannelSix.resultMark = "N"        --正常
            end
        end
    elseif mode == ReportMode.OffLine then
        status.measure.newResult.measureChannelSix.resultMark = "B"    --仪器离线
    elseif mode == ReportMode.Maintain or mode == ReportMode.Calibrate then
        status.measure.newResult.measureChannelSix.resultMark = "M"    --维护数据
    elseif mode == ReportMode.Fault then
        status.measure.newResult.measureChannelSix.resultMark = "D"    --故障数据
    end

    if mode ~= ReportMode.OffLine then
        status.measure.report.measureChannelSix.resultType = resultType
    else
        status.measure.offline.measureChannelSix.resultType = resultType
    end

    if resultType == MeasureType.Sample then
        status.measure.schedule.autoMeasureChannelSix.dateTime = dateTime

        if mode ~= ReportMode.OffLine then
            status.measure.report.measureChannelSix.resultInfo = status.measure.newResult.measureChannelSix.resultInfo --更新数据标识
            status.measure.report.measureChannelSix.dateTime = dateTime
            status.measure.report.measureChannelSix.consistency = consistency
            status.measure.report.measureChannelSix.resultType = resultType
            status.measure.report.measureChannelSix.measureTime = os.time() - dateTime
            status.measure.report.measureChannelSix.absorbance = absorbance
            --status.measure.report.measureChannelSix.deviceTypeNum = setting.instrument.deviceTypeNum.COD
            --status.measure.report.measureChannelSix.oldTypeNum = setting.instrument.oldTypeNum.COD
            currentResultManager:OutputSample(consistency)
            currentResultManager:OutputCheck(consistency)
            if mode == ReportMode.Calibrate and status.measure.report.measureChannelSix.resultInfo ~= "D" then
                status.measure.report.measureChannelSix.resultInfo = "C" --更新数据标识
            end
        else
            status.measure.offline.measureChannelSix.resultInfo = status.measure.newResult.measureChannelSix.resultInfo --更新数据标识
            status.measure.offline.measureChannelSix.dateTime = dateTime
            status.measure.offline.measureChannelSix.consistency = consistency
            status.measure.offline.measureChannelSix.resultType = resultType
            status.measure.offline.measureChannelSix.measureTime = os.time() - dateTime
            status.measure.offline.measureChannelSix.absorbance = absorbance
            status.measure.offline.measureChannelSix.deviceTypeNum = setting.instrument.deviceTypeNum.COD
            status.measure.offline.measureChannelSix.oldTypeNum = setting.instrument.oldTypeNum.COD
        end
        --elseif resultType == MeasureType.Check then
        --    status.measure.schedule.autoAddstandard.dateTime = dateTime
    elseif resultType == MeasureType.Standard then
        status.measure.schedule.autoCheckChannelSix.dateTime = dateTime

        if mode ~= ReportMode.OffLine then
            status.measure.report.checkChannelSix.resultInfo = status.measure.newResult.measureChannelSix.resultInfo --更新数据标识
            status.measure.report.checkChannelSix.dateTime = dateTime
            status.measure.report.checkChannelSix.consistency = consistency
            status.measure.report.checkChannelSix.absorbance = absorbance
        else
            status.measure.offline.checkChannelSix.resultInfo = status.measure.newResult.measureChannelSix.resultInfo --更新数据标识
            status.measure.offline.checkChannelSix.dateTime = dateTime
            status.measure.offline.checkChannelSix.consistency = consistency
            status.measure.offline.checkChannelSix.absorbance = absorbance
        end
    elseif resultType == MeasureType.Blank then
        status.measure.schedule.autoBlankCheckChannelSix.dateTime = dateTime

        if mode ~= ReportMode.OffLine then
            status.measure.report.blankCheckChannelSix.resultInfo = status.measure.newResult.measureChannelSix.resultInfo --更新数据标识
            status.measure.report.blankCheckChannelSix.dateTime = dateTime
            status.measure.report.blankCheckChannelSix.consistency = consistency
            status.measure.report.blankCheckChannelSix.absorbance = absorbance
        else
            status.measure.offline.blankCheckChannelSix.resultInfo = status.measure.newResult.measureChannelSix.resultInfo --更新数据标识
            status.measure.offline.blankCheckChannelSix.dateTime = dateTime
            status.measure.offline.blankCheckChannelSix.consistency = consistency
            status.measure.offline.blankCheckChannelSix.absorbance = absorbance
        end
    elseif resultType == MeasureType.ZeroCheck then
        status.measure.schedule.zeroCheckChannelSix.dateTime = dateTime

        if mode ~= ReportMode.OffLine and isReporting then
            status.measure.report.zeroCheckChannelSix.resultInfo = status.measure.newResult.measureChannelSix.resultInfo --更新数据标识
            status.measure.report.zeroCheckChannelSix.dateTime = dateTime
            status.measure.report.zeroCheckChannelSix.consistency = consistency
            status.measure.report.zeroCheckChannelSix.absorbance = absorbance
        else
            status.measure.offline.zeroCheckChannelSix.resultInfo = status.measure.newResult.measureChannelSix.resultInfo --更新数据标识
            status.measure.offline.zeroCheckChannelSix.dateTime = dateTime
            status.measure.offline.zeroCheckChannelSix.consistency = consistency
            status.measure.offline.zeroCheckChannelSix.absorbance = absorbance
        end
    elseif resultType == MeasureType.RangeCheck or resultType == MeasureType.Check then
        status.measure.schedule.rangeCheckChannelSix.dateTime = dateTime

        if mode ~= ReportMode.OffLine and isReporting then
            status.measure.report.rangeCheckChannelSix.resultInfo = status.measure.newResult.measureChannelSix.resultInfo --更新数据标识
            status.measure.report.rangeCheckChannelSix.dateTime = dateTime
            status.measure.report.rangeCheckChannelSix.consistency = consistency
            status.measure.report.rangeCheckChannelSix.absorbance = absorbance
        else
            status.measure.offline.rangeCheckChannelSix.resultInfo = status.measure.newResult.measureChannelSix.resultInfo --更新数据标识
            status.measure.offline.rangeCheckChannelSix.dateTime = dateTime
            status.measure.offline.rangeCheckChannelSix.consistency = consistency
            status.measure.offline.rangeCheckChannelSix.absorbance = absorbance
        end
    elseif resultType == MeasureType.Addstandard or resultType == MeasureType.ExtAddstandard then
        status.measure.schedule.autoAddstandardChannelSix.dateTime = dateTime

        if mode ~= ReportMode.OffLine then
            status.measure.report.addstandardChannelSix.resultInfo = status.measure.newResult.measureChannelSix.resultInfo --更新数据标识
            status.measure.report.addstandardChannelSix.dateTime = dateTime
            status.measure.report.addstandardChannelSix.consistency = consistency
            status.measure.report.addstandardChannelSix.absorbance = absorbance
        else
            status.measure.offline.addstandardChannelSix.resultInfo = status.measure.newResult.measureChannelSix.resultInfo --更新数据标识
            status.measure.offline.addstandardChannelSix.dateTime = dateTime
            status.measure.offline.addstandardChannelSix.consistency = consistency
            status.measure.offline.addstandardChannelSix.absorbance = absorbance
        end
    elseif resultType == MeasureType.Parallel or resultType == MeasureType.ExtParallel then
        status.measure.schedule.autoParallelChannelSix.dateTime = dateTime

        if mode ~= ReportMode.OffLine then
            status.measure.report.parallelChannelSix.resultInfo = status.measure.newResult.measureChannelSix.resultInfo --更新数据标识
            status.measure.report.parallelChannelSix.dateTime = dateTime
            status.measure.report.parallelChannelSix.consistency = consistency
            status.measure.report.parallelChannelSix.absorbance = absorbance
        else
            status.measure.offline.parallelChannelSix.resultInfo = status.measure.newResult.measureChannelSix.resultInfo --更新数据标识
            status.measure.offline.parallelChannelSix.dateTime = dateTime
            status.measure.offline.parallelChannelSix.consistency = consistency
            status.measure.offline.parallelChannelSix.absorbance = absorbance
        end
    end

    Result.SetComplexResult(resultType, dateTime, consistency, mode, absorbance) --更新复合寄存器的结果

    if config.interconnection.alarmValue == true then
        if (consistency > 0)  and  measureResultMark == ResultMark.E and (resultType == MeasureType.Sample) then
            local alarm = MakeAlarm(setting.alarm.measureResultOutRange, "")
            AlarmManager.Instance():AddAlarm(alarm)
            if consistency > config.interconnection.meaUpLimit then
                Result.RelayOutOperate(setting.mode.relayOut.upLimit, true)
            end
        elseif consistency > config.interconnection.meaUpLimit and resultType == MeasureType.Sample then
            local alarm = MakeAlarm(setting.alarm.measureResultOutUpLimit, "")
            AlarmManager.Instance():AddAlarm(alarm)
            Result.RelayOutOperate(setting.mode.relayOut.upLimit, true)
        elseif (consistency > 0)  and  (config.interconnection.meaLowLimit - consistency > 0.001) and (resultType == MeasureType.Sample) then
            local alarm = MakeAlarm(setting.alarm.measureResultOutLowLimit, "")
            AlarmManager.Instance():AddAlarm(alarm)
            Result.RelayOutOperate(setting.mode.relayOut.lowLimit, true)
        else
            Result.RelayOutOperate(setting.mode.relayOut.upLimit, false)
            Result.RelayOutOperate(setting.mode.relayOut.lowLimit, false)
        end
    end

end

Result.OnCommonMeasureResultAdded = function(name, resultType, dateTime, consistency, mode)
    Result.OnMeasureResultAdded(resultType, dateTime, consistency, mode, 0)
end

Result.OnSaveCalibrateConsistencyAdded = function(zeroConsistency, standardConsistency, zeroCheckError, standardCheckError,currentRange)
    if zeroConsistency ~= nil then
        status.measure.calibrate[currentRange].zeroCalculateConsistency = zeroConsistency
        status.measure.calibrate[currentRange].zeroCheckError = zeroCheckError
        status.measure.newResult.calibrate.zeroCalculateConsistency = zeroConsistency
        status.measure.newResult.calibrate.zeroCheckError = zeroCheckError
    end
    if standardConsistency ~= nil then
        status.measure.calibrate[currentRange].standardCalculateConsistency = standardConsistency
        status.measure.calibrate[currentRange].standardCheckError = standardCheckError
        status.measure.newResult.calibrate.standardCalculateConsistency = standardConsistency
        status.measure.newResult.calibrate.standardCheckError = standardCheckError
    end
end

Result.OnCalibrateResultAdded = function(dateTime, zeroDateTime, standardDateTime,curveK, curveB, point0Consistency, point1Consistency, point0Absorbance, point1Absorbance, currentRange, userSettings, modelType)

    if userSettings == false then
        if modelType == nil or modelType == ModelType.TC then
            config.measureParam.curveParam[currentRange].curveK = curveK
            config.measureParam.curveParam[currentRange].curveB = curveB
        elseif modelType == ModelType.IC then
            config.measureParam.curveParam[currentRange].curveKIC = curveK
            config.measureParam.curveParam[currentRange].curveBIC = curveB
        elseif modelType == ModelType.NPOC then
            config.measureParam.curveParam[currentRange].curveKNPOC = curveK
            config.measureParam.curveParam[currentRange].curveBNPOC = curveB
        end
        config.modifyRecord.measureParam(true)
    end
    if modelType == nil or modelType == ModelType.TC then
        status.measure.schedule.autoCalibrate.dateTime = dateTime
        status.measure.newResult.calibrate.dateTime = dateTime
        status.measure.newResult.calibrate.zeroCalibrateDateTime = zeroDateTime
        status.measure.newResult.calibrate.standardCalibrateDateTime = standardDateTime
        status.measure.newResult.calibrate.curveK = curveK
        status.measure.newResult.calibrate.curveB = curveB
        status.measure.newResult.calibrate.point0Consistency = point0Consistency
        status.measure.newResult.calibrate.point1Consistency = point1Consistency
        status.measure.newResult.calibrate.point0Absorbance = point0Absorbance
        status.measure.newResult.calibrate.point1Absorbance = point1Absorbance

        if status.measure.calibrate[currentRange].dateTime ~= nil then
            status.measure.calibrate[currentRange].dateTime = dateTime
            status.measure.calibrate[currentRange].zeroCalibrateDateTime = zeroDateTime
            status.measure.calibrate[currentRange].standardCalibrateDateTime = standardDateTime
            status.measure.calibrate[currentRange].curveK = curveK
            status.measure.calibrate[currentRange].curveB = curveB
            status.measure.calibrate[currentRange].point0Consistency = point0Consistency
            status.measure.calibrate[currentRange].point1Consistency = point1Consistency
            status.measure.calibrate[currentRange].point0Absorbance = point0Absorbance
            status.measure.calibrate[currentRange].point1Absorbance = point1Absorbance
            status.measure.calibrate[currentRange].userSettings = userSettings
        end
    elseif modelType == ModelType.IC then
        status.measure.schedule.autoCalibrate.dateTime = dateTime
        status.measure.newResult.calibrateIC.dateTime = dateTime
        status.measure.newResult.calibrateIC.zeroCalibrateDateTime = zeroDateTime
        status.measure.newResult.calibrateIC.standardCalibrateDateTime = standardDateTime
        status.measure.newResult.calibrateIC.curveK = curveK
        status.measure.newResult.calibrateIC.curveB = curveB
        status.measure.newResult.calibrateIC.point0Consistency = point0Consistency
        status.measure.newResult.calibrateIC.point1Consistency = point1Consistency
        status.measure.newResult.calibrateIC.point0Absorbance = point0Absorbance
        status.measure.newResult.calibrateIC.point1Absorbance = point1Absorbance

        if status.measure.calibrate[currentRange].dateTime ~= nil then
            status.measure.calibrate[currentRange].curveKIC = curveK
            status.measure.calibrate[currentRange].curveBIC = curveB
        end
    elseif modelType == ModelType.NPOC then
        status.measure.schedule.autoCalibrate.dateTime = dateTime
        status.measure.newResult.calibrateNPOC.dateTime = dateTime
        status.measure.newResult.calibrateNPOC.zeroCalibrateDateTime = zeroDateTime
        status.measure.newResult.calibrateNPOC.standardCalibrateDateTime = standardDateTime
        status.measure.newResult.calibrateNPOC.curveK = curveK
        status.measure.newResult.calibrateNPOC.curveB = curveB
        status.measure.newResult.calibrateNPOC.point0Consistency = point0Consistency
        status.measure.newResult.calibrateNPOC.point1Consistency = point1Consistency
        status.measure.newResult.calibrateNPOC.point0Absorbance = point0Absorbance
        status.measure.newResult.calibrateNPOC.point1Absorbance = point1Absorbance

        if status.measure.calibrate[currentRange].dateTime ~= nil then
            status.measure.calibrate[currentRange].curveKNPOC = curveK
            status.measure.calibrate[currentRange].curveBNPOC = curveB
        end
    end
end

Result.RelayOutOperate = function(operate,  status)
    local relayOne = config.interconnection.relayOne
    local relayTwo = config.interconnection.relayTwo
    local relayControl = RelayControl.Instance()

    if  operate == setting.mode.relayOut.lowLimit then
        if relayOne == setting.mode.relayOut.lowLimit then
            if status == true then
                relayControl:TurnOn(2)
            else
                relayControl:TurnOff(2)
            end
        end

        if relayTwo == setting.mode.relayOut.lowLimit then
            if status == true then
                relayControl:TurnOn(3)
            else
                relayControl:TurnOff(3)
            end
        end
    elseif operate == setting.mode.relayOut.upLimit then
        if relayOne == setting.mode.relayOut.upLimit then
            if status == true then
                relayControl:TurnOn(2)
            else
                relayControl:TurnOff(2)
            end
        end

        if relayTwo == setting.mode.relayOut.upLimit then
            if status == true then
                relayControl:TurnOn(3)
            else
                relayControl:TurnOff(3)
            end
        end
    elseif operate == setting.mode.relayOut.measureInstruct then
        if relayOne == setting.mode.relayOut.measureInstruct then
            if status == true then
                relayControl:TurnOn(2)
            else
                relayControl:TurnOff(2)
            end
        end

        if relayTwo == setting.mode.relayOut.measureInstruct then
            if status == true then
                relayControl:TurnOn(3)
            else
                relayControl:TurnOff(3)
            end
        end
    elseif operate == setting.mode.relayOut.calibrateInstruct then
        if relayOne == setting.mode.relayOut.calibrateInstruct then
            if status == true then
                relayControl:TurnOn(2)
            else
                relayControl:TurnOff(2)
            end
        end

        if relayTwo == setting.mode.relayOut.calibrateInstruct then
            if status == true then
                relayControl:TurnOn(3)
            else
                relayControl:TurnOff(3)
            end
        end
    elseif operate == setting.mode.relayOut.cleanInstruct then
        if relayOne == setting.mode.relayOut.cleanInstruct then
            if status == true then
                relayControl:TurnOn(2)
            else
                relayControl:TurnOff(2)
            end
        end

        if relayTwo == setting.mode.relayOut.cleanInstruct then
            if status == true then
                relayControl:TurnOn(3)
            else
                relayControl:TurnOff(3)
            end
        end

    elseif operate == setting.mode.relayOut.collectInstruct then
        if relayOne == setting.mode.relayOut.collectInstruct then
            if status == true then
                relayControl:TurnOn(2)
            else
                relayControl:TurnOff(2)
            end
        end

        if relayTwo == setting.mode.relayOut.collectInstruct then
            if status == true then
                relayControl:TurnOn(3)
            else
                relayControl:TurnOff(3)
            end
        end

    elseif operate == setting.mode.relayOut.checkInstruct then
        if relayOne == setting.mode.relayOut.checkInstruct then
            if status == true then
                relayControl:TurnOn(2)
            else
                relayControl:TurnOff(2)
            end
        end

        if relayTwo == setting.mode.relayOut.checkInstruct then
            if status == true then
                relayControl:TurnOn(3)
            else
                relayControl:TurnOff(3)
            end
        end
    end
end

return Helper
