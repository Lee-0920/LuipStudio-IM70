setting.ui.operation.hardwareTest =
{
    name ="hardwareTest",
    text= "硬件测试",
    rowCount = 59,
    writePrivilege=  RoleType.Administrator,
    readPrivilege = RoleType.Administrator,
    superRow = 0,
    administratorRow = 59,
    {
        name = "PumpGroup",
        text = "泵组",
        {
            name ="MeterPump",
            text= "水样泵",
            createFlow= function(action)
                -- print("MeterPump", action)
                return HardwareTest:execute(44, action)
            end,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
        },
        {
            name ="ReagentPump",
            text= "试剂泵",
            createFlow= function(action)
                -- print("MeterPump", action)
                return HardwareTest:execute(45, action)
            end,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
        },
        {
            name ="CoolerPump",
            text= "冷却液泵",
            createFlow= function(action)
                -- print("MeterPump", action)
                return HardwareTest:execute(46, action)
            end,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
        },
        {
            name ="SliderPump",
            text= "进样电机",
            createFlow= function(action)
                -- print("MeterPump", action)
                return HardwareTest:execute(33, action)
            end,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
        },
        {
            name ="SupplyPump",
            text= "供样泵",
            createFlow= function(action)
                -- print("MeterPump", action)
                return HardwareTest:execute(48, action)
            end,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
        },
        {
            name ="SyringPump",
            text= "注射泵",
            createFlow= function(action)
                -- print("MeterPump", action)
                return HardwareTest:execute(34, action)
            end,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
        },
        {
            name ="StirPump",
            text= "均质器",
            createFlow= function(action)
                -- print("MeterPump", action)
                return HardwareTest:execute(59, action)
            end,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
        },
        {
            name ="AirPump",
            text= "真空泵",
            createFlow= function(action)
                -- print("MeterPump", action)
                return HardwareTest:execute(60, action)
            end,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
        },
    },
    {
        name = "ExPumpGroup",
        text = "扩展泵组",
        {
            name ="ExPump1",
            text= "扩展泵1",
            createFlow= function(action)
                -- print("MeterPump", action)
                return HardwareTest:execute(65, action)
            end,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
        },
        {
            name ="ExPump2",
            text= "扩展泵2",
            createFlow= function(action)
                -- print("MeterPump", action)
                return HardwareTest:execute(66, action)
            end,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
        },
        {
            name ="ExPump3",
            text= "扩展泵3",
            createFlow= function(action)
                -- print("MeterPump", action)
                return HardwareTest:execute(67, action)
            end,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
        },
        {
            name ="ExPump4",
            text= "扩展泵4",
            createFlow= function(action)
                -- print("MeterPump", action)
                return HardwareTest:execute(68, action)
            end,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
        },
        {
            name ="ExPump5",
            text= "扩展泵5",
            createFlow= function(action)
                -- print("MeterPump", action)
                return HardwareTest:execute(69, action)
            end,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
        },
        {
            name ="ExPump6",
            text= "扩展泵6",
            createFlow= function(action)
                -- print("MeterPump", action)
                return HardwareTest:execute(70, action)
            end,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
        },
        {
            name ="ExPump7",
            text= "扩展泵7",
            createFlow= function(action)
                -- print("MeterPump", action)
                return HardwareTest:execute(71, action)
            end,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
        },
        {
            name ="ExPump8",
            text= "扩展泵8",
            createFlow= function(action)
                -- print("MeterPump", action)
                return HardwareTest:execute(72, action)
            end,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
        },
        {
            name ="ExPump9",
            text= "扩展泵9",
            createFlow= function(action)
                -- print("MeterPump", action)
                return HardwareTest:execute(73, action)
            end,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
        },
        {
            name ="ExPump10",
            text= "扩展泵10",
            createFlow= function(action)
                -- print("MeterPump", action)
                return HardwareTest:execute(74, action)
            end,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
        },
        {
            name ="ExPump11",
            text= "扩展泵11",
            createFlow= function(action)
                -- print("MeterPump", action)
                return HardwareTest:execute(75, action)
            end,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
        },
        {
            name ="ExPump12",
            text= "扩展泵12",
            createFlow= function(action)
                -- print("MeterPump", action)
                return HardwareTest:execute(76, action)
            end,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
        },
    },
    {
        name = "ValveGroup",
        text = "阀组",
        {
            name ="SampleValve",
            text= "通道一阀",
            createFlow= function(action)
                -- print("SampleValve", action)
                return HardwareTest:execute(49, action)
            end,
            writePrivilege = RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
            targetPrivilege = Target.ChannelOne,
        },
        {
            name ="SampleValve",
            text= "通道二阀",
            createFlow= function(action)
                -- print("SampleValve", action)
                return HardwareTest:execute(50, action)
            end,
            writePrivilege = RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
            targetPrivilege = Target.ChannelTwo,
        },
        {
            name ="SampleValve",
            text= "通道三阀",
            createFlow= function(action)
                -- print("SampleValve", action)
                return HardwareTest:execute(51, action)
            end,
            writePrivilege = RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
            targetPrivilege = Target.ChannelThree,
        },
        {
            name ="SampleValve",
            text= "通道四阀",
            createFlow= function(action)
                -- print("SampleValve", action)
                return HardwareTest:execute(52, action)
            end,
            writePrivilege = RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
            targetPrivilege = Target.ChannelFour,
        },
        {
            name ="SampleValve",
            text= "通道五阀",
            createFlow= function(action)
                -- print("SampleValve", action)
                return HardwareTest:execute(53, action)
            end,
            writePrivilege = RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
            targetPrivilege = Target.ChannelFive,
        },
        {
            name ="SampleValve",
            text= "通道六阀",
            createFlow= function(action)
                -- print("SampleValve", action)
                return HardwareTest:execute(54, action)
            end,
            writePrivilege = RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
            targetPrivilege = Target.ChannelSix,
        },
        {
            name ="reagent1Valve",
            text= "试剂一阀",
            createFlow= function(action)
                --print("reagent1Valve", action)
                return HardwareTest:execute(3, action)
            end,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
        },
        {
            name ="BlankValve",
            text= "零点校准液阀",
            createFlow= function(action)
                -- print("BlankValve", action)
                return HardwareTest:execute(42, action)
            end,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
        },
        {
            name ="WasteValve",
            text= "水样杯废液阀",
            createFlow= function(action)
                --print("WasteValve", action)
                return HardwareTest:execute(10, action)
            end,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
        },
        {
            name ="WasteExposure",
            text= "曝气池废液阀",
            createFlow= function(action)
                --print("WasteValve", action)
                return HardwareTest:execute(61, action)
            end,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
        },
        {
            name ="WasteDilute",
            text= "稀释杯废液阀",
            createFlow= function(action)
                --print("WasteValve", action)
                return HardwareTest:execute(62, action)
            end,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
        },
        {
            name ="RefrigeratorWaterValve",
            text= "冷凝水阀1",
            createFlow= function(action)
                --print("DigestRoomUpValve", action)
                return HardwareTest:execute(63, action)
            end,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
        },
        {
            name ="RefrigeratorWaterValve",
            text= "冷凝水阀2",
            createFlow= function(action)
                --print("DigestRoomUpValve", action)
                return HardwareTest:execute(64, action)
            end,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
        },
        {
            name ="ProportionalValve1",
            text= "曝气比例阀",
            createFlow= function(action)
                --print("DigestRoomBottomValve", action)
                return HardwareTest:execute(27, action)
            end,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
        },
        {
            name ="ProportionalValve2",
            text= "载气比例阀",
            createFlow= function(action)
                --print("DigestRoomBottomValve", action)
                return HardwareTest:execute(28, action)
            end,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
        },
        {
            name ="NirtrogenValve",
            text= "氮气阀",
            createFlow= function(action)
                return HardwareTest:execute(30, action)
            end,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
        },
        {
            name ="NirtrogenValve",
            text= "气体置换阀",
            createFlow= function(action)
                return HardwareTest:execute(55, action)
            end,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
        },
        {
            name ="NirtrogenValve",
            text= "稀释杯气阀",
            createFlow= function(action)
                return HardwareTest:execute(56, action)
            end,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
        },
        {
            name ="NirtrogenValve",
            text= "曝气池气阀",
            createFlow= function(action)
                return HardwareTest:execute(57, action)
            end,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
        },
        {
            name ="NirtrogenValve",
            text= "水样杯气阀",
            createFlow= function(action)
                return HardwareTest:execute(58, action)
            end,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
        },
    },
    {
        name = "ExValveGroup",
        text = "扩展搅拌电机",
        {
            name ="ExValve1",
            text= "搅拌电机1",
            createFlow= function(action)
                return HardwareTest:execute(77, action)
            end,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
        },
        {
            name ="ExValve2",
            text= "搅拌电机2",
            createFlow= function(action)
                return HardwareTest:execute(78, action)
            end,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
        },
        {
            name ="ExValve3",
            text= "搅拌电机3",
            createFlow= function(action)
                return HardwareTest:execute(79, action)
            end,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
        },
        {
            name ="ExValve4",
            text= "搅拌电机4",
            createFlow= function(action)
                return HardwareTest:execute(80, action)
            end,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
        },
        {
            name ="ExValve5",
            text= "搅拌电机5",
            createFlow= function(action)
                return HardwareTest:execute(81, action)
            end,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
        },
        {
            name ="ExValve6",
            text= "搅拌电机6",
            createFlow= function(action)
                return HardwareTest:execute(82, action)
            end,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
        },
    },
    {
        name = "MeasurementModule",
        text = "测量模块",
        {
            name ="LMeasuerLED",
            text= "测量池LED1",
            createFlow= function(action)
                -- print("MeasuerLED", action)
                return HardwareTest:execute(16, action)
            end,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
        },
        {
            name ="SMeasuerLED",
            text= "测量池LED2",
            createFlow= function(action)
                -- print("MeasuerLED", action)
                return HardwareTest:execute(43, action)
            end,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
        },
    },
    {
        name = "MiningRelay",
        text = "继电器",
        {
            name ="CollectSampleRelay",
            text= "采水继电器",
            showCheck = true,
            createFlow= function(action)
                --  print("CollectSampleRelay", action)
                return HardwareTest:execute(19, action)
            end,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
        },
        {
            name ="Relay1",
            text= "继电器1",
            createFlow= function(action)
                -- print("Relay1", action)
                return HardwareTest:execute(20, action)
            end,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
        },
        {
            name ="Relay2",
            text= "继电器2",
            createFlow= function(action)
                -- print("Relay2", action)
                return HardwareTest:execute(21, action)
            end,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
        },
    },
    {
        name = "Sample4-20mA",
        text = "样品4-20mA",
        {
            name ="SampleCurrent4Output",
            text= "4mA输出",
            analogConfig = true,
            createFlow= function(action)
                --   print("SampleCurrent4Output", action)
                return HardwareTest:execute(22, action)
            end,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
        },
        {
            name ="SampleCurrent12Output",
            text= "12mA输出",
            analogConfig = true,
            createFlow= function(action)
                --  print("SampleCurrent12Output", action)
                return HardwareTest:execute(23, action)
            end,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
        },
        {
            name ="SampleCurrent20Output",
            text= "20mA输出",
            analogConfig = true,
            createFlow= function(action)
                --print("SampleCurrent20Output", action)
                return HardwareTest:execute(24, action)
            end,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
        },
    },
    {
        name = "TemperatureMonitoring",
        text = "温度监控",
        {
            name ="BoxUpFan",
            text= "预留风扇",
            createFlow= function(action)
                -- print("SystemFanTest", action)
                return HardwareTest:execute(39, action)
            end,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
        },
        {
            name ="BoxDownFan",
            text= "机箱风扇",
            createFlow= function(action)
                -- print("SystemFanTest", action)
                return HardwareTest:execute(25, action)
            end,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
        },
        {
            name ="StoveFan",
            text= "进样风扇",
            createFlow= function(action)
                -- print("SystemFanTest", action)
                return HardwareTest:execute(26, action)
            end,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
        },
    },
    {
        name = "ExposureNirtrogen",
        text = "气流模块",
        {
            name ="ExposureNirtrogen",
            text= "曝气",
            createFlow= function(action)
                -- print("SystemFanTest", action)
                return HardwareTest:execute(31, action)
            end,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
        },
        {
            name ="CarrierGas",
            text= "载气",
            createFlow= function(action)
                -- print("SystemFanTest", action)
                return HardwareTest:execute(32, action)
            end,
            writePrivilege=  RoleType.Administrator,
            readPrivilege = RoleType.Administrator,
        },
    },
    checkOEM = function()
        return config.system.OEM
    end,
    isShowCheck = function()
        return true
    end,
}
return setting.ui.operation.hardwareTest
