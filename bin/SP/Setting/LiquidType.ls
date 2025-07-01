setting.liquidType = {}

setting.liquidType.map =
{
    valve1 = 1,
    valve2 = 2,
    valve3 = 4,
    valve4 = 8,
    valve5 = 16,
    valve6 = 32,
    valve7 = 64,
    valve8 = 128,
    valve9 = 256,
    valve10= 512,
    valve11= 1024,
    valve12= 2048,
    valve13= 4096,
    valve14= 8192,
    valve15= 16384,
    valve16= 32768,
    valve17= 65536,
    valve18= 131072,
    valve19= 262144,
    valve20= 524288,
    valve21= 1048576,
    valve22= 2097152,
}

--无任何阀
setting.liquidType.none =
{
    name = "None",
    pump = 0,
    valve = 0,
    ex = false,
}

--总阀
setting.liquidType.master =
{
    name = "Master",
    pump = 0,
    valve = setting.liquidType.map.valve12,
    ex = false,
}

--水样
setting.liquidType.sample =
{
    name = "Sample",
    pump = 0,
    valve = setting.liquidType.map.valve1
            + setting.liquidType.master.valve,
    ex = false,
}

--水样1
setting.liquidType.sample1 =
{
    name = "Sample1",
    pump = 0,
    valve = setting.liquidType.map.valve1
            + setting.liquidType.master.valve,
    ex = false,
}

--水样2
setting.liquidType.sample2 =
{
    name = "Sample2",
    pump = 0,
    valve = setting.liquidType.map.valve2
            + setting.liquidType.master.valve,
    ex = false,
}

--水样3
setting.liquidType.sample3 =
{
    name = "Sample3",
    pump = 0,
    valve = setting.liquidType.map.valve3
            + setting.liquidType.master.valve,
    ex = false,
}

--水样4
setting.liquidType.sample4 =
{
    name = "Sample4",
    pump = 0,
    valve = setting.liquidType.map.valve4
            + setting.liquidType.master.valve,
    ex = false,
}

--水样5
setting.liquidType.sample5 =
{
    name = "Sample5",
    pump = 0,
    valve = setting.liquidType.map.valve5
            + setting.liquidType.master.valve,
    ex = false,
}

--水样6
setting.liquidType.sample6 =
{
    name = "Sample6",
    pump = 0,
    valve = setting.liquidType.map.valve6
            + setting.liquidType.master.valve,
    ex = false,
}

--量程校准液
setting.liquidType.standard =
{
    name = "Standard",
    pump = 8,
    valve = setting.liquidType.master.valve,
    ex = false,
}

--零点校准液
setting.liquidType.blank =
{
    name = "Blank",
    pump = 0,
    valve = setting.liquidType.map.valve3
            + setting.liquidType.master.valve,
    ex = false,
}

--量程核查液
setting.liquidType.rangeCheck =
{
    name = "RangeCheck",
    pump = 0,
    valve = setting.liquidType.map.valve1
            + setting.liquidType.master.valve,
    ex = false,
}

--零点核查液
setting.liquidType.zeroCheck =
{
    name = "ZeroCheck",
    pump = 0,
    valve = setting.liquidType.map.valve14
            + setting.liquidType.master.valve,
    ex = false,
}

--废水
setting.liquidType.wasteWater =
{
    name = "WasteWater",
    pump = 0,
    valve = setting.liquidType.map.valve7
            + setting.liquidType.master.valve,
    ex = false,
}

--水样杯废液
setting.liquidType.wasteSample =
{
    name = "WasteSample",
    pump = 0,
    valve = setting.liquidType.map.valve7
            + setting.liquidType.master.valve,
    ex = false,
}

--曝气池废液
setting.liquidType.wasteExposure =
{
    name = "WasteExposure",
    pump = 2,
    valve = setting.liquidType.map.valve7
            + setting.liquidType.map.valve19
            + setting.liquidType.master.valve,
    ex = false,
}

--稀释杯废液
setting.liquidType.wasteDilute =
{
    name = "WasteDilute",
    pump = 2,
    valve = setting.liquidType.map.valve18
            + setting.liquidType.master.valve,
    ex = false,
}

--试剂1
setting.liquidType.reagent1 =
{
    name = "Reagent1",
    pump = 1,
    valve = setting.liquidType.map.valve13
            + setting.liquidType.master.valve,
    ex = false,
}

--试剂1至水样杯
setting.liquidType.reagent1ToMixer =
{
    name = "Reagent1ToMixer",
    pump = 1,
    valve = setting.liquidType.master.valve,
    ex = false,
}

--试剂1至曝气池
setting.liquidType.reagent1ToExposure =
{
    name = "Reagent1ToExposure",
    pump = 1,
    valve = setting.liquidType.map.valve13
            + setting.liquidType.master.valve,
    ex = false,
}

--曝气池曝气
setting.liquidType.exposureIC =
{
    name = "ExposureIC",
    pump = 0,
    valve = setting.liquidType.master.valve
            + setting.liquidType.map.valve10,
    ex = false,
}

