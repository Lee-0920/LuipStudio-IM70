setting.ui.operation.liquidOperator =
{
    name ="liquidOperator",
    text= "管道操作",
    rowCount = 36,
    superRow = 0,
    administratorRow = 0,
    writePrivilege=  RoleType.Maintain,
    readPrivilege = RoleType.Maintain,
    -- row = 1
    {
        name = "SuckFromSample",
        text= "填充通道一",
        data = 10,
        createFlow= function(mode, volume)
            local flow = LiquidOperateFlow:new({}, setting.liquidType.exSampleOut1, RollDirection.Suck, mode, volume, setting.runAction.suckFromSample1)
            flow.name = setting.ui.operation.liquidOperator[1].name
            FlowList.AddFlow(flow)
        end,
        checkValue = function(value)
            if setting.ui.operation.liquidOperator.pumpVolumePattern(value) == true then
                local num = tonumber(value)
                if num < 0 or num > 50 then
                    return "10"
                else
                    return value
                end
            else
                return "10"
            end
        end,
        writePrivilege=  RoleType.Maintain,
        readPrivilege = RoleType.Maintain,
        targetPrivilege = Target.ChannelOne,
    },
    -- row = 2
    {
        name = "SuckFromSample",
        text= "填充通道二",
        data = 10,
        createFlow= function(mode, volume)
            local flow = LiquidOperateFlow:new({}, setting.liquidType.exSampleOut2, RollDirection.Suck, mode, volume, setting.runAction.suckFromSample2)
            flow.name = setting.ui.operation.liquidOperator[2].name
            FlowList.AddFlow(flow)
        end,
        checkValue = function(value)
            if setting.ui.operation.liquidOperator.pumpVolumePattern(value) == true then
                local num = tonumber(value)
                if num < 0 or num > 50 then
                    return "10"
                else
                    return value
                end
            else
                return "10"
            end
        end,
        writePrivilege=  RoleType.Maintain,
        readPrivilege = RoleType.Maintain,
        targetPrivilege = Target.ChannelTwo,
    },
    -- row = 3
    {
        name = "SuckFromSample",
        text= "填充通道三",
        data = 10,
        createFlow= function(mode, volume)
            local flow = LiquidOperateFlow:new({}, setting.liquidType.exSampleOut3, RollDirection.Suck, mode, volume, setting.runAction.suckFromSample3)
            flow.name = setting.ui.operation.liquidOperator[3].name
            FlowList.AddFlow(flow)
        end,
        checkValue = function(value)
            if setting.ui.operation.liquidOperator.pumpVolumePattern(value) == true then
                local num = tonumber(value)
                if num < 0 or num > 50 then
                    return "10"
                else
                    return value
                end
            else
                return "10"
            end
        end,
        writePrivilege=  RoleType.Maintain,
        readPrivilege = RoleType.Maintain,
        targetPrivilege = Target.ChannelThree,
    },
    -- row = 4
    {
        name = "SuckFromSample",
        text= "填充通道四",
        data = 10,
        createFlow= function(mode, volume)
            local flow = LiquidOperateFlow:new({}, setting.liquidType.exSampleOut4, RollDirection.Suck, mode, volume, setting.runAction.suckFromSample4)
            flow.name = setting.ui.operation.liquidOperator[4].name
            FlowList.AddFlow(flow)
        end,
        checkValue = function(value)
            if setting.ui.operation.liquidOperator.pumpVolumePattern(value) == true then
                local num = tonumber(value)
                if num < 0 or num > 50 then
                    return "10"
                else
                    return value
                end
            else
                return "10"
            end
        end,
        writePrivilege=  RoleType.Maintain,
        readPrivilege = RoleType.Maintain,
        targetPrivilege = Target.ChannelFour,
    },
    -- row = 5
    {
        name = "SuckFromSample",
        text= "填充通道五",
        data = 10,
        createFlow= function(mode, volume)
            local flow = LiquidOperateFlow:new({}, setting.liquidType.exSampleOut5, RollDirection.Suck, mode, volume, setting.runAction.suckFromSample5)
            flow.name = setting.ui.operation.liquidOperator[5].name
            FlowList.AddFlow(flow)
        end,
        checkValue = function(value)
            if setting.ui.operation.liquidOperator.pumpVolumePattern(value) == true then
                local num = tonumber(value)
                if num < 0 or num > 50 then
                    return "10"
                else
                    return value
                end
            else
                return "10"
            end
        end,
        writePrivilege=  RoleType.Maintain,
        readPrivilege = RoleType.Maintain,
        targetPrivilege = Target.ChannelFive,
    },
    -- row = 6
    {
        name = "SuckFromSample",
        text= "填充通道六",
        data = 10,
        createFlow= function(mode, volume)
            local flow = LiquidOperateFlow:new({}, setting.liquidType.exSampleOut6, RollDirection.Suck, mode, volume, setting.runAction.suckFromSample6)
            flow.name = setting.ui.operation.liquidOperator[6].name
            FlowList.AddFlow(flow)
        end,
        checkValue = function(value)
            if setting.ui.operation.liquidOperator.pumpVolumePattern(value) == true then
                local num = tonumber(value)
                if num < 0 or num > 50 then
                    return "10"
                else
                    return value
                end
            else
                return "10"
            end
        end,
        writePrivilege=  RoleType.Maintain,
        readPrivilege = RoleType.Maintain,
        targetPrivilege = Target.ChannelSix,
    },
    ---- row = 7
    --{
    --    name = "SuckFromBlank",
    --    text= "填充零点校准液",
    --    data = 10,
    --    createFlow= function(mode, volume)
    --        local flow = LiquidOperateFlow:new({}, setting.liquidType.blank, RollDirection.Suck, mode, volume, setting.runAction.suckFromBlank)
    --        flow.name = setting.ui.operation.liquidOperator[2].name
    --        FlowList.AddFlow(flow)
    --    end,
    --    checkValue = function(value)
    --        if setting.ui.operation.liquidOperator.pumpVolumePattern(value) == true then
    --            local num = tonumber(value)
    --            if num < 0 or num > 50 then
    --                return "10"
    --            else
    --                return value
    --            end
    --        else
    --            return "10"
    --        end
    --    end,
    --    writePrivilege=  RoleType.Maintain,
    --    readPrivilege = RoleType.Maintain,
    --},
    -- row = 7
    {
        name = "SuckFromReagent1",
        text= "填充试剂一至水样杯",
        data = 10,
        createFlow= function(mode, volume)
            local flow = LiquidOperateFlow:new({}, setting.liquidType.reagent1ToMixer, RollDirection.Suck, mode, volume, setting.runAction.suckFromReagent1ToMixer)
            flow.name = setting.ui.operation.liquidOperator[7].name
            FlowList.AddFlow(flow)
        end,
        checkValue = function(value)
            if setting.ui.operation.liquidOperator.pumpVolumePattern(value) == true then
                local num = tonumber(value)
                if num < 0 or num > 50 then
                    return "10"
                else
                    return value
                end
            else
                return "10"
            end
        end,
        writePrivilege=  RoleType.Maintain,
        readPrivilege = RoleType.Maintain,
    },
    -- row = 8
    {
        name = "SuckFromReagent1",
        text= "填充试剂一至曝气池",
        data = 10,
        createFlow= function(mode, volume)
            local flow = LiquidOperateFlow:new({}, setting.liquidType.reagent1ToExposure, RollDirection.Suck, mode, volume, setting.runAction.suckFromReagent1ToExposure)
            flow.name = setting.ui.operation.liquidOperator[8].name
            FlowList.AddFlow(flow)
        end,
        checkValue = function(value)
            if setting.ui.operation.liquidOperator.pumpVolumePattern(value) == true then
                local num = tonumber(value)
                if num < 0 or num > 50 then
                    return "10"
                else
                    return value
                end
            else
                return "10"
            end
        end,
        writePrivilege=  RoleType.Maintain,
        readPrivilege = RoleType.Maintain,
    },
    -- row = 9
    {
        name = "DrainToWasteSample",
        text= "排空水样杯",
        data = 10,
        createFlow= function(mode, volume)
            local flow = LiquidOperateFlow:new({}, setting.liquidType.wasteSample, RollDirection.Drain, 0, volume, setting.runAction.drainToWasteSample)
            flow.name = setting.ui.operation.liquidOperator[9].name
            FlowList.AddFlow(flow)
        end,
        checkValue = function(value)
            if setting.ui.operation.liquidOperator.pumpVolumePattern(value) == true then
                local num = tonumber(value)
                if num < 0 or num > 50 then
                    return "10"
                else
                    return value
                end
            else
                return "10"
            end
        end,
        writePrivilege=  RoleType.Maintain,
        readPrivilege = RoleType.Maintain,
    },
    -- row = 10
    {
        name = "DrainToWasteExposure",
        text= "排空曝气池",
        data = 10,
        createFlow= function(mode, volume)
            local flow = LiquidOperateFlow:new({}, setting.liquidType.wasteExposure, RollDirection.Drain, 0, volume, setting.runAction.drainToWasteExposure)
            flow.name = setting.ui.operation.liquidOperator[10].name
            FlowList.AddFlow(flow)
        end,
        checkValue = function(value)
            if setting.ui.operation.liquidOperator.pumpVolumePattern(value) == true then
                local num = tonumber(value)
                if num < 0 or num > 50 then
                    return "10"
                else
                    return value
                end
            else
                return "10"
            end
        end,
        writePrivilege=  RoleType.Maintain,
        readPrivilege = RoleType.Maintain,
    },
    -- row = 11
    {
        name = "drainToWasteDilute",
        text= "排空稀释杯",
        data = 10,
        createFlow= function(mode, volume)
            local flow = LiquidOperateFlow:new({}, setting.liquidType.wasteDilute, RollDirection.Drain, 0, volume, setting.runAction.drainToWasteDilute)
            flow.name = setting.ui.operation.liquidOperator[11].name
            FlowList.AddFlow(flow)
        end,
        checkValue = function(value)
            if setting.ui.operation.liquidOperator.pumpVolumePattern(value) == true then
                local num = tonumber(value)
                if num < 0 or num > 50 then
                    return "10"
                else
                    return value
                end
            else
                return "10"
            end
        end,
        writePrivilege=  RoleType.Maintain,
        readPrivilege = RoleType.Maintain,
    },
    -- row = 12
    {
        name = "SyringeAspiration",
        text= "注射器吸",
        data = 2.5,
        createFlow= function(mode, volume)
            local flow = LiquidOperateFlow:new({}, setting.liquidType.airReagent, RollDirection.Suck, 0, volume, setting.runAction.aspirationAirReagent)
            flow.name = setting.ui.operation.liquidOperator[12].name
            FlowList.AddFlow(flow)
        end,
        checkValue = function(value)
            if setting.ui.operation.liquidOperator.syrVolumePattern(value) == true then
                local num = tonumber(value)
                if num < 0 or num > 2.5 then
                    return "2.5"
                else
                    return value
                end
            else
                return "2.5"
            end
        end,
        writePrivilege=  RoleType.Maintain,
        readPrivilege = RoleType.Maintain,
    },
    -- row = 13
    {
        name = "SyringeDischarge",
        text= "注射器排",
        data = 2.5,
        createFlow= function(mode, volume)
            local flow = LiquidOperateFlow:new({}, setting.liquidType.airReagent, RollDirection.Drain, 0, volume, setting.runAction.dischargeAirReagent)
            flow.name = setting.ui.operation.liquidOperator[13].name
            FlowList.AddFlow(flow)
        end,
        checkValue = function(value)
            if setting.ui.operation.liquidOperator.syrVolumePattern(value) == true then
                local num = tonumber(value)
                if num < 0 or num > 2.5 then
                    return "2.5"
                else
                    return value
                end
            else
                return "2.5"
            end
        end,
        writePrivilege=  RoleType.Maintain,
        readPrivilege = RoleType.Maintain,
    },
    -- row = 14
    {
        name = "SyringeSuckSampleMixer",
        text= "注射器抽水样杯溶液",
        data = 2.5,
        createFlow= function(mode, volume)
            local flow = LiquidOperateFlow:new({}, setting.liquidType.airReagent, RollDirection.Suck, setting.component.xPos.sampleMixer, volume, setting.runAction.syringeSuckSampleMixer)
            flow.name = setting.ui.operation.liquidOperator[14].name
            FlowList.AddFlow(flow)
        end,
        checkValue = function(mode, value)
            if setting.ui.operation.liquidOperator.syrVolumePattern(mode, value) == true then
                local num = tonumber(value)
                if num < 0 or num > 2.5 then
                    return "2.5"
                else
                    return value
                end
            else
                return "2.5"
            end
        end,
        writePrivilege=  RoleType.Maintain,
        readPrivilege = RoleType.Maintain,
    },
    ---- row = 15
    --{
    --    name = "SyringeSuckStandard",
    --    text= "注射器抽量程校准液",
    --    data = 2.5,
    --    createFlow= function(mode, volume)
    --        local flow = LiquidOperateFlow:new({}, setting.liquidType.airReagent, RollDirection.Suck, setting.component.xPos.standardCell, volume, setting.runAction.syringeSuckStandard)
    --        flow.name = setting.ui.operation.liquidOperator[15].name
    --        FlowList.AddFlow(flow)
    --    end,
    --    checkValue = function(mode, value)
    --        if setting.ui.operation.liquidOperator.syrVolumePattern(mode, value) == true then
    --            local num = tonumber(value)
    --            if num < 0 or num > 2.5 then
    --                return "2.5"
    --            else
    --                return value
    --            end
    --        else
    --            return "2.5"
    --        end
    --    end,
    --    writePrivilege=  RoleType.Maintain,
    --    readPrivilege = RoleType.Maintain,
    --},
    -- row = 15
    {
        name = "SyringeSuckExposure",
        text= "注射器抽曝气池溶液",
        data = 2.5,
        createFlow= function(mode, volume)
            local flow = LiquidOperateFlow:new({}, setting.liquidType.airReagent, RollDirection.Suck, setting.component.xPos.exposureCell, volume, setting.runAction.syringeSuckExposure)
            flow.name = setting.ui.operation.liquidOperator[15].name
            FlowList.AddFlow(flow)
        end,
        checkValue = function(value)
            if setting.ui.operation.liquidOperator.syrVolumePattern(value) == true then
                local num = tonumber(value)
                if num < 0 or num > 2.5 then
                    return "2.5"
                else
                    return value
                end
            else
                return "2.5"
            end
        end,
        writePrivilege=  RoleType.Maintain,
        readPrivilege = RoleType.Maintain,
    },
    -- row = 16
    {
        name = "SyringeSuckDilute",
        text= "注射器抽稀释杯溶液",
        data = 2.5,
        createFlow= function(mode, volume)
            local flow = LiquidOperateFlow:new({}, setting.liquidType.airReagent, RollDirection.Suck, setting.component.xPos.diluteCell, volume, setting.runAction.syringeSuckDilute)
            flow.name = setting.ui.operation.liquidOperator[16].name
            FlowList.AddFlow(flow)
        end,
        checkValue = function(value)
            if setting.ui.operation.liquidOperator.syrVolumePattern(value) == true then
                local num = tonumber(value)
                if num < 0 or num > 2.5 then
                    return "2.5"
                else
                    return value
                end
            else
                return "2.5"
            end
        end,
        writePrivilege=  RoleType.Maintain,
        readPrivilege = RoleType.Maintain,
    },
    -- row = 17
    {
        name = "DrainToSample",
        text= "排至通道一",
        data = 10,
        createFlow= function(mode, volume)
            local flow = LiquidOperateFlow:new({}, setting.liquidType.exSampleOut1, RollDirection.Drain, 0, volume, setting.runAction.drainToSample1)
            flow.name = setting.ui.operation.liquidOperator[17].name
            FlowList.AddFlow(flow)
        end,
        checkValue = function(value)
            if setting.ui.operation.liquidOperator.pumpVolumePattern(value) == true then
                local num = tonumber(value)
                if num < 0 or num > 50 then
                    return "10"
                else
                    return value
                end
            else
                return "10"
            end
        end,
        writePrivilege=  RoleType.Maintain,
        readPrivilege = RoleType.Maintain,
        targetPrivilege = Target.ChannelOne,
    },
    -- row = 18
    {
        name = "DrainToSample",
        text= "排至通道二",
        data = 10,
        createFlow= function(mode, volume)
            local flow = LiquidOperateFlow:new({}, setting.liquidType.exSampleOut2, RollDirection.Drain, 0, volume, setting.runAction.drainToSample2)
            flow.name = setting.ui.operation.liquidOperator[18].name
            FlowList.AddFlow(flow)
        end,
        checkValue = function(value)
            if setting.ui.operation.liquidOperator.pumpVolumePattern(value) == true then
                local num = tonumber(value)
                if num < 0 or num > 50 then
                    return "10"
                else
                    return value
                end
            else
                return "10"
            end
        end,
        writePrivilege=  RoleType.Maintain,
        readPrivilege = RoleType.Maintain,
        targetPrivilege = Target.ChannelTwo,
    },
    -- row = 19
    {
        name = "DrainToSample",
        text= "排至通道三",
        data = 10,
        createFlow= function(mode, volume)
            local flow = LiquidOperateFlow:new({}, setting.liquidType.exSampleOut3, RollDirection.Drain, 0, volume, setting.runAction.drainToSample3)
            flow.name = setting.ui.operation.liquidOperator[19].name
            FlowList.AddFlow(flow)
        end,
        checkValue = function(value)
            if setting.ui.operation.liquidOperator.pumpVolumePattern(value) == true then
                local num = tonumber(value)
                if num < 0 or num > 50 then
                    return "10"
                else
                    return value
                end
            else
                return "10"
            end
        end,
        writePrivilege=  RoleType.Maintain,
        readPrivilege = RoleType.Maintain,
        targetPrivilege = Target.ChannelThree,
    },
    -- row = 20
    {
        name = "DrainToSample",
        text= "排至通道四",
        data = 10,
        createFlow= function(mode, volume)
            local flow = LiquidOperateFlow:new({}, setting.liquidType.exSampleOut4, RollDirection.Drain, 0, volume, setting.runAction.drainToSample4)
            flow.name = setting.ui.operation.liquidOperator[20].name
            FlowList.AddFlow(flow)
        end,
        checkValue = function(value)
            if setting.ui.operation.liquidOperator.pumpVolumePattern(value) == true then
                local num = tonumber(value)
                if num < 0 or num > 50 then
                    return "10"
                else
                    return value
                end
            else
                return "10"
            end
        end,
        writePrivilege=  RoleType.Maintain,
        readPrivilege = RoleType.Maintain,
        targetPrivilege = Target.ChannelFour,
    },
    -- row = 21
    {
        name = "DrainToSample",
        text= "排至通道五",
        data = 10,
        createFlow= function(mode, volume)
            local flow = LiquidOperateFlow:new({}, setting.liquidType.exSampleOut5, RollDirection.Drain, 0, volume, setting.runAction.drainToSample5)
            flow.name = setting.ui.operation.liquidOperator[21].name
            FlowList.AddFlow(flow)
        end,
        checkValue = function(value)
            if setting.ui.operation.liquidOperator.pumpVolumePattern(value) == true then
                local num = tonumber(value)
                if num < 0 or num > 50 then
                    return "10"
                else
                    return value
                end
            else
                return "10"
            end
        end,
        writePrivilege=  RoleType.Maintain,
        readPrivilege = RoleType.Maintain,
        targetPrivilege = Target.ChannelFive,
    },
    -- row = 22
    {
        name = "DrainToSample",
        text= "排至通道六",
        data = 10,
        createFlow= function(mode, volume)
            local flow = LiquidOperateFlow:new({}, setting.liquidType.exSampleOut6, RollDirection.Drain, 0, volume, setting.runAction.drainToSample6)
            flow.name = setting.ui.operation.liquidOperator[22].name
            FlowList.AddFlow(flow)
        end,
        checkValue = function(value)
            if setting.ui.operation.liquidOperator.pumpVolumePattern(value) == true then
                local num = tonumber(value)
                if num < 0 or num > 50 then
                    return "10"
                else
                    return value
                end
            else
                return "10"
            end
        end,
        writePrivilege=  RoleType.Maintain,
        readPrivilege = RoleType.Maintain,
        targetPrivilege = Target.ChannelSix,
    },
    -- row = 23
    {
        name = "SuckFromSample1",
        text= "填充扩展通道1",
        data = 10,
        createFlow= function(mode, volume)
            local flow = LiquidOperateFlow:new({}, setting.liquidType.exSampleIn1, RollDirection.Suck, 0, volume, setting.runAction.suckFromExtend1)
            flow.name = setting.ui.operation.liquidOperator[23].name
            FlowList.AddFlow(flow)
        end,
        checkValue = function(value)
            if setting.ui.operation.liquidOperator.pumpVolumePattern(value) == true then
                local num = tonumber(value)
                if num < 0 or num > 50 then
                    return "10"
                else
                    return value
                end
            else
                return "10"
            end
        end,
        writePrivilege=  RoleType.Maintain,
        readPrivilege = RoleType.Maintain,
        targetPrivilege = Target.ChannelSix,
    },
    -- row = 24
    {
        name = "SuckFromSample2",
        text= "填充扩展通道2",
        data = 10,
        createFlow= function(mode, volume)
            local flow = LiquidOperateFlow:new({}, setting.liquidType.exSampleIn2, RollDirection.Suck, 0, volume, setting.runAction.suckFromExtend2)
            flow.name = setting.ui.operation.liquidOperator[24].name
            FlowList.AddFlow(flow)
        end,
        checkValue = function(value)
            if setting.ui.operation.liquidOperator.pumpVolumePattern(value) == true then
                local num = tonumber(value)
                if num < 0 or num > 50 then
                    return "10"
                else
                    return value
                end
            else
                return "10"
            end
        end,
        writePrivilege=  RoleType.Maintain,
        readPrivilege = RoleType.Maintain,
        targetPrivilege = Target.ChannelSix,
    },
    -- row = 25
    {
        name = "SuckFromSample3",
        text= "填充扩展通道3",
        data = 10,
        createFlow= function(mode, volume)
            local flow = LiquidOperateFlow:new({}, setting.liquidType.exSampleIn3, RollDirection.Suck, 0, volume, setting.runAction.suckFromExtend3)
            flow.name = setting.ui.operation.liquidOperator[25].name
            FlowList.AddFlow(flow)
        end,
        checkValue = function(value)
            if setting.ui.operation.liquidOperator.pumpVolumePattern(value) == true then
                local num = tonumber(value)
                if num < 0 or num > 50 then
                    return "10"
                else
                    return value
                end
            else
                return "10"
            end
        end,
        writePrivilege=  RoleType.Maintain,
        readPrivilege = RoleType.Maintain,
        targetPrivilege = Target.ChannelSix,
    },
    -- row = 26
    {
        name = "SuckFromSample4",
        text= "填充扩展通道4",
        data = 10,
        createFlow= function(mode, volume)
            local flow = LiquidOperateFlow:new({}, setting.liquidType.exSampleIn4, RollDirection.Suck, 0, volume, setting.runAction.suckFromExtend4)
            flow.name = setting.ui.operation.liquidOperator[26].name
            FlowList.AddFlow(flow)
        end,
        checkValue = function(value)
            if setting.ui.operation.liquidOperator.pumpVolumePattern(value) == true then
                local num = tonumber(value)
                if num < 0 or num > 50 then
                    return "10"
                else
                    return value
                end
            else
                return "10"
            end
        end,
        writePrivilege=  RoleType.Maintain,
        readPrivilege = RoleType.Maintain,
        targetPrivilege = Target.ChannelSix,
    },
    -- row = 27
    {
        name = "SuckFromSample5",
        text= "填充扩展通道5",
        data = 10,
        createFlow= function(mode, volume)
            local flow = LiquidOperateFlow:new({}, setting.liquidType.exSampleIn5, RollDirection.Suck, 0, volume, setting.runAction.suckFromExtend5)
            flow.name = setting.ui.operation.liquidOperator[27].name
            FlowList.AddFlow(flow)
        end,
        checkValue = function(value)
            if setting.ui.operation.liquidOperator.pumpVolumePattern(value) == true then
                local num = tonumber(value)
                if num < 0 or num > 50 then
                    return "10"
                else
                    return value
                end
            else
                return "10"
            end
        end,
        writePrivilege=  RoleType.Maintain,
        readPrivilege = RoleType.Maintain,
        targetPrivilege = Target.ChannelSix,
    },
    -- row = 28
    {
        name = "SuckFromSample6",
        text= "填充扩展通道6",
        data = 10,
        createFlow= function(mode, volume)
            local flow = LiquidOperateFlow:new({}, setting.liquidType.exSampleIn6, RollDirection.Suck, 0, volume, setting.runAction.suckFromExtend6)
            flow.name = setting.ui.operation.liquidOperator[28].name
            FlowList.AddFlow(flow)
        end,
        checkValue = function(value)
            if setting.ui.operation.liquidOperator.pumpVolumePattern(value) == true then
                local num = tonumber(value)
                if num < 0 or num > 50 then
                    return "10"
                else
                    return value
                end
            else
                return "10"
            end
        end,
        writePrivilege=  RoleType.Maintain,
        readPrivilege = RoleType.Maintain,
        targetPrivilege = Target.ChannelSix,
    },
    -- row = 29
    {
        name = "DrainToSample1",
        text= "排至扩展通道1",
        data = 10,
        createFlow= function(mode, volume)
            local flow = LiquidOperateFlow:new({}, setting.liquidType.exSampleIn1, RollDirection.Drain, 0, volume, setting.runAction.drainToExtend1)
            flow.name = setting.ui.operation.liquidOperator[29].name
            FlowList.AddFlow(flow)
        end,
        checkValue = function(value)
            if setting.ui.operation.liquidOperator.pumpVolumePattern(value) == true then
                local num = tonumber(value)
                if num < 0 or num > 50 then
                    return "10"
                else
                    return value
                end
            else
                return "10"
            end
        end,
        writePrivilege=  RoleType.Maintain,
        readPrivilege = RoleType.Maintain,
        targetPrivilege = Target.ChannelSix,
    },
    -- row = 30
    {
        name = "DrainToSample2",
        text= "排至扩展通道2",
        data = 10,
        createFlow= function(mode, volume)
            local flow = LiquidOperateFlow:new({}, setting.liquidType.exSampleIn2, RollDirection.Drain, 0, volume, setting.runAction.drainToExtend2)
            flow.name = setting.ui.operation.liquidOperator[30].name
            FlowList.AddFlow(flow)
        end,
        checkValue = function(value)
            if setting.ui.operation.liquidOperator.pumpVolumePattern(value) == true then
                local num = tonumber(value)
                if num < 0 or num > 50 then
                    return "10"
                else
                    return value
                end
            else
                return "10"
            end
        end,
        writePrivilege=  RoleType.Maintain,
        readPrivilege = RoleType.Maintain,
        targetPrivilege = Target.ChannelSix,
    },
    -- row = 31
    {
        name = "DrainToSample3",
        text= "排至扩展通道3",
        data = 10,
        createFlow= function(mode, volume)
            local flow = LiquidOperateFlow:new({}, setting.liquidType.exSampleIn3, RollDirection.Drain, 0, volume, setting.runAction.drainToExtend3)
            flow.name = setting.ui.operation.liquidOperator[31].name
            FlowList.AddFlow(flow)
        end,
        checkValue = function(value)
            if setting.ui.operation.liquidOperator.pumpVolumePattern(value) == true then
                local num = tonumber(value)
                if num < 0 or num > 50 then
                    return "10"
                else
                    return value
                end
            else
                return "10"
            end
        end,
        writePrivilege=  RoleType.Maintain,
        readPrivilege = RoleType.Maintain,
        targetPrivilege = Target.ChannelSix,
    },
    -- row = 32
    {
        name = "DrainToSample4",
        text= "排至扩展通道4",
        data = 10,
        createFlow= function(mode, volume)
            local flow = LiquidOperateFlow:new({}, setting.liquidType.exSampleIn4, RollDirection.Drain, 0, volume, setting.runAction.drainToExtend4)
            flow.name = setting.ui.operation.liquidOperator[32].name
            FlowList.AddFlow(flow)
        end,
        checkValue = function(value)
            if setting.ui.operation.liquidOperator.pumpVolumePattern(value) == true then
                local num = tonumber(value)
                if num < 0 or num > 50 then
                    return "10"
                else
                    return value
                end
            else
                return "10"
            end
        end,
        writePrivilege=  RoleType.Maintain,
        readPrivilege = RoleType.Maintain,
        targetPrivilege = Target.ChannelSix,
    },
    -- row = 33
    {
        name = "DrainToSample5",
        text= "排至扩展通道5",
        data = 10,
        createFlow= function(mode, volume)
            local flow = LiquidOperateFlow:new({}, setting.liquidType.exSampleIn5, RollDirection.Drain, 0, volume, setting.runAction.drainToExtend5)
            flow.name = setting.ui.operation.liquidOperator[33].name
            FlowList.AddFlow(flow)
        end,
        checkValue = function(value)
            if setting.ui.operation.liquidOperator.pumpVolumePattern(value) == true then
                local num = tonumber(value)
                if num < 0 or num > 50 then
                    return "10"
                else
                    return value
                end
            else
                return "10"
            end
        end,
        writePrivilege=  RoleType.Maintain,
        readPrivilege = RoleType.Maintain,
        targetPrivilege = Target.ChannelSix,
    },
    -- row = 34
    {
        name = "DrainToSample6",
        text= "排至扩展通道6",
        data = 10,
        createFlow= function(mode, volume)
            local flow = LiquidOperateFlow:new({}, setting.liquidType.exSampleIn6, RollDirection.Drain, 0, volume, setting.runAction.drainToExtend6)
            flow.name = setting.ui.operation.liquidOperator[34].name
            FlowList.AddFlow(flow)
        end,
        checkValue = function(value)
            if setting.ui.operation.liquidOperator.pumpVolumePattern(value) == true then
                local num = tonumber(value)
                if num < 0 or num > 50 then
                    return "10"
                else
                    return value
                end
            else
                return "10"
            end
        end,
        writePrivilege=  RoleType.Maintain,
        readPrivilege = RoleType.Maintain,
        targetPrivilege = Target.ChannelSix,
    },
    -- row = 35
    {
        name = "SuckFromStandard",
        text= "填充量程校准液",
        data = 10,
        createFlow= function(mode, volume)
            local flow = LiquidOperateFlow:new({}, setting.liquidType.standard, RollDirection.Suck, 0, volume, setting.runAction.suckFromStandard)
            flow.name = setting.ui.operation.liquidOperator[35].name
            FlowList.AddFlow(flow)
        end,
        checkValue = function(value)
            if setting.ui.operation.liquidOperator.pumpVolumePattern(value) == true then
                local num = tonumber(value)
                if num < 0 or num > 50 then
                    return "10"
                else
                    return value
                end
            else
                return "10"
            end
        end,
        writePrivilege=  RoleType.Maintain,
        readPrivilege = RoleType.Maintain,
        targetPrivilege = Target.ChannelSix,
    },
    -- row = 36
    {
        name = "DrainToStandard",
        text= "排至量程校准液",
        data = 10,
        createFlow= function(mode, volume)
            local flow = LiquidOperateFlow:new({}, setting.liquidType.standard, RollDirection.Drain, 0, volume, setting.runAction.drainToStandard)
            flow.name = setting.ui.operation.liquidOperator[36].name
            FlowList.AddFlow(flow)
        end,
        checkValue = function(value)
            if setting.ui.operation.liquidOperator.pumpVolumePattern(value) == true then
                local num = tonumber(value)
                if num < 0 or num > 50 then
                    return "10"
                else
                    return value
                end
            else
                return "10"
            end
        end,
        writePrivilege=  RoleType.Maintain,
        readPrivilege = RoleType.Maintain,
        targetPrivilege = Target.ChannelSix,
    },
    pumpVolumePattern = function(value)
        local ret = false
        if type(value) == "string" then
            local decimalPatterm = "^%d?%d%.%d%d?%d?$"
            local integerPatterm = "^%d?%d$"
            if not string.find(value, decimalPatterm) then
                if string.find(value, integerPatterm) then
                    ret = true
                end
            else
                ret = true
            end
        end

        return ret
    end,
    syrVolumePattern = function(value)
        local ret = false
        if type(value) == "string" then
            local decimalPatterm = "^%d%.%d%d?%d?$"
            local integerPatterm = "^%d$"
            if not string.find(value, decimalPatterm) then
                if string.find(value, integerPatterm) then
                    ret = true
                end
            else
                ret = true
            end
        end

        return ret
    end,
}
return setting.ui.operation.liquidOperator
