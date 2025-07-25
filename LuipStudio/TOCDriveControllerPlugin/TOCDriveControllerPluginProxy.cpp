#include "API/MeterPoints.h"
#include "API/OpticalMeterInterface.h"
#include "API/PeristalticPumpInterface.h"
#include "API/SolenoidValveInterface.h"
#include "TOCDriveController.h"
#include "Communication/CommunicationProxy.h"
#include "ControllerPlugin/ControllerPluginProxy.h"
#include "LuaEngine/LuaEngine.h"
#include "TOCDriveControllerPluginProxy.h"
#include "API/TemperatureControlInterface.h"
#include "API/OpticalAcquireInterface.h"
#include "API/ExtTemperatureControlInterface.h"
#include "API/ExtOpticalAcquireInterface.h"
#include "API/MotorControlInterface.h"

using Communication::Dscp::DscpAddress;
using namespace Controller;
using namespace Controller::API;
using namespace OOLUA;
using namespace Lua;

/**
 * @brief 光学定量点体积。
 * @details
 */
OOLUA_PROXY(,MeterPoint)
    OOLUA_MGET_MSET(setVolume, GetSetVolume, SetSetVolume)
    OOLUA_MGET_MSET(realVolume, GetRealVolume, SetRealVolume)
OOLUA_PROXY_END
OOLUA_EXPORT_FUNCTIONS(MeterPoint, SetSetVolume, SetRealVolume)
OOLUA_EXPORT_FUNCTIONS_CONST(MeterPoint, GetSetVolume, GetRealVolume)

/**
 * @brief 光学定量点。
 * @details
 */
OOLUA_PROXY(,MeterPoints)
    OOLUA_CTORS(
        OOLUA_CTOR(int)
    )
    OOLUA_TAGS(
        Equal_op
    )
    OOLUA_MFUNC(SetNum)
    OOLUA_MFUNC(GetNum)
    OOLUA_MFUNC(SetPoint)
    OOLUA_MFUNC(GetPoint)

OOLUA_PROXY_END
OOLUA_EXPORT_FUNCTIONS(MeterPoints, SetNum, GetNum, SetPoint, GetPoint)
OOLUA_EXPORT_FUNCTIONS_CONST(MeterPoints)

/**
 * @brief 蠕动泵运动参数。
 * @details
 */
OOLUA_PROXY(,MotionParam)
    OOLUA_MGET_MSET(acceleration, GetAcceleration, SetAcceleration)
    OOLUA_MGET_MSET(speed, GetSpeed, SetSpeed)
OOLUA_PROXY_END
OOLUA_EXPORT_FUNCTIONS(MotionParam, SetAcceleration, SetSpeed)
OOLUA_EXPORT_FUNCTIONS_CONST(MotionParam, GetAcceleration, GetSpeed)

/**
 * @brief 步进电机运动参数。
 * @details
 */
OOLUA_PROXY(,MotorParam)
    OOLUA_MGET_MSET(acceleration, GetAcceleration, SetAcceleration)
    OOLUA_MGET_MSET(speed, GetSpeed, SetSpeed)
OOLUA_PROXY_END
OOLUA_EXPORT_FUNCTIONS(MotorParam, SetAcceleration, SetSpeed)
OOLUA_EXPORT_FUNCTIONS_CONST(MotorParam, GetAcceleration, GetSpeed)

/**
 * @brief 电机状态。
 * @details
 */
OOLUA_PROXY(,MotorStatus)
    OOLUA_TAGS(
        Register_class_enums  // 枚举需要特别标注，否则枚举值无效
    )
    OOLUA_ENUMS(
        OOLUA_ENUM(Idle)   // 枚举值
        OOLUA_ENUM(Failed)   // 枚举值
        OOLUA_ENUM(Busy)   // 枚举值
    )
OOLUA_PROXY_END
OOLUA_EXPORT_NO_FUNCTIONS(MotorStatus)  // 导出函数声明（没有函数也需要声明）

/**
 * @brief 电机运动方向。
 * @details
 */
OOLUA_PROXY(,MotorDirection)
    OOLUA_TAGS(
        Register_class_enums  // 枚举需要特别标注，否则枚举值无效
    )
    OOLUA_ENUMS(
        OOLUA_ENUM(Front)   // 枚举值
        OOLUA_ENUM(Back)   // 枚举值
    )
OOLUA_PROXY_END
OOLUA_EXPORT_NO_FUNCTIONS(MotorDirection)  // 导出函数声明（没有函数也需要声明）

/**
 * @brief 电机操作结果码。
 * @details
 */
OOLUA_PROXY(,MotorOperateResult)
    OOLUA_TAGS(
        Register_class_enums  // 枚举需要特别标注，否则枚举值无效
    )
    OOLUA_ENUMS(
        OOLUA_ENUM(Finished)   // 枚举值
        OOLUA_ENUM(Failed)   // 枚举值
        OOLUA_ENUM(Stopped)   // 枚举值
        OOLUA_ENUM(Collsion_0)   // 枚举值
        OOLUA_ENUM(Collsion_1)   // 枚举值
        OOLUA_ENUM(MoveOutSensorFail_X)   // 枚举值
        OOLUA_ENUM(MoveOutSensorFail_Z)   // 枚举值
        OOLUA_ENUM(MoveInSensorFail_X)   // 枚举值
        OOLUA_ENUM(MoveInSensorFail_Z)   // 枚举值
        OOLUA_ENUM(MoveOutSensorFail_SYR)   // 枚举值
        OOLUA_ENUM(MoveInSensorFail_SYR)   // 枚举值
        OOLUA_ENUM(DriverError)   // 枚举值
    )
