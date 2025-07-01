setting.ui.signalIterms =
{
    rowCount = 10,
    {
        name = "AcquireAD",
        text = "测量管",
        {
            name = "lmea",
            text = "测量值1",
            unit = "V",
            format = "%.6f",
        },
        {
            name = "smea",
            text = "测量值2",
            unit = "V",
            format = "%.6f",
        },
    },
    {
        name = "DigestRoom ",
        text = "燃烧炉",
        {
            name = "tTemp",
            text = "燃烧炉温度",
            unit = "℃",
            format = "%.1f",
        },
    },
    {
        name = "Refrigerator",
        text = "制冷器",
        {
            name = "cTemp",
            text = "制冷温度",
            unit = "℃",
            format = "%.1f",
        },
    },
    {
        name = "MeasureModule",
        text = "测量模块",
        {
            name = "LMeaTemp",
            text = "测量池1",
            unit = "℃",
            format = "%.1f",
        },
        {
            name = "SMeaTemp",
            text = "测量池2",
            unit = "℃",
            format = "%.1f",
        },
    },
    {
        name = "Instrument",
        text = "仪器",
        {
            name = "upTemp",
            text = "机箱温度",
            unit = "℃",
            format = "%.1f",
        },
    },
    {
        name = "PressureSensor",
        text = "压力传感器",
        {
            name = "pSensor1",
            text = "总阀压力",
            unit = "kPa",
            format = "%.2f",
        },
        {
            name = "pSensor2",
            text = "曝气压力",
            unit = "kPa",
            format = "%.2f",
        },
        {
            name = "pSensor3",
            text = "载气压力",
            unit = "kPa",
            format = "%.2f",
        },
    },
    --{
    --    name = "TempCalibration",
    --    text = "校准AD值",
    --    showAD = false,
    --    {
    --        name = "eTempCheck",
    --        text = "燃烧炉AD值",
    --        unit = " ",
    --        format = "%.0f",
    --    },
    --},
}

return setting.ui.signalIterms
