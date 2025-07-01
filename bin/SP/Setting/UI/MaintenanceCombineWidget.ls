setting.ui.operation.maintainCombine =
{
    name ="maintainCombine",
    text= "维护组合",
    writePrivilege=  RoleType.Administrator,
    readPrivilege = RoleType.Administrator,
    {
        name ="MeasureSample1",
        text= "通道一测量",
        writePrivilege=  RoleType.Maintain,
        readPrivilege = RoleType.Maintain,
        targetPrivilege = Target.ChannelOne,
        getRunTime = function()
            return setting.runStatus.measureSample.GetTime()
        end,
        createFlow= function()
            log:debug("Maintain createFlow ==> MeasureFlow:Sample ChannelOne")
            local flow = MeasureFlow:new({}, MeasureType.Sample)
            flow.target = config.system.targetMap.ChannelOne.num
            flow.name = "MeasureSample",
            FlowList.AddFlow(flow)
        end,
    },
    {
        name ="MeasureSample2",
        text= "通道二测量",
        writePrivilege=  RoleType.Maintain,
        readPrivilege = RoleType.Maintain,
        targetPrivilege = Target.ChannelTwo,
        getRunTime = function()
            return setting.runStatus.measureSample.GetTime()
        end,
        createFlow= function()
            log:debug("Maintain createFlow ==> MeasureFlow:Sample ChannelTwo")
            local flow = MeasureFlow:new({}, MeasureType.Sample)
            flow.target = config.system.targetMap.ChannelTwo.num
            flow.name = "MeasureSample",
            FlowList.AddFlow(flow)
        end,
    },
    {
        name ="MeasureSample3",
        text= "通道三测量",
        writePrivilege=  RoleType.Maintain,
        readPrivilege = RoleType.Maintain,
        targetPrivilege = Target.ChannelThree,
        getRunTime = function()
            return setting.runStatus.measureSample.GetTime()
        end,
        createFlow= function()
            log:debug("Maintain createFlow ==> MeasureFlow:Sample ChannelThree")
            local flow = MeasureFlow:new({}, MeasureType.Sample)
            flow.target = config.system.targetMap.ChannelThree.num
            flow.name = "MeasureSample",
            FlowList.AddFlow(flow)
        end,
    },
    {
        name ="MeasureSample4",
        text= "通道四测量",
        writePrivilege=  RoleType.Maintain,
        readPrivilege = RoleType.Maintain,
        targetPrivilege = Target.ChannelFour,
        getRunTime = function()
            return setting.runStatus.measureSample.GetTime()
        end,
        createFlow= function()
            log:debug("Maintain createFlow ==> MeasureFlow:Sample ChannelFour")
            local flow = MeasureFlow:new({}, MeasureType.Sample)
            flow.target = config.system.targetMap.ChannelFour.num
            flow.name = "MeasureSample",
            FlowList.AddFlow(flow)
        end,
    },
    {
        name ="MeasureSample5",
        text= "通道五测量",
        writePrivilege=  RoleType.Maintain,
        readPrivilege = RoleType.Maintain,
        targetPrivilege = Target.ChannelFive,
        getRunTime = function()
            return setting.runStatus.measureSample.GetTime()
        end,
        createFlow= function()
            log:debug("Maintain createFlow ==> MeasureFlow:Sample ChannelFive")
            local flow = MeasureFlow:new({}, MeasureType.Sample)
            flow.target = config.system.targetMap.ChannelFive.num
            flow.name = "MeasureSample",
            FlowList.AddFlow(flow)
        end,
    },
    {
        name ="MeasureSample6",
        text= "通道六测量",
        writePrivilege=  RoleType.Maintain,
        readPrivilege = RoleType.Maintain,
        targetPrivilege = Target.ChannelSix,
        getRunTime = function()
            return setting.runStatus.measureSample.GetTime()
        end,
        createFlow= function()
            log:debug("Maintain createFlow ==> MeasureFlow:Sample ChannelSix")
            local flow = MeasureFlow:new({}, MeasureType.Sample)
            flow.target = config.system.targetMap.ChannelSix.num
            flow.name = "MeasureSample",
            FlowList.AddFlow(flow)
        end,
    },
    {
        name ="Calibrate",
        text= "TC校准",
        writePrivilege=  RoleType.Maintain,
        readPrivilege = RoleType.Maintain,
        getRunTime = function()
            return setting.runStatus.calibrate.GetTime()
        end,
        createFlow= function()
            log:debug("Maintain createFlow ==> CalibrateFlow: TC")
            local flow = CalibrateFlow:new({}, CalibrateType.calibrate)
            flow.currentModelType = ModelType.TC
            flow.name  = "Calibrate"
            FlowList.AddFlow(flow)
        end,
    },
    {
        name ="Calibrate",
        text= "IC校准",
        writePrivilege=  RoleType.Maintain,
        readPrivilege = RoleType.Maintain,
        getRunTime = function()
            return setting.runStatus.calibrate.GetTime()
        end,
        createFlow= function()
            log:debug("Maintain createFlow ==> CalibrateFlow: IC")
            local flow = CalibrateFlow:new({}, CalibrateType.calibrate)
            flow.currentModelType = ModelType.IC
            flow.name  = "Calibrate"
            FlowList.AddFlow(flow)
        end,
    },
    {
        name ="Calibrate",
        text= "NPOC校准",
        writePrivilege=  RoleType.Maintain,
        readPrivilege = RoleType.Maintain,
        getRunTime = function()
            return setting.runStatus.calibrate.GetTime()
        end,
        createFlow= function()
            log:debug("Maintain createFlow ==> CalibrateFlow: NPOC")
            local flow = CalibrateFlow:new({}, CalibrateType.calibrate)
            flow.currentModelType = ModelType.NPOC
            flow.name  = "Calibrate"
            FlowList.AddFlow(flow)
        end,
    },
    --{
    --    name ="MeasureRangeCheck",
    --    text= "标样(跨度)核查",
    --    createFlow= function()
    --        local flow = MeasureFlow:new({}, MeasureType.RangeCheck)
    --        flow.name ="MeasureRangeCheck"
    --        flow.isUseStart = true
    --        FlowList.AddFlow(flow)
    --    end,
    --},
    --{
    --    name ="MeasureZeroCheck",
    --    text= "零点核查",
    --    createFlow= function()
    --        local flow = MeasureFlow:new({}, MeasureType.ZeroCheck)
    --        flow.name ="MeasureZeroCheck"
    --        flow.isUseStart = true
    --        FlowList.AddFlow(flow)
    --    end,
    --},
    {
        name ="MeasureStandard",
        text= "测量程校准液",
        createFlow= function()
            local flow = MeasureFlow:new({}, MeasureType.Standard)
            flow.name ="MeasureStandard"
            flow.isUseStart = true
            FlowList.AddFlow(flow)
        end,
    },
    {
        name ="MeasureBlank",
        text= "测零点校准液",
        createFlow= function()
            local flow = MeasureFlow:new({}, MeasureType.Blank)
            flow.name ="MeasureBlank"
            flow.isUseStart = true
            FlowList.AddFlow(flow)
        end,
    },
    {
        name ="CleanDeeply",
        text= "深度清洗",
        createFlow= function()
            local flow = CleanFlow:new({},cleanType.cleanDeeply)
            flow.name ="CleanDeeply"
            flow.isUseStart = true
            FlowList.AddFlow(flow)
        end,
    },
    --{
    --    name ="OneKeyRenew",
    --    text= "一键更新试剂",
    --    createFlow= function()
    --        local flow = CleanFlow:new({}, cleanType.oneKeyRenew)
    --        flow.name ="OneKeyRenew"
    --        flow.isUseStart = true
    --        FlowList.AddFlow(flow)
    --    end,
    --},

    ClearFlowList = function()
        log:debug("MaintainCombine ClearFlowList")
        FlowList.ClearList()
    end,
}
return setting.ui.operation.maintainCombine