OOLUA_PROXY_END
OOLUA_EXPORT_NO_FUNCTIONS(MotorOperateResult)  // 导出函数声明（没有函数也需要声明）

/**
 * @brief 电机运动模式
 * @details
 */
/**
 * @brief 电机运动模式
 * @details
 */
OOLUA_PROXY(,MotorMoveMode)
    OOLUA_TAGS(
        Register_class_enums
    )
    OOLUA_ENUMS(
        OOLUA_ENUM(Absolute)    ///绝对模式
        OOLUA_ENUM(Relative)    ///相对模式
        OOLUA_ENUM(Safe)        ///安全模式
    )
OOLUA_PROXY_END
OOLUA_EXPORT_NO_FUNCTIONS(MotorMoveMode)

/**
 * @brief 电机操作结果。
 * @details
 */
OOLUA_PROXY(,MotorResult)
    OOLUA_MGET_MSET(index, GetIndex, SetIndex)
    OOLUA_MGET_MSET(result, GetResult, SetResult)
OOLUA_PROXY_END
OOLUA_EXPORT_FUNCTIONS(MotorResult, SetIndex, SetResult)
OOLUA_EXPORT_FUNCTIONS_CONST(MotorResult, GetIndex, GetResult)

/**
 * @brief 电机三维坐标XYZ
 * @details
 */
OOLUA_PROXY(,Motor3DPos)
    OOLUA_MGET_MSET(xpos, GetXPos, SetXPos)
    OOLUA_MGET_MSET(ypos, GetYPos, SetYPos)
    OOLUA_MGET_MSET(zpos, GetZPos, SetZPos)
OOLUA_PROXY_END
OOLUA_EXPORT_FUNCTIONS(Motor3DPos, SetXPos, SetYPos, SetZPos)
OOLUA_EXPORT_FUNCTIONS_CONST(Motor3DPos, GetXPos, GetYPos, GetZPos)

/**
 * @brief 蠕动泵状态。
 * @details
 */
OOLUA_PROXY(,PumpStatus)
    OOLUA_TAGS(
        Register_class_enums  // 枚举需要特别标注，否则枚举值无效
    )
    OOLUA_ENUMS(
        OOLUA_ENUM(Idle)   // 枚举值
        OOLUA_ENUM(Failed)   // 枚举值
        OOLUA_ENUM(Busy)   // 枚举值
    )
OOLUA_PROXY_END
OOLUA_EXPORT_NO_FUNCTIONS(PumpStatus)  // 导出函数声明（没有函数也需要声明）

/**
 * @brief 蠕动泵旋转方向。
 * @details
 */
OOLUA_PROXY(,RollDirection)
    OOLUA_TAGS(
        Register_class_enums  // 枚举需要特别标注，否则枚举值无效
    )
    OOLUA_ENUMS(
        OOLUA_ENUM(Suck)   // 枚举值
        OOLUA_ENUM(Drain)   // 枚举值
    )
OOLUA_PROXY_END
OOLUA_EXPORT_NO_FUNCTIONS(RollDirection)  // 导出函数声明（没有函数也需要声明）

/**
 * @brief 蠕动泵操作结果码。
 * @details
 */
OOLUA_PROXY(,PumpOperateResult)
    OOLUA_TAGS(
        Register_class_enums  // 枚举需要特别标注，否则枚举值无效
    )
    OOLUA_ENUMS(
        OOLUA_ENUM(Finished)   // 枚举值
        OOLUA_ENUM(Failed)   // 枚举值
        OOLUA_ENUM(Stopped)   // 枚举值
    )
OOLUA_PROXY_END
OOLUA_EXPORT_NO_FUNCTIONS(PumpOperateResult)  // 导出函数声明（没有函数也需要声明）

/**
 * @brief 蠕动泵结果。
 * @details
 */
OOLUA_PROXY(,PumpResult)
    OOLUA_MGET_MSET(index, GetIndex, SetIndex)
    OOLUA_MGET_MSET(result, GetResult, SetResult)
OOLUA_PROXY_END
OOLUA_EXPORT_FUNCTIONS(PumpResult, SetIndex, SetResult)
OOLUA_EXPORT_FUNCTIONS_CONST(PumpResult, GetIndex, GetResult)

/**
 * @brief 阀映射图。
 * @details
 */
OOLUA_PROXY(,ValveMap)

    OOLUA_CTORS(
        OOLUA_CTOR(unsigned long)
    )
    OOLUA_MFUNC(SetData)
    OOLUA_MFUNC(GetData)
    OOLUA_MFUNC(SetOn)
    OOLUA_MFUNC(SetOff)
    OOLUA_MFUNC(IsOn)
    OOLUA_MFUNC(clear)

OOLUA_PROXY_END
OOLUA_EXPORT_FUNCTIONS(ValveMap, SetData, GetData, SetOn, SetOff, IsOn, clear)
OOLUA_EXPORT_FUNCTIONS_CONST(ValveMap)

/**
 * @brief 光学定量模式。
 * @details
 */
OOLUA_PROXY(,MeterMode)
    OOLUA_TAGS(
        Register_class_enums  // 枚举需要特别标注，否则枚举值无效
    )
    OOLUA_ENUMS(
        OOLUA_ENUM(Accurate)  // 枚举值
        OOLUA_ENUM(Direct)    // 枚举值
        OOLUA_ENUM(Smart)     // 枚举值
        OOLUA_ENUM(Ropiness)  // 枚举值
        OOLUA_ENUM(Layered)  // 枚举值
    )
