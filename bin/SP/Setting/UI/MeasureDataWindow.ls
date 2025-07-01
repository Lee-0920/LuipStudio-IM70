setting.ui.measureDataWindow =
{
    measureData =
    {
        {
            name = "核查数据",
            resultDataname = setting.resultFileInfo.measureRecordFile[1].name,
            targetPrivilege = Target.Check,
        },
        {
            name = "测通道一",
            resultDataname = setting.resultFileInfo.measureRecordFile[2].name,
            targetPrivilege = Target.ChannelOne,
        },
        {
            name = "测通道二",
            resultDataname = setting.resultFileInfo.measureRecordFile[3].name,
            targetPrivilege = Target.ChannelTwo,
        },
        {
            name = "测通道三",
            resultDataname = setting.resultFileInfo.measureRecordFile[4].name,
            targetPrivilege = Target.ChannelThree,
        },
        {
            name = "测通道四",
            resultDataname = setting.resultFileInfo.measureRecordFile[5].name,
            targetPrivilege = Target.ChannelFour,
        },
        {
            name = "测通道五",
            resultDataname = setting.resultFileInfo.measureRecordFile[6].name,
            targetPrivilege = Target.ChannelFive,
        },
        {
            name = "测通道六",
            resultDataname = setting.resultFileInfo.measureRecordFile[7].name,
            targetPrivilege = Target.ChannelSix,
        },
    },
    waveData =
    {
        {
            name = "核查趋势",
            resultDataname = setting.resultFileInfo.measureRecordFile[1].name,
            profileTableName = "config.measureParam",
            rangeTableName = "config.system.rangeViewMap",
            targetPrivilege = Target.Check,
        },
        {
            name = "通道一趋势",
            resultDataname = setting.resultFileInfo.measureRecordFile[2].name,
            profileTableName = "config.measureParam",
            rangeTableName = "config.system.rangeViewMap",
            targetPrivilege = Target.ChannelOne,
        },
        {
            name = "通道二趋势",
            resultDataname = setting.resultFileInfo.measureRecordFile[3].name,
            profileTableName = "config.measureParam",
            rangeTableName = "config.system.rangeViewMap",
            targetPrivilege = Target.ChannelTwo,
        },
        {
            name = "通道三趋势",
            resultDataname = setting.resultFileInfo.measureRecordFile[4].name,
            profileTableName = "config.measureParam",
            rangeTableName = "config.system.rangeViewMap",
            targetPrivilege = Target.ChannelThree,
        },
        {
            name = "通道四趋势",
            resultDataname = setting.resultFileInfo.measureRecordFile[5].name,
            profileTableName = "config.measureParam",
            rangeTableName = "config.system.rangeViewMap",
            targetPrivilege = Target.ChannelFour,
        },
        {
            name = "通道五趋势",
            resultDataname = setting.resultFileInfo.measureRecordFile[6].name,
            profileTableName = "config.measureParam",
            rangeTableName = "config.system.rangeViewMap",
            targetPrivilege = Target.ChannelFive,
        },
        {
            name = "通道六趋势",
            resultDataname = setting.resultFileInfo.measureRecordFile[7].name,
            profileTableName = "config.measureParam",
            rangeTableName = "config.system.rangeViewMap",
            targetPrivilege = Target.ChannelSix,
        },
    },
    calibrateCurve =
    {
        {
            name = "校准曲线",
            resultDataname = setting.resultFileInfo.calibrateRecordFile[1].name,
            profileTableName = "config.measureParam",
            curveParamName = "config.measureParam.curveParam[1]",--此表必须是profileTableName表中的子表
            profileFileName = "MeasureParamConfig.ls",
        },
    },
}
return setting.ui.measureDataWindow
