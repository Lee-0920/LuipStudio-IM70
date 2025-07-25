config.hardwareConfig =
{
    meterPoint =
    {
        num = 2,--定量点数量
        point =
        {
            {
                setVolume = 0.5, --定量点1设定的定量值
                realVolume = 0.5, --定量点1实际的定量值
            },
            {
                setVolume = 2, --定量点2设定的定量值
                realVolume = 2, -- 定量点2实际的定量值
            },
        },
    },
    thermostatParam =
    {
        proportion =
        {
            set = 70,
            real = 70,
        },
        integration =
        {
            set = 0.2,
            real = 0.2,
        },
        differential =
        {
            set = 80,
            real = 80,
        },
    },
    thermostatParamNDIR =
    {
        proportion =
        {
            set = 90,
            real = 90,
        },
        integration =
        {
            set = 0.71,
            real = 0.71,
        },
        differential =
        {
            set = 80,
            real = 80,
        },
    },
    thermostatParamCooler =
    {
        proportion =
        {
            set = 90,
            real = 90,
        },
        integration =
        {
            set = 0.71,
            real = 0.71,
        },
        differential =
        {
            set = 80,
            real = 80,
        },
    },
    pumpFactor =
    {
        0.002,
        0.002,
        0.002,
        0.00125,
        0.002,
        0.002,
        1,
        1,
        0.002,
    },
    syringMaxAcceleration = 35,
    tempCalibrate =
    {
        negativeInput = 1.488,
        referenceVoltage = 2.48,
        calibrationVoltage = 0,
    },
    NDIRTempCalibrate =
    {
        negativeInput = 1.507,
        referenceVoltage = 2.48,
        calibrationVoltage = 0,
    },
    LMeaNDIRTempCalibrate =
    {
        negativeInput = 1.507,
        referenceVoltage = 2.48,
        calibrationVoltage = 0,
    },
    SMeaNDIRTempCalibrate =
    {
        negativeInput = 1.507,
        referenceVoltage = 2.48,
        calibrationVoltage = 0,
    },
    stoveTempCalibrate =
    {
        negativeInput = 1.507,
        referenceVoltage = 2.48,
        calibrationVoltage = 0,
    },
    fanUpTempCalibrate =
    {
        negativeInput = 1.494,
        referenceVoltage = 2.48,
        calibrationVoltage = 0,
    },
    fanDownTempCalibrate =
    {
        negativeInput = 1.734,
        referenceVoltage = 3.452,
        calibrationVoltage = 0,
    },
    twoPointTempCalibrate =
    {
        firstTemp = 0,
        firstTempAD = 0,
        secondTemp = 0,
        secondTempAD = 0,
    },
    meterLed =
    {
        num = 2,
        point =
        {
            {
                set = 3,
                real = 3,
            },
            {
                set = 3,
                real = 3,
            }
        }
    },
    measureLed =
    {
        period =
        {
            {
                set = 200,
                real = 200,
            },
            {
                set = 200,
                real = 200,
            },
        },
    },
    motorOffsetStep =
    {
        offsetStep =
        {
            set = 0,
            real = 0,
        },
    },
    motorParam =
    {
        motorX =
        {
            speed = 1500,
            acceleration = 1500,
        },
        motorZ =
        {
            speed = 600,
            acceleration = 600,
        },
    },
    motorParam =
    {
        motorX =
        {
            speed = 800,
            acceleration = 800,
        },
        motorZ =
        {
            speed = 800,
            acceleration = 800,
        },
    },
    backupSign = false, --激活备份标志位
    backupParam =
    {
        pumpMeter = 0.0015,
        pumpSyring = 0.0005,
        CoolerTempCalibrate =
        {
            negativeInput = 1.488,
            referenceVoltage = 2.48,
            calibrationVoltage = 0,
        },
        NDIRTempCalibrate =
        {
            negativeInput = 1.507,
            referenceVoltage = 2.48,
            calibrationVoltage = 0,
        },
        NDIRTemp2Calibrate =
        {
            negativeInput = 1.507,
            referenceVoltage = 2.48,
            calibrationVoltage = 0,
        },
        fanUpTempCalibrate =
        {
            negativeInput = 1.494,
            referenceVoltage = 2.48,
            calibrationVoltage = 0,
        },
        fanDownTempCalibrate =
        {
            negativeInput = 1.734,
            referenceVoltage = 3.452,
            calibrationVoltage = 0,
        },
        stoveTempCalibrate =
        {
            negativeInput = 4.16,
            referenceVoltage = 107,
            calibrationVoltage = 53.0,
        },
    }
}