OOLUA_PROXY_END
OOLUA_EXPORT_NO_FUNCTIONS(MeterMode)  // 导出函数声明（没有函数也需要声明）

/**
 * @brief 定量操作结果。
 * @details
 */
OOLUA_PROXY(,MeterResult)
    OOLUA_TAGS(
        Register_class_enums  // 枚举需要特别标注，否则枚举值无效
    )
    OOLUA_ENUMS(
        OOLUA_ENUM(Finished)   // 枚举值
        OOLUA_ENUM(Failed)   // 枚举值
        OOLUA_ENUM(Stopped)   // 枚举值
        OOLUA_ENUM(Overflow)   // 枚举值
        OOLUA_ENUM(Unfinished)   // 枚举值
        OOLUA_ENUM(AirBubble)   // 枚举值
    )
OOLUA_PROXY_END
OOLUA_EXPORT_NO_FUNCTIONS(MeterResult)  // 导出函数声明（没有函数也需要声明）

/**
 * @brief 温度。
 * @details
 */
OOLUA_PROXY(,Temperature)
    OOLUA_MGET_MSET(thermostatTemp, GetThermostatTemp, SetThermostatTemp)      ///<  恒温室温度，单位为摄氏度
    OOLUA_MGET_MSET(environmentTemp, GetEnvironmentTemp, SetEnvironmentTemp)   ///<  环境温度，单位为摄氏度
OOLUA_PROXY_END
OOLUA_EXPORT_FUNCTIONS(Temperature, SetThermostatTemp, SetEnvironmentTemp)
OOLUA_EXPORT_FUNCTIONS_CONST(Temperature, GetThermostatTemp, GetEnvironmentTemp)

/**
 * @brief 温度控制参数。
 * @details
 */
OOLUA_PROXY(,ThermostatParam)
    OOLUA_MGET_MSET(proportion, GetProportion, SetProportion)          ///< PID的比例系数
    OOLUA_MGET_MSET(integration, GetIntegration, SetIntegration)       ///< PID的积分系数
    OOLUA_MGET_MSET(differential, GetDifferential, SetDifferential)    ///< PID的微分系数
OOLUA_PROXY_END
OOLUA_EXPORT_FUNCTIONS(ThermostatParam, SetProportion, SetIntegration, SetDifferential)
OOLUA_EXPORT_FUNCTIONS_CONST(ThermostatParam, GetProportion, GetIntegration, GetDifferential)

/**
 * @brief 温度校准参数。
 * @details
 */
OOLUA_PROXY(,TempCalibrateFactor)
    OOLUA_MGET_MSET(negativeInput, GetNegativeInput, SetNegativeInput)                 ///<负输入分压
    OOLUA_MGET_MSET(referenceVoltage, GetReferenceVoltage, SetReferenceVoltage)        ///<参考电压
    OOLUA_MGET_MSET(calibrationVoltage, GetCalibrationVoltage, SetCalibrationVoltage)  ///<校准电压
OOLUA_PROXY_END
OOLUA_EXPORT_FUNCTIONS(TempCalibrateFactor, SetNegativeInput, SetReferenceVoltage, SetCalibrationVoltage)
OOLUA_EXPORT_FUNCTIONS_CONST(TempCalibrateFactor, GetNegativeInput, GetReferenceVoltage, GetCalibrationVoltage)

/**
 * @brief 恒温模式。
 */
OOLUA_PROXY(,ThermostatMode)
    OOLUA_TAGS(
        Register_class_enums  ///< 枚举需要特别标注，否则枚举值无效
    )
    OOLUA_ENUMS(
    OOLUA_ENUM(Auto)            ///< 自动模式，根据需要及硬件能力综合使用加热器和制冷器。
    OOLUA_ENUM(Heater)          ///< 纯加热模式，不使用制冷器。
    OOLUA_ENUM(Refrigerate)     ///< 纯制冷模式，不使用加热器。
    OOLUA_ENUM(Natural)         ///< 自然模式，加热器和制冷器都不参与，靠环境传递热量，自然升温或冷却。
    )
OOLUA_PROXY_END
OOLUA_EXPORT_NO_FUNCTIONS(ThermostatMode)  ///< 导出函数声明（没有函数也需要声明）

/**
 * @brief 恒温操作结果。
 */
OOLUA_PROXY(,ThermostatOperateResult)
    OOLUA_TAGS(
        Register_class_enums  ///< 枚举需要特别标注，否则枚举值无效
    )
    OOLUA_ENUMS(
    OOLUA_ENUM(Reached)     ///< 恒温目标达成，目标温度在规定时间内达成，后续将继续保持恒温，直到用户停止。
    OOLUA_ENUM(Failed)      ///< 恒温中途出现故障，未能完成。
    OOLUA_ENUM(Stopped)     ///< 恒温被停止。
    OOLUA_ENUM(Timeout)     ///< 恒温超时，指定时间内仍未达到目标温度。
    )
OOLUA_PROXY_END
OOLUA_EXPORT_NO_FUNCTIONS(ThermostatOperateResult)  ///< 导出函数声明（没有函数也需要声明）

/**
 * @brief 恒温结果。
 * @details
 */
OOLUA_PROXY(,ThermostatResult)
    OOLUA_MGET_MSET(result, GetResult, SetResult)     ///< 恒温操作结果。
    OOLUA_MGET_MSET(temp, GetTemp, SetTemp)           ///< 当前温度。
    OOLUA_MGET_MSET(index, GetIndex, SetIndex)           ///< 当前恒温器索引
