setting.alarm =
{
    pumpFailed =--
    {
        level = "Error",
        type = "仪器故障",
        name = "抽取失败",
    },
    pumpStop =--
    {
        level = "Warning", --只输出日志
        type = "仪器故障",
        name = "抽取被停止",
    },
    meterFailed =--
    {
        level = "Error",
        type = "仪器故障",
        name = "抽取失败",
    },
    acquirerADStop =--
    {
        level = "Warning",
        type = "仪器故障",
        name = "光学采集被停止",
    },
    acquirerADFailed =--
    {
        level = "Error",
        type = "仪器故障",
        name = "光学采集失败",
    },
    meterStop =--
    {
        level = "Warning",
        type = "仪器故障",
        name = "抽取被停止",
    },
    reagentRemain =--
    {
        level = "Error",
        type = "维护提示",
        name = "请更换试剂",
    },
    materialGoBad =--
    {
        level = "Error",
        type = "维护提示",
        name = "耗材已过期",
    },
    thermostatStop =--
    {
        level = "Warning",
        type = "仪器故障",
        name = "恒温被停止",
    },
    thermostatFault =--
    {
        level = "Error",
        type = "仪器故障",
        name = "温控故障",
    },
    dncpStackInit =--
    {
        level = "Info", --只输出日志，并且是warn类型的日志
        type = "通信异常",
        name = "DncpStack失败",
    },
    communication =--
    {
        level = "Error",
        type = "通信异常",
        name = "通信异常",
    },
    updateFault =--
    {
        level = "Error",
        type = "升级异常",
        name = "升级失败",
    },
    userStop =--
    {
        level = "Warning",
        type = "用户停止",
        name = "用户停止",
    },
    deviceRunFault =--
    {
        level = "Error",
        type = "仪器故障",
        name = "仪器运行故障",
    },
    drainFromDigestionFault =--
    {
        level = "Error",
        type = "仪器故障",
        name = "排消解液异常",
    },
    calibratePumpFailed =--
    {
        level = "Error",
        type = "仪器故障",
        name = "蠕动泵校准失败",
    },
    measureResultOutUpLimit =--
    {
        level = "Error",
        type = "测量异常",
        name = "水样超上限",
    },
    measureResultOutLowLimit =--
    {
        level = "Error",
        type = "测量异常",
        name = "水样超下限",
    },
    measureResultOutRange =
    {
        level = "Error",
        type = "测量异常",
        name = "水样超量程",
    },
    measureRangeWrong =
    {
        level = "Info",
        type = "测量异常",
        name = "量程切换",
    },
    curveCheckWrong =
    {
        level = "Error",
        type = "测量异常",
        name = "校准结果错误",
    },
    calibrateResultWrong =
    {
        level = "Error",
        type = "测量异常",
        name = "校准结果错误",
    },
    checkResultWrong =
    {
        level = "Error",
        type = "测量异常",
        name = "核查结果错误",
    },
    measureDataInvalid =
    {
        level = "Error",
        type = "测量异常",
        name = "数据异常",
    },
    measureLedInvalid =
    {
        level = "Error",
        type = "测量异常",
        name = "LED信号异常",
    },
    curveNotQualifiedWrong =
    {
        level = "Error",
        type = "校准异常",
        name = "校准不合格,沿用上条合格校准曲线",
    },
    exception =--
    {
        level = "Info",
        type = "系统异常",
        name = "系统异常",
    },
    std_exception =--
    {
        level = "Info",
        type = "系统异常",
        name = "std异常",
    },
    AddLiquidToDigestionFailed =
    {
        level = "Error",
        type = "仪器故障",
        name = "消解室加液异常",
    },
    staticADControlStopped =--
    {
        level = "Warning",
        type = "仪器故障",
        name = "静态AD调节被停止",
    },
    staticADControlFailed =--
    {
        level = "Error",
        type = "仪器故障",
        name = "静态AD调节失败",
    },
    measureLEDControlFailed =--
    {
        level = "Error",
        type = "仪器故障",
        name = "测量模块调节失败",
    },
    measureLEDControlStopped =--
    {
        level = "Error",
        type = "仪器故障",
        name = "测量模块调节被停止",
    },
    instrumentWeeping =--
    {
        level = "Error",
        type = "仪器故障",
        name = "仪器漏液",
    },
    reagentAuthorizationError =--
    {
        level = "Error",
        type = "试剂异常",
        name = "试剂配置不正确，请联系服务人员",
    },
    airFlowPressureLower =--
    {
        level = "Error",
        type = "气路异常",
        name = "载气压力过低",
    },
    airFlowPressureHigher =--
    {
        level = "Error",
        type = "气路异常",
        name = "载气压力过高",
    },
    masterPressureLower =--
    {
        level = "Error",
        type = "气路异常",
        name = "总阀压力过低",
    },
    masterPressureHigher =--
    {
        level = "Error",
        type = "气路异常",
        name = "总阀压力过高",
    },
    airFlowError =--
    {
        level = "Error",
        type = "气路异常",
        name = "载气调节失败",
    },
    slidersPositionError =--
    {
        level = "Error",
        type = "滑块故障",
        name = "位置异常，滑块处于非原点",
    },
    slidersSensorError =--
    {
        level = "Error",
        type = "滑块故障",
        name = "传感器故障，请检查传感器线路",
    },
    slidersResetFailed =--
    {
        level = "Error",
        type = "滑块故障",
        name = "滑块零点校准失败",
    },
    baseLineCheckFailed =--
    {
        level = "Error",
        type = "仪器故障",
        name = "基线无效",
    },
    motorFailed =--
    {
        level = "Error",
        type = "仪器故障",
        name = "电机运动故障",
    },
    refCollide =--
    {
        level = "Error",
        type = "仪器故障",
        name = "Z轴限位碰撞",
    },
    meaCollide =--
    {
        level = "Error",
        type = "仪器故障",
        name = "样本针碰撞",
    },
    motorXMoveOutSensorFail =--
    {
        level = "Error",
        type = "仪器故障",
        name = "X轴移不出传感器",
    },
    motorZMoveOutSensorFail =--
    {
        level = "Error",
        type = "仪器故障",
        name = "Z轴移不出传感器",
    },
    motorXMoveInSensorFail =--
    {
        level = "Error",
        type = "仪器故障",
        name = "X轴找不到传感器",
    },
    motorZMoveInSensorFail =--
    {
        level = "Error",
        type = "仪器故障",
        name = "Z轴找不到传感器",
    },
    syringeMoveOutSensorFail =--
    {
        level = "Error",
        type = "仪器故障",
        name = "注射器移不出传感器",
    },
    syringeMoveInSensorFail =--
    {
        level = "Error",
        type = "仪器故障",
        name = "注射器找不到传感器",
    },
    motorDriverError =--
    {
        level = "Error",
        type = "仪器故障",
        name = "电机驱动错误",
    },
    motorStop =--
    {
        level = "Warning", --只输出日志
        type = "仪器故障",
        name = "电机运动停止",
    },
}

return setting.alarm
