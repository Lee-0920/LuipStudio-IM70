config.system =
{
    screenSaver =
    {
        enable = true,              -- 是否开屏保
        darkTime = 300,	            -- 暗屏时间
        offTime = 600,	            -- 关屏时间
        loginKeepingTime = 600,		-- 用户退出时间
    },
    adcDetect =
    {
        --漏液检测
        {
            enable = false,
        },
        --测量触发
        {
            enable = false,
        },
    },
    language = 0,      -- 语言
    faultBlocking = false,   --故障停机
    displayProformaResult = false,  --预估结果显示
    faultRetry = true,     --异常重测
    reagentLackWarn = false,    -- 缺试剂告警
    dryFireProtection = true,                           -- 干烧保护
    drainDigestRoomCheck = true,                        --排液检查
    reagent2SpareValve = false,                        -- 试剂2不使用备用阀
    temperatureMonitor = false,   --环境温度监控
    environmentTemperature = 50,   --上机箱环境温度
    exEnvironmentTemperature = 38, --下机箱环境温度
    carryPressureOffset = true,   --压力补偿
    curveXYChange = false,         -- 曲线XY调换
    debugMode= false,			   -- 开发调试模式
    bridgeMode= false,			   -- 桥接模式
    bridgeIP= "192.168.2.1",	   -- 桥接IP
    modbusTableType = 0,              -- Modbus表类型
    CCEPMode = false,                                   -- CCEP认证模式
    solidifyMeaParamFromUI = false,                     -- 不可通过UI修改测量参数
    solidifyMeaParamFromModbus = false,                 -- 不可通过Modbus修改测量参数
    displayMeaParamInGeneral = false,                   -- 普通用户显示测量参数
    changeParamLog = false,                             -- 记录参数更改日志
    newDbsModbusLog = false,                             -- 地表水协议新日志
    useQrencode = false,                                 -- 二维码
    serverIP = "ins.watertestcloud.com",
    serverPort = 8800,
    serverMode = true,
    isConverMode = false,                               --TOC - COD转换模式
    sampleConverCurveK = 2.5,                                   --转换斜率
    sampleConverCurveB = 0,                                   --转换截距
    targetMap =
    {
        Check =
        {
            enable = true,
            num = _G.Target.Check,
        },
        ChannelOne =
        {
            enable = true,
            num = _G.Target.ChannelOne,
        },
        ChannelTwo =
        {
            enable = true,
            num = _G.Target.ChannelTwo,
        },
        ChannelThree =
        {
            enable = true,
            num = _G.Target.ChannelThree,
        },
        ChannelFour =
        {
            enable = true,
            num = _G.Target.ChannelFour,
        },
        ChannelFive =
        {
            enable = true,
            num = _G.Target.ChannelFive,
        },
        ChannelSix =
        {
            enable = true,
            num = _G.Target.ChannelSix,
        },
    },
    internationalSupported = false,                     -- 国际化支持
    standardRegister = false,                           -- 水样核查值更新
    rangeViewMap =                                      -- 量程显示映射
    {
        {
            range = _G.setting.measure.range[1].viewRange,  -- 量程
            view = _G.setting.measure.range[1].viewRange,   -- 界面显示量程
        },
        {
            range = _G.setting.measure.range[2].viewRange,  -- 量程
            view = _G.setting.measure.range[2].viewRange,   -- 界面显示量程
        },
        {
            range = _G.setting.measure.range[3].viewRange,  -- 量程
            view = _G.setting.measure.range[3].viewRange,   -- 界面显示量程
        },
        {
            range = _G.setting.measure.range[4].viewRange,  -- 量程
            view = _G.setting.measure.range[4].viewRange,   -- 界面显示量程
        },
        {
            range = _G.setting.measure.range[5].viewRange,  -- 量程
            view = _G.setting.measure.range[5].viewRange,   -- 界面显示量程
        },
    },
    printer =
    {
        enable = false,             --打印机功能
        address = "192.168.1.99",      --打印机地址
        autoPrint = false,          --自动打印
    },
    hj212Type = _G.HJ212Type.None,              --HJ212协议输出类型
    hj212DataType = _G.HJ212DataType.HourData,  --HJ212协议输出数据类型
    hj212Interval = 10,                         --间隔时间,单位:分钟
    st = "21",
    pw = "123456",
    mn = "A1010000_TCP01",
    nfsAddr = "192.168.0.218",
    nfsEnable = true,
    hj212Platform =
    {
        hj212DataType = 0,
        status = false,                  --连接平台
        address = "127.0.0.1",          --212平台IP
        port = "11110",                 --212平台端口
        mn = "A20800000_TCP30",         --编码
        pw = "123456",                  --密码
        st = "21",						-- 编码
        respond = false,                --应答
        heartPackTime = 5,              --心跳间隔(单位分钟，<=0表示不发)
        overtime = 3,                   --超时时间(单位分钟)
        recount = 3,                    --重传次数

        hj212CommunicationMode = 0,		-- 0:232 1:485 2:TCP
        hj212Type = 0,              	-- 0:None 1: 2017DBS 2: 2017WRY
    },
    decimalNum = _G.setting.measureResult.decimalNum,
    OEM = 0,
    weepingLimitValve = 70,
    channelFactor =
    {
        {
            curveK = 1,
            curveB = 0,
        },
        {
            curveK = 1,
            curveB = 0,
        },
        {
            curveK = 1,
            curveB = 0,
        },
        {
            curveK = 1,
            curveB = 0,
        },
        {
            curveK = 1,
            curveB = 0,
        },
        {
            curveK = 1,
            curveB = 0,
        },
        {
            curveK = 1,
            curveB = 0,
        },
    },
}