OOLUA_PROXY_END
OOLUA_EXPORT_FUNCTIONS(ThermostatResult, SetResult, SetTemp, SetIndex)
OOLUA_EXPORT_FUNCTIONS_CONST(ThermostatResult, GetResult, GetTemp, GetIndex)

/**
 * @brief 光学定量接口。
 * @details 定义了一序列光学定量相关的操作。
 */
OOLUA_PROXY(,OpticalMeterInterface, DeviceInterface)
    OOLUA_TAGS(
        No_default_constructor //没有默认构造函数时可以使用此标签
    )
    OOLUA_CTORS(
        OOLUA_CTOR(DscpAddress)
    )
    OOLUA_MFUNC(TurnOnLED)
    OOLUA_MFUNC(TurnOffLED)
    OOLUA_MFUNC_CONST(GetPumpFactor)
    OOLUA_MFUNC(SetPumpFactor)
    OOLUA_MFUNC_CONST(GetMeterPoints)
    OOLUA_MFUNC(SetMeterPoints)
    OOLUA_MFUNC_CONST(GetMeterStatus)
    OOLUA_MFUNC(StartMeter)
    OOLUA_MFUNC(StopMeter)
    OOLUA_MFUNC(IsAutoCloseValve)
    OOLUA_MFUNC(SetOpticalADNotifyPeriod)
    OOLUA_MFUNC(ExpectMeterResult)
    OOLUA_MFUNC(SetMeteSpeed)
    OOLUA_MFUNC_CONST(GetMeteSpeed)
    OOLUA_MFUNC(SetMeterFinishValveMap)
    OOLUA_MFUNC_CONST(GetSingleOpticalAD)
    OOLUA_MFUNC(SetRopinessMeterOverValue)
    OOLUA_MFUNC_CONST(GetRopinessMeterOverValue)
//    OOLUA_MEM_FUNC(void, RegisterOpticalADNotice, cpp_in_p<IEventReceivable*>)
    OOLUA_MFUNC(RegisterOpticalADNotice)
    OOLUA_MFUNC(SetMeterEndPointOverCount)
    OOLUA_MFUNC_CONST(GetMeterEndPointOverCount)

OOLUA_PROXY_END
OOLUA_EXPORT_FUNCTIONS(OpticalMeterInterface, TurnOnLED, TurnOffLED,
                       SetPumpFactor, SetMeterPoints, StartMeter, StopMeter,
                       IsAutoCloseValve, SetOpticalADNotifyPeriod,ExpectMeterResult,
                       SetMeteSpeed, SetMeterFinishValveMap, RegisterOpticalADNotice, SetRopinessMeterOverValue
                       ,SetMeterEndPointOverCount)
OOLUA_EXPORT_FUNCTIONS_CONST(OpticalMeterInterface, GetPumpFactor, GetMeterPoints,
                             GetMeterStatus, GetMeteSpeed, GetSingleOpticalAD, GetRopinessMeterOverValue,GetMeterEndPointOverCount)

/**
 * @brief 蠕动泵控制接口。
 * @details 定义了一序列蠕动泵控制相关的操作。
 */
OOLUA_PROXY(,PeristalticPumpInterface, DeviceInterface)
    OOLUA_TAGS(
        No_default_constructor //没有默认构造函数时可以使用此标签
    )
    OOLUA_CTORS(
        OOLUA_CTOR(DscpAddress)
    )
    OOLUA_MFUNC(GetTotalPumps)
    OOLUA_MFUNC(GetPumpFactor)
    OOLUA_MFUNC(SetPumpFactor)
    OOLUA_MFUNC(GetMotionParam)
    OOLUA_MFUNC(SetMotionParam)
    OOLUA_MFUNC(GetPumpStatus)
    OOLUA_MFUNC(StartPump)
    OOLUA_MFUNC(StopPump)
    OOLUA_MFUNC(GetPumpVolume)
    OOLUA_MFUNC(ExpectPumpResult)
    OOLUA_MFUNC(GetSenseStatus)
    OOLUA_MFUNC(SetPumpOffsetStep)
    OOLUA_MFUNC(GetPumpOffsetStep)

OOLUA_PROXY_END
OOLUA_EXPORT_FUNCTIONS(PeristalticPumpInterface, GetTotalPumps, GetPumpFactor, SetPumpFactor,
                       GetMotionParam, SetMotionParam, GetPumpStatus, StartPump,
                       StopPump, GetPumpVolume, ExpectPumpResult, GetSenseStatus,
                       SetPumpOffsetStep, GetPumpOffsetStep)
OOLUA_EXPORT_FUNCTIONS_CONST(PeristalticPumpInterface)

/**
 * @brief 电磁阀控制接口。
 * @details 定义了一序列电磁阀控制相关的操作。
 */
OOLUA_PROXY(,SolenoidValveInterface, DeviceInterface)
    OOLUA_TAGS(
        No_default_constructor //没有默认构造函数时可以使用此标签
    )
    OOLUA_CTORS(
        OOLUA_CTOR(DscpAddress)
    )
    OOLUA_MFUNC(GetTotalValves)
    OOLUA_MFUNC(GetValveMap)
    OOLUA_MFUNC(SetValveMap)
    OOLUA_MFUNC(SetValveMapNormalOpen)
    OOLUA_MFUNC(ProportionalValve_SetDACValue)
    OOLUA_MFUNC(ProportionalValve_AutoControlPressure)
    OOLUA_MFUNC(RegisterPressureNotice)

OOLUA_PROXY_END
OOLUA_EXPORT_FUNCTIONS(SolenoidValveInterface, GetTotalValves, GetValveMap, SetValveMap,SetValveMapNormalOpen,
                       ProportionalValve_SetDACValue, ProportionalValve_AutoControlPressure, RegisterPressureNotice)