--水样杯曝气
setting.liquidType.exposureSampleMixer =
{
    name = "exposureSampleMixer",
    pump = 0,
    valve = setting.liquidType.master.valve
            + setting.liquidType.map.valve11,
    ex = false,
}

--稀释杯曝气
setting.liquidType.exposureDilute =
{
    name = "ExposureDilute",
    pump = 0,
    valve = setting.liquidType.master.valve
            + setting.liquidType.map.valve9,
    ex = false,
}

--测量灯换气阀
setting.liquidType.airLED =
{
    name = "AirLED",
    pump = 0,
    valve = setting.liquidType.master.valve
            + setting.liquidType.map.valve8,
    ex = false,
}

--进样
setting.liquidType.sliders =
{
    name = "Sliders",
    pump = 4,
    valve = setting.liquidType.master.valve,
    ex = false,
}

--气密性检查阀
setting.liquidType.gas =
{
    name = "Gas",
    pump = 0,
    valve = 0,
    ex = false,
}

--卤素液
setting.liquidType.halogenBottleWater =
{
    name = "HalogenBottleWater",
    pump = 0,
    valve = setting.liquidType.master.valve,
    ex = false,
}

--冷凝水
setting.liquidType.coolerWater =
{
    name = "CoolerWater",
    pump = 2,
    valve = setting.liquidType.map.valve7
            + setting.liquidType.map.valve16
            + setting.liquidType.master.valve,
    ex = false,

}

--冷凝水
setting.liquidType.coolerWaterIC =
{
    name = "CoolerWaterIC",
    pump = 2,
    valve = setting.liquidType.map.valve7
            + setting.liquidType.map.valve17
            + setting.liquidType.master.valve,
    ex = false,

}

--注射器废液
setting.liquidType.syringeNone =
{
    name = "SyringeWaste",
    pump = 3,
    valve = setting.liquidType.map.valve7
            + setting.liquidType.master.valve,
    ex = false,

}

--注射器空白水
setting.liquidType.syringeBlank =
{
    name = "SyringeBlank",
    pump = 3,
    valve = setting.liquidType.map.valve7
            +setting.liquidType.map.valve14
            +setting.liquidType.master.valve,
    ex = false,

}

--注射器空气
setting.liquidType.airReagent =
{
    name = "AirReagent",
    pump = 0,
    valve = 0,
    ex = false,
}

--扩展泵1
setting.liquidType.exSampleIn1 =
{
    name = "ExSampleIn1",
    pump = 16,--扩展泵偏移16 index = 0
    valve = setting.liquidType.map.valve1,
    ex = true,
}

--扩展泵2
setting.liquidType.exSampleIn2 =
{
    name = "ExSampleIn2",
    pump = 17,--扩展泵偏移16 index = 1
    valve = setting.liquidType.map.valve2,
    ex = true,
}

--扩展泵3
setting.liquidType.exSampleIn3 =
{
    name = "ExSampleIn3",
    pump = 18,--扩展泵偏移16 index = 2
    valve = setting.liquidType.map.valve3,
    ex = true,
}

--扩展泵4
setting.liquidType.exSampleIn4 =
{
    name = "ExSampleIn4",
    pump = 19,--扩展泵偏移16 index = 3
    valve = setting.liquidType.map.valve4,
    ex = true,
}

--扩展泵5
setting.liquidType.exSampleIn5 =
{
    name = "ExSampleIn5",
    pump = 20,--扩展泵偏移16 index = 4
    valve = setting.liquidType.map.valve5,
    ex = true,
}

--扩展泵6
setting.liquidType.exSampleIn6 =
{
    name = "ExSampleIn6",
    pump = 21,--扩展泵偏移16 index = 5
    valve = setting.liquidType.map.valve6,
    ex = true,
}

--扩展泵7
setting.liquidType.exSampleOut1 =
{
    name = "ExSampleOut1",
    pump = 22,--扩展泵偏移16 index = 0
    valve = 0,
    ex = true,
}

--扩展泵2
setting.liquidType.exSampleOut2 =
{
    name = "ExSampleOut2",
    pump = 23,--扩展泵偏移16 index = 1
    valve = 0,
    ex = true,
}

--扩展泵3
setting.liquidType.exSampleOut3 =
{
    name = "ExSampleOut3",
    pump = 24,--扩展泵偏移16 index = 2
    valve = 0,
    ex = true,
}

--扩展泵4
setting.liquidType.exSampleOut4 =
{
    name = "ExSampleOut4",
    pump = 25,--扩展泵偏移16 index = 3
    valve = 0,
    ex = true,
}

--扩展泵5
setting.liquidType.exSampleOut5 =
{
    name = "ExSampleOut2",
    pump = 26,--扩展泵偏移16 index = 4
    valve = 0,
    ex = true,
}

--扩展泵6
setting.liquidType.exSampleOut6 =
{
    name = "ExSampleOut6",
    pump = 27,--扩展泵偏移16 index = 5
    valve = 0,
    ex = true,
}

return setting.liquidType
