setting.ui.operation = {}
setting.ui.operation.maintain =
{
    name ="maintain",
    text= "维护",
    rowCount = 16,
    superRow = 2,
    administratorRow = 14,
    writePrivilege=  RoleType.Maintain,
    readPrivilege = RoleType.Maintain,
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
            flow.isUseStart = true
            flow.name = "MeasureSample"
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
            flow.isUseStart = true
            flow.name = "MeasureSample"
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
            flow.isUseStart = true
            flow.name = "MeasureSample"
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
            flow.isUseStart = true
            flow.name = "MeasureSample"
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
            flow.isUseStart = true
            flow.name = "MeasureSample"
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
            flow.isUseStart = true
            flow.name = "MeasureSample"
            FlowList.AddFlow(flow)
        end,
    },
    {
        name ="CalibrateTC",
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
        name ="CalibrateIC",
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
        name ="CalibrateNPOC",
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
    {
        name ="MeasureStandard",
        text= "测量程校准液",
        writePrivilege=  RoleType.Maintain,
        readPrivilege = RoleType.Maintain,
        getRunTime = function()
            return setting.runStatus.measureStandard.GetTime()
        end,
        createFlow= function()
            log:debug("Maintain createFlow ==> MeasureFlow:Standard")
            local flow = MeasureFlow:new({}, MeasureType.Standard)
            flow.isUseStart = true
            flow.name  = "MeasureStandard"
            FlowList.AddFlow(flow)
        end,
    },
    {
        name ="MeasureBlank",
        text= "测零点校准液",
        writePrivilege=  RoleType.Maintain,
        readPrivilege = RoleType.Maintain,
        getRunTime = function()
            return setting.runStatus.measureBlank.GetTime()
        end,
        createFlow= function()
            log:debug("Maintain createFlow ==> MeasureFlow:Blank")
            local flow = MeasureFlow:new({}, MeasureType.Blank)
            flow.name  = "MeasureBlank"
            FlowList.AddFlow(flow)
        end,
    },
    --{
    --    name ="MeasureRangeCheck",
    --    text= "测标样(跨度)核查液",
    --    writePrivilege=  RoleType.Maintain,
    --    readPrivilege = RoleType.Maintain,
    --    getRunTime = function()
    --        return setting.runStatus.measureStandard.GetTime()
    --    end,
    --    createFlow= function()
    --        log:debug("Maintain createFlow ==> MeasureFlow:RangeCheck")
    --        local flow = MeasureFlow:new({}, MeasureType.RangeCheck)
    --        flow.name  = "MeasureRangeCheck"
    --        flow.isCheck = true
    --        FlowList.AddFlow(flow)
    --    end,
    --},
    --{
    --    name ="MeasureZeroCheck",
    --    text= "测零点核查液",
    --    writePrivilege=  RoleType.Maintain,
    --    readPrivilege = RoleType.Maintain,
    --    getRunTime = function()
    --        return setting.runStatus.measureStandard.GetTime()
    --    end,
    --    createFlow= function()
    --        log:debug("Maintain createFlow ==> MeasureFlow:ZeroCheck")
    --        local flow = MeasureFlow:new({}, MeasureType.ZeroCheck)
    --        flow.name  = "MeasureZeroCheck"
    --        flow.isCheck = true
    --        FlowList.AddFlow(flow)
    --    end,
    --},
    --{
    --    name ="OnlyCalibrateStandard",
    --    text= "量程校准",
    --    writePrivilege=  RoleType.Maintain,
    --    readPrivilege = RoleType.Maintain,
    --    getRunTime = function()
    --        return setting.runStatus.onlyCalibrateStandard.GetTime()
    --    end,
    --    createFlow= function()
    --        log:debug("Maintain createFlow ==> CalibrateFlow:onlyCalibrateStandard")
    --        local flow = CalibrateFlow:new({}, CalibrateType.onlyCalibrateStandard)
    --        flow.name  = setting.ui.operation.maintain[8].name
    --        FlowList.AddFlow(flow)
    --    end,
    --},
    --{
    --    name ="OnlyCalibrateBlank",
    --    text= "零点校准",
    --    writePrivilege=  RoleType.Maintain,
    --    readPrivilege = RoleType.Maintain,
    --    getRunTime = function()
    --        return setting.runStatus.onlyCalibrateBlank.GetTime()
    --    end,
    --    createFlow= function()
    --        log:debug("Maintain createFlow ==> CalibrateFlow:onlyCalibrateBlank")
    --        local flow = CalibrateFlow:new({}, CalibrateType.onlyCalibrateBlank)
    --        flow.name  = setting.ui.operation.maintain[9].name
    --        FlowList.AddFlow(flow)
    --    end,
    --},
    {
        name ="CleanDeeply",
        text= "深度清洗",
        writePrivilege=  RoleType.Maintain,
        readPrivilege = RoleType.Maintain,
        getRunTime = function()
            return setting.runStatus.cleanDeeply.GetTime()
        end,
        createFlow= function()
            local flow = CleanFlow:new({},cleanType.cleanDeeply)
            flow.name  = "CleanDeeply"
            FlowList.AddFlow(flow)
        end,
    },
    --{
    --    name ="CleanAll",
    --    text= "清洗所有管路",
    --    writePrivilege=  RoleType.Super,
    --    readPrivilege = RoleType.Super,
    --    getRunTime = function()
    --        return setting.runStatus.cleanAll.GetTime()
    --    end,
    --    createFlow= function()
    --        local flow = CleanFlow:new({},cleanType.cleanAll)
    --        flow.name = "CleanAll"
    --        FlowList.AddFlow(flow)
    --    end,
    --},
    {
        name ="CollectSample",
        text= "采集水样",
        writePrivilege=  RoleType.Maintain,
        readPrivilege = RoleType.Maintain,
        getRunTime = function()
            return setting.runStatus.collectSample.GetTime()
        end,
        createFlow= function()
            local flow = CollectSampleFlow:new()
            flow.name  = "CollectSample"
            FlowList.AddFlow(flow)
        end,
    },
    --{
    --    name ="MeasureADAdjust",
    --    text= "测量模块调节",
    --    writePrivilege=  RoleType.Administrator,
    --    readPrivilege = RoleType.Administrator,
    --    getRunTime = function()
    --        return setting.runStatus.measureADAdjust.GetTime()
    --    end,
    --    createFlow= function()
    --        local flow = ADAdjustFlow:new({}, setting.runAction.measureADAdjust)
    --        flow.name  = "MeasureADAdjust"
    --        flow.action = setting.runAction.measureADAdjust
    --        FlowList.AddFlow(flow)
    --    end,
    --},
    --{
    --    name ="OneKeyRenew",
    --    text= "一键更新试剂",
    --    writePrivilege=  RoleType.Maintain,
    --    readPrivilege = RoleType.Maintain,
    --    getRunTime = function()
    --        return setting.runStatus.oneKeyRenew.GetTime()
    --    end,
    --    createFlow= function()
    --        local flow = CleanFlow:new({}, cleanType.oneKeyRenew)
    --        flow.name  = "OneKeyRenew"
    --        FlowList.AddFlow(flow)
    --    end,
    --},
    --{
    --    name ="MeasureQualityHandle",
    --    text= "测质控样",
    --    writePrivilege=  RoleType.Maintain,
    --    readPrivilege = RoleType.Maintain,
    --    getRunTime = function()
    --        return setting.runStatus.measureQualityHandle.GetTime()
    --    end,
    --    createFlow= function()
    --        log:debug("Maintain createFlow ==> MeasureFlow:QualityHandle")
    --        local flow = MeasureFlow:new({}, MeasureType.QualityHandle)
    --        flow.name  = "MeasureQualityHandle"
    --        flow.isUseStart = true
    --        FlowList.AddFlow(flow)
    --    end,
    --},
    --{
    --    name ="Range1CurveCalibrate",
    --    text= "量程一因子",
    --    writePrivilege=  RoleType.Administrator,
    --    readPrivilege = RoleType.Administrator,
    --    getRunTime = function()
    --        return setting.runStatus.onlyCalibrateStandard.GetTime()
    --    end,
    --    createFlow= function()
    --        log:debug("Maintain createFlow ==> CalibrateFlow:Range1CurveCalibrate")
    --        local flow = CalibrateFlow:new({}, CalibrateType.onlyCalibrateStandard)
    --        flow.name  = "Range1CurveCalibrate"
    --        flow.curveCalibrateRange = 1
    --        flow.isUseStart = true
    --        FlowList.AddFlow(flow)
    --    end,
    --},
    --{
    --    name ="Range2CurveCalibrate",
    --    text= "量程二因子",
    --    writePrivilege=  RoleType.Administrator,
    --    readPrivilege = RoleType.Administrator,
    --    getRunTime = function()
    --        return setting.runStatus.onlyCalibrateStandard.GetTime()
    --    end,
    --    createFlow= function()
    --        log:debug("Maintain createFlow ==> CalibrateFlow:Range2CurveCalibrate")
    --        local flow = CalibrateFlow:new({}, CalibrateType.onlyCalibrateStandard)
    --        flow.name  = "Range2CurveCalibrate"
    --        flow.curveCalibrateRange = 2
    --        flow.isUseStart = true
    --        FlowList.AddFlow(flow)
    --    end,
    --},
    --{
    --    name ="Range3CurveCalibrate",
    --    text= "量程三因子",
    --    writePrivilege=  RoleType.Administrator,
    --    readPrivilege = RoleType.Administrator,
    --    getRunTime = function()
    --        return setting.runStatus.onlyCalibrateStandard.GetTime()
    --    end,
    --    createFlow= function()
    --        log:debug("Maintain createFlow ==> CalibrateFlow:Range3CurveCalibrate")
    --        local flow = CalibrateFlow:new({}, CalibrateType.onlyCalibrateStandard)
    --        flow.name  = "Range3CurveCalibrate"
    --        flow.curveCalibrateRange = 3
    --        flow.isUseStart = true
    --        FlowList.AddFlow(flow)
    --    end,
    --},
    {
        name ="DrainFromRefrigerator",
        text= "气体置换",
        writePrivilege=  RoleType.Maintain,
        readPrivilege = RoleType.Maintain,
        getRunTime = function()
            return setting.runStatus.drainFromRefrigerator.GetTime()
        end,
        createFlow= function()
            local flow = CleanFlow:new({}, cleanType.drainFromRefrigerator)
            flow.name  = "DrainFromRefrigerator"
            FlowList.AddFlow(flow)
        end,
    },
    {
        name ="SliderForwardCalibrate",
        text= "滑块前进校准",
        writePrivilege=  RoleType.Super,
        readPrivilege = RoleType.Super,
        getRunTime = function()
            return setting.runStatus.sliderForwardCalibrate.GetTime()
        end,
        createFlow= function()
            local flow = ADAdjustFlow:new({}, setting.runAction.sliderForwardCalibrate)
            flow.name  = "SliderForwardCalibrate"
            flow.action = setting.runAction.sliderForwardCalibrate
            FlowList.AddFlow(flow)
        end,
    },
    {
        name ="SliderBackWardCalibrate",
        text= "滑块后退校准",
        writePrivilege=  RoleType.Super,
        readPrivilege = RoleType.Super,
        getRunTime = function()
            return setting.runStatus.sliderBackWardCalibrate.GetTime()
        end,
        createFlow= function()
            local flow = ADAdjustFlow:new({}, setting.runAction.sliderBackWardCalibrate)
            flow.name  = "SliderBackWardCalibrate"
            flow.action = setting.runAction.sliderBackWardCalibrate
            FlowList.AddFlow(flow)
        end,
    },
    checkOEM = function()
        return config.system.OEM
    end,

}
return setting.ui.operation.maintain