OOLUA_EXPORT_FUNCTIONS_CONST(SolenoidValveInterface)

/**
 * 温度控制器接口
 */
OOLUA_PROXY(,TemperatureControlInterface, DeviceInterface)
    OOLUA_TAGS(
        No_default_constructor
    )
    OOLUA_CTORS(
        OOLUA_CTOR(DscpAddress)
    )
OOLUA_MFUNC_CONST(GetCalibrateFactor)       ///< 查询温度传感器的校准系数
OOLUA_MFUNC(SetCalibrateFactor)             ///< 设置温度传感器的校准系数
OOLUA_MFUNC_CONST(GetTemperature)           ///< 查询当前温度
OOLUA_MFUNC_CONST(GetThermostatParam)       ///< 查询恒温控制参数
OOLUA_MFUNC(SetThermostatParam)             ///<  设置恒温控制参数
OOLUA_MFUNC(StartThermostat)                ///< 开始恒温
OOLUA_MFUNC(StopThermostat)                 ///< 停止恒温控制
OOLUA_MFUNC(SetTemperatureNotifyPeriod)     ///< 设置温度上报周期
OOLUA_MFUNC(ExpectThermostat)               ///< 恒温结果事件
OOLUA_MFUNC(BoxFanSetOutput)                ///< 机箱风扇输出
OOLUA_MFUNC(DigestionFanSetOutputForTOC)          ///<消解冷却风扇输出
OOLUA_MFUNC_CONST(GetHeaterMaxDutyCycle)        ///<查询加热丝最大占空比
OOLUA_MFUNC(SetHeaterMaxDutyCycle)              ///<设置加热丝最大占空比
OOLUA_MFUNC_CONST(GetThermostatStatus)          ///< 查询恒温器的工作状态
OOLUA_MFUNC_CONST(GetCurrentThermostatParam)    ///< 查询当前恒温控制参数
OOLUA_MFUNC(SetCurrentThermostatParam)      ///< 设置当前恒温控制参数。
OOLUA_MFUNC(ReviseThermostatTemp)                ///< 修改恒温参数
OOLUA_MFUNC(RegisterTemperatureNotice)
OOLUA_MFUNC(SetCalibrateFactorForTOC)             ///< 设置温度传感器的校准系数
OOLUA_MFUNC_CONST(GetCalibrateFactorForTOC)       ///< 查询温度传感器的校准系数
OOLUA_MFUNC(BoxFanSetOutputForTOC)                ///< TOC机箱上下风扇输出
OOLUA_MFUNC(RelayControlForTOC)                   ///< TOC燃烧炉电源继电器控制
OOLUA_PROXY_END
OOLUA_EXPORT_FUNCTIONS(TemperatureControlInterface, SetCalibrateFactor, SetThermostatParam,StartThermostat,
                   StopThermostat, SetTemperatureNotifyPeriod, ExpectThermostat,BoxFanSetOutput,
                   DigestionFanSetOutputForTOC,SetHeaterMaxDutyCycle,SetCurrentThermostatParam, RegisterTemperatureNotice,
                   ReviseThermostatTemp, SetCalibrateFactorForTOC, BoxFanSetOutputForTOC, RelayControlForTOC)
OOLUA_EXPORT_FUNCTIONS_CONST(TemperatureControlInterface, GetCalibrateFactor, GetTemperature, GetThermostatParam,
                             GetHeaterMaxDutyCycle, GetThermostatStatus, GetCurrentThermostatParam, GetCalibrateFactorForTOC)


/**
 * 扩展温度控制器接口
 */
OOLUA_PROXY(,ExtTemperatureControlInterface, DeviceInterface)
    OOLUA_TAGS(
        No_default_constructor
    )
    OOLUA_CTORS(
        OOLUA_CTOR(DscpAddress)
    )
OOLUA_MFUNC_CONST(GetCalibrateFactor)       ///< 查询温度传感器的校准系数
OOLUA_MFUNC(SetCalibrateFactor)             ///< 设置温度传感器的校准系数
OOLUA_MFUNC_CONST(GetThermostatTemperature) ///< 查询指定恒温器温度
OOLUA_MFUNC_CONST(GetThermostatParam)       ///< 查询恒温控制参数
OOLUA_MFUNC(SetThermostatParam)             ///< 设置恒温控制参数
OOLUA_MFUNC_CONST(GetThermostatStatus)          ///< 查询恒温器的工作状态
OOLUA_MFUNC(StartThermostat)                ///< 开始恒温
OOLUA_MFUNC(StopThermostat)                 ///< 停止恒温控制
OOLUA_MFUNC(SetTemperatureNotifyPeriod)     ///< 设置温度上报周期
OOLUA_MFUNC(BoxFanSetOutput)                ///< 机箱风扇输出
OOLUA_MFUNC(ThermostatFanSetOutput)          ///<指定恒温器风扇输出
OOLUA_MFUNC_CONST(GetHeaterMaxDutyCycle)        ///<查询加热丝最大占空比
OOLUA_MFUNC(SetHeaterMaxDutyCycle)              ///<设置加热丝最大占空比
OOLUA_MFUNC_CONST(GetCurrentThermostatParam)    ///< 查询当前恒温控制参数
OOLUA_MFUNC(SetCurrentThermostatParam)      ///< 设置当前恒温控制参数。
OOLUA_MFUNC(TurnOnRays)                ///< 紫外灯继电器开
OOLUA_MFUNC(TurnOffRays)                ///< 紫外灯继电器关
OOLUA_MFUNC_CONST(GetTotalThermostat)          ///< 查询恒温器数目
OOLUA_MFUNC_CONST(GetEnvironmentTemperature)    ///< 查询当前环境温度
OOLUA_MFUNC(ExpectThermostat)               ///< 恒温结果事件
OOLUA_PROXY_END
OOLUA_EXPORT_FUNCTIONS(ExtTemperatureControlInterface, SetCalibrateFactor, SetThermostatParam,StartThermostat,
                   StopThermostat, SetTemperatureNotifyPeriod, ExpectThermostat,BoxFanSetOutput,TurnOnRays, TurnOffRays,
                   ThermostatFanSetOutput,SetHeaterMaxDutyCycle,SetCurrentThermostatParam)
OOLUA_EXPORT_FUNCTIONS_CONST(ExtTemperatureControlInterface, GetCalibrateFactor, GetThermostatTemperature, GetThermostatParam,
                             GetHeaterMaxDutyCycle, GetThermostatStatus, GetCurrentThermostatParam, GetTotalThermostat, GetEnvironmentTemperature)



/**
 * @brief 光学信号采集的AD值。
 * @details
 */
OOLUA_PROXY(,OpticalAD)
    OOLUA_MGET_MSET(reference, GetReference, SetReference)
    OOLUA_MGET_MSET(measure, GetMeasure, SetMeasure)
OOLUA_PROXY_END
OOLUA_EXPORT_FUNCTIONS(OpticalAD, SetReference, SetMeasure)
OOLUA_EXPORT_FUNCTIONS_CONST(OpticalAD, GetReference, GetMeasure)

/**
 * @brief 蠕动泵操作结果码。
 * @details
 */
OOLUA_PROXY(,AcquiredOperateResult)
    OOLUA_TAGS(
        Register_class_enums  // 枚举需要特别标注，否则枚举值无效
    )
    OOLUA_ENUMS(
        OOLUA_ENUM(Finished)   // 枚举值
        OOLUA_ENUM(Failed)   // 枚举值
        OOLUA_ENUM(Stopped)   // 枚举值
    )
OOLUA_PROXY_END
OOLUA_EXPORT_NO_FUNCTIONS(AcquiredOperateResult)  // 导出函数声明（没有函数也需要声明）


/**
 * @brief 光学信号采集的结果。
 * @details
 */
OOLUA_PROXY(,AcquiredResult)
    OOLUA_MGET_MSET(ad, GetAD, SetAD)
    OOLUA_MGET_MSET(result, GetResult, SetResult)
OOLUA_PROXY_END
OOLUA_EXPORT_FUNCTIONS(AcquiredResult, SetAD, SetResult)
OOLUA_EXPORT_FUNCTIONS_CONST(AcquiredResult, GetAD, GetResult)

/**
 * @brief LED控制参数。
 * @details
 */
OOLUA_PROXY(,LedParam)
    OOLUA_MGET_MSET(proportion, GetProportion, SetProportion)
    OOLUA_MGET_MSET(integration, GetIntegration, SetIntegration)
    OOLUA_MGET_MSET(differential, GetDifferential, SetDifferential)
OOLUA_PROXY_END
OOLUA_EXPORT_FUNCTIONS(LedParam, SetProportion, SetIntegration, SetDifferential)
OOLUA_EXPORT_FUNCTIONS_CONST(LedParam, GetProportion, GetIntegration, GetDifferential)


/**
 * @brief 静态AD调节控制结果码
 * @details
 */
OOLUA_PROXY(,StaticADControlResult)
    OOLUA_TAGS(
        Register_class_enums  // 枚举需要特别标注，否则枚举值无效
    )
    OOLUA_ENUMS(
        OOLUA_ENUM(Unfinished)   // 枚举值
        OOLUA_ENUM(Finished)   // 枚举值
    )
OOLUA_PROXY_END
OOLUA_EXPORT_NO_FUNCTIONS(StaticADControlResult)  // 导出函数声明（没有函数也需要声明）

/**
 * @brief 光学信号采集接口。
 * @details 定义了一序列光学信号采集相关的操作。
 */
OOLUA_PROXY(,OpticalAcquireInterface, DeviceInterface)
    OOLUA_TAGS(
        No_default_constructor //没有默认构造函数时可以使用此标签
    )
    OOLUA_CTORS(
        OOLUA_CTOR(DscpAddress)
    )
    OOLUA_MFUNC_CONST(TurnOnLED)
    OOLUA_MFUNC(SetAcquireADNotifyPeriod)
    OOLUA_MFUNC(StartAcquirer)
    OOLUA_MFUNC(StopAcquirer)
    OOLUA_MFUNC(StartLEDController)
    OOLUA_MFUNC_CONST(TurnOffLED)
    OOLUA_MFUNC_CONST(GetLEDControllerTartet)
    OOLUA_MFUNC(SetLEDControllerTarget)
    OOLUA_MFUNC(StartLEDOnceAdjust)
    OOLUA_MFUNC_CONST(StopLEDOnceAdjust)
    OOLUA_MFUNC_CONST(GetLEDControllerParam)
    OOLUA_MFUNC(SetLEDControllerParam)
    OOLUA_MFUNC_CONST(GetStaticADControlParam)
    OOLUA_MFUNC(StartStaticADControl)
    OOLUA_MFUNC(StopStaticADControl)
    OOLUA_MFUNC(SetStaticADControlParam)
    OOLUA_MFUNC_CONST(IsStaticADControlValid)
    OOLUA_MFUNC_CONST(GetLEDDefaultValue)
    OOLUA_MFUNC(SetLEDDefaultValue)
    OOLUA_MFUNC(ExpectADAcquirer)
    OOLUA_MFUNC(ExpectLEDOnceAdjust)
    OOLUA_MFUNC(ExpectStaticADControlResult)
    OOLUA_MFUNC(RegisterAcquireADNotice)
    OOLUA_MFUNC(SetNDIRReportPeriod)
    OOLUA_MFUNC(RegisterNDIRNotice)
//    OOLUA_MFUNC(SetCheckLeakingADNotifyPeriod)

OOLUA_PROXY_END
OOLUA_EXPORT_FUNCTIONS(OpticalAcquireInterface, SetAcquireADNotifyPeriod, StartAcquirer, StopAcquirer,
                       StartLEDController, SetLEDControllerTarget, StartLEDOnceAdjust, SetLEDDefaultValue,
                       ExpectLEDOnceAdjust, ExpectADAcquirer,  RegisterNDIRNotice, RegisterAcquireADNotice,
                       StartStaticADControl, StopStaticADControl, SetStaticADControlParam, ExpectStaticADControlResult)
OOLUA_EXPORT_FUNCTIONS_CONST(OpticalAcquireInterface, GetLEDControllerTartet, GetLEDControllerParam, StopLEDOnceAdjust,
                             IsStaticADControlValid, TurnOnLED, TurnOffLED, GetStaticADControlParam, GetLEDDefaultValue)

/**
 * @brief 扩展的光学信号采集接口。
 * @details 定义了一序列光学信号采集相关的操作。
 */
OOLUA_PROXY(,ExtOpticalAcquireInterface, DeviceInterface)
    OOLUA_TAGS(
        No_default_constructor //没有默认构造函数时可以使用此标签
    )
    OOLUA_CTORS(
        OOLUA_CTOR(DscpAddress)
    )
    OOLUA_MFUNC_CONST(TurnOnLED)
    OOLUA_MFUNC(SetAcquireADNotifyPeriod)
    OOLUA_MFUNC(StartAcquirer)
    OOLUA_MFUNC(StopAcquirer)
    OOLUA_MFUNC(StartLEDController)
    OOLUA_MFUNC_CONST(TurnOffLED)
    OOLUA_MFUNC_CONST(GetLEDControllerTartet)
    OOLUA_MFUNC(SetLEDControllerTarget)
    OOLUA_MFUNC(StartLEDOnceAdjust)
    OOLUA_MFUNC_CONST(StopLEDOnceAdjust)
    OOLUA_MFUNC_CONST(GetLEDControllerParam)
    OOLUA_MFUNC(SetLEDControllerParam)
    OOLUA_MFUNC(StartStaticADControl)
    OOLUA_MFUNC(StopStaticADControl)
    OOLUA_MFUNC_CONST(GetStaticADControlParam)
    OOLUA_MFUNC(SetStaticADControlParam)
    OOLUA_MFUNC_CONST(IsStaticADControlValid)
    OOLUA_MFUNC_CONST(GetLEDDefaultValue)
    OOLUA_MFUNC(SetLEDDefaultValue)
    OOLUA_MFUNC(ExpectADAcquirer)
    OOLUA_MFUNC(ExpectLEDOnceAdjust)
    OOLUA_MFUNC(ExpectStaticADControlResult)

OOLUA_PROXY_END
OOLUA_EXPORT_FUNCTIONS(ExtOpticalAcquireInterface, SetAcquireADNotifyPeriod, StartAcquirer, StopAcquirer,
                       StartLEDController, SetLEDControllerTarget, SetLEDDefaultValue, StartLEDOnceAdjust,
                       SetLEDControllerParam, ExpectADAcquirer,  ExpectLEDOnceAdjust, StartStaticADControl,
                       StopStaticADControl, SetStaticADControlParam, ExpectStaticADControlResult)
OOLUA_EXPORT_FUNCTIONS_CONST(ExtOpticalAcquireInterface, GetLEDControllerTartet, GetLEDControllerParam, StopLEDOnceAdjust,
                             IsStaticADControlValid, TurnOnLED, TurnOffLED, GetStaticADControlParam, GetLEDDefaultValue)

/**
 * @brief 步进电机控制接口。
 * @details 定义了一序列蠕动泵控制相关的操作。
 */
OOLUA_PROXY(,MotorControlInterface, DeviceInterface)
    OOLUA_TAGS(
        No_default_constructor //没有默认构造函数时可以使用此标签
    )
    OOLUA_CTORS(
        OOLUA_CTOR(DscpAddress)
    )
    OOLUA_MFUNC(GetTotalMotors)
    OOLUA_MFUNC(GetMotorParam)
    OOLUA_MFUNC(SetMotorParam)
    OOLUA_MFUNC(GetMotorStatus)
    OOLUA_MFUNC(GetMotorMaxSteps)
    OOLUA_MFUNC(GetMotorInitSteps)
    OOLUA_MFUNC(GetMotorCurrentSteps)
    OOLUA_MFUNC(MotorMove)
    OOLUA_MFUNC(MotorStop)
    OOLUA_MFUNC(MotorReset)
    OOLUA_MFUNC(GetSensorStatus)
    OOLUA_MFUNC(ExpectMotorResult)
    OOLUA_MFUNC(MotorDriverReinit)
    OOLUA_MFUNC(MotorDriverCheck)
    OOLUA_MFUNC(ExtraDeviceControl)
    OOLUA_MFUNC(MotorMoveXYZ)
    OOLUA_MFUNC(MotorResetXYZ)

OOLUA_PROXY_END
OOLUA_EXPORT_FUNCTIONS(MotorControlInterface, GetTotalMotors, GetMotorParam, SetMotorParam,
                       GetMotorStatus, GetMotorMaxSteps, GetMotorInitSteps, GetMotorCurrentSteps,
                       MotorMove, MotorStop, MotorReset, GetSensorStatus, ExpectMotorResult,
                       MotorResetXYZ, MotorMoveXYZ, ExtraDeviceControl)
OOLUA_EXPORT_FUNCTIONS_CONST(MotorControlInterface)

/**
 * @brief 驱动控制器。
 * @details
 */
OOLUA_PROXY(,TOCDriveController, BaseController)
    OOLUA_TAGS(
        No_default_constructor //没有默认构造函数时可以使用此标签
    )
    OOLUA_CTORS(
        OOLUA_CTOR(DscpAddress)
    )
    OOLUA_MFUNC(Init)
    OOLUA_MFUNC(Uninit)
    OOLUA_MFUNC(SetBoxFanEnable)
    OOLUA_MFUNC(GetIPeristalticPump)
    OOLUA_MFUNC(GetISolenoidValve)
    OOLUA_MFUNC(GetIOpticalMeter)
    OOLUA_MFUNC(GetITemperatureControl)
    OOLUA_MFUNC(GetIOpticalAcquire)
    OOLUA_MFUNC(GetIExtTemperatureControl)
    OOLUA_MFUNC(GetIExtOpticalAcquire)
    OOLUA_MFUNC(GetIMotorControl)
    OOLUA_MFUNC(Register)
    OOLUA_MFUNC_CONST(GetDigestTemperature)
    OOLUA_MFUNC_CONST(GetEnvironmentTemperature)
    OOLUA_MFUNC(GetCurrentTemperature)
    OOLUA_MFUNC_CONST(GetReportThermostatTemp)
    OOLUA_MFUNC_CONST(GetReportEnvironmentTemp)
    OOLUA_MFUNC_CONST(GetPressure)
    OOLUA_MFUNC_CONST(GetScanData)
    OOLUA_MFUNC_CONST(GetScanLen)
    OOLUA_MFUNC_CONST(GetExScanData)
    OOLUA_MFUNC_CONST(GetExScanLen)
    OOLUA_MFUNC_CONST(NDIRResultHandle)
    OOLUA_MFUNC_CONST(IsReachSteady)
    OOLUA_MFUNC(ClearBuf)
    OOLUA_MFUNC(ClearExBuf)
    OOLUA_MFUNC_CONST(ClearAllRemainEvent)
    OOLUA_MFUNC_CONST(ClearThermostatRemainEvent)
    OOLUA_MFUNC_CONST(ClearPumpRemainEvent)

OOLUA_PROXY_END
OOLUA_EXPORT_FUNCTIONS(TOCDriveController, Init, Uninit, SetBoxFanEnable, GetIPeristalticPump, GetISolenoidValve,
                       GetIOpticalMeter,GetCurrentTemperature,GetIOpticalAcquire, GetITemperatureControl,
                       GetIExtOpticalAcquire,GetIMotorControl, GetIExtTemperatureControl, Register,ClearBuf,ClearExBuf)
OOLUA_EXPORT_FUNCTIONS_CONST(TOCDriveController,GetReportThermostatTemp,GetReportEnvironmentTemp,
                             GetDigestTemperature, GetEnvironmentTemperature,
                             GetPressure,NDIRResultHandle,IsReachSteady,GetScanData,GetScanLen,GetExScanData,GetExScanLen,
                             ClearAllRemainEvent,ClearThermostatRemainEvent,ClearPumpRemainEvent)

TOCDriveControllerPluginProxy::TOCDriveControllerPluginProxy()
{

}

void TOCDriveControllerPluginProxy::Proxy()
{
    Script *lua = LuaEngine::Instance()->GetEngine();

    lua->register_class<MeterPoint>();
    lua->register_class<MeterPoints>();
    lua->register_class<MotionParam>();
    lua->register_class<PumpStatus>();
    lua->register_class<RollDirection>();
    lua->register_class<PumpOperateResult>();
    lua->register_class<PumpResult>();
    lua->register_class<ValveMap>();
    lua->register_class<MeterMode>();
    lua->register_class<MeterResult>();
    lua->register_class<Temperature>();
    lua->register_class<ThermostatParam>();
    lua->register_class<TempCalibrateFactor>();
    lua->register_class<ThermostatMode>();
    lua->register_class<ThermostatOperateResult>();
    lua->register_class<ThermostatResult>();
    lua->register_class<OpticalAD>();
    lua->register_class<AcquiredOperateResult>();
    lua->register_class<AcquiredResult>();
    lua->register_class<LedParam>();
    lua->register_class<StaticADControlResult>();
    lua->register_class<OpticalMeterInterface>();
    lua->register_class<PeristalticPumpInterface>();
    lua->register_class<SolenoidValveInterface>();
    lua->register_class<TemperatureControlInterface>();
    lua->register_class<OpticalAcquireInterface>();
    lua->register_class<ExtTemperatureControlInterface>();
    lua->register_class<ExtOpticalAcquireInterface>();
    lua->register_class<MotorControlInterface>();
    lua->register_class<TOCDriveController>();
    lua->register_class<MotorParam>();
    lua->register_class<MotorStatus>();
    lua->register_class<MotorDirection>();
    lua->register_class<MotorOperateResult>();
    lua->register_class<MotorResult>();
    lua->register_class<MotorMoveMode>();
    lua->register_class<MotionParam>();
    lua->register_class<Motor3DPos>();
}

