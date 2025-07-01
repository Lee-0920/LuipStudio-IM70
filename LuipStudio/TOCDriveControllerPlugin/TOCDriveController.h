/**
 * @file
 * @brief 驱动控制器。
 * @details
 * @version 1.0.0
 * @author kim@erchashu.com
 * @date 2016/5/13
 */


#if !defined(CONTROLLER_DRIVECONTROLNET_H_)
#define CONTROLLER_DRIVECONTROLNET_H_

#include <vector>
#include <QObject>
#include "LuipShare.h"
#include "ControllerPlugin/BaseController.h"
#include "API/PeristalticPumpInterface.h"
#include "API/SolenoidValveInterface.h"
#include "API/OpticalMeterInterface.h"
#include "API/TemperatureControlInterface.h"
#include "API/OpticalAcquireInterface.h"
#include "API/ExtTemperatureControlInterface.h"
#include "API/ExtOpticalAcquireInterface.h"
#include "API/MotorControlInterface.h"
#include "oolua.h"
#include <memory>
#include <QTimer>

#define DATA_MAX_LENGTH 4096

using std::list;

namespace Controller
{

/**
 * @brief 驱动控制器。
 * @details
 */
class LUIP_SHARE TOCDriveController : public QObject, public BaseController
{
    Q_OBJECT

public:
    TOCDriveController(DscpAddress addr);
    virtual ~TOCDriveController();
    bool Init();
    bool Uninit();

    PeristalticPumpInterface* GetIPeristalticPump();
    SolenoidValveInterface* GetISolenoidValve();
    OpticalMeterInterface* GetIOpticalMeter();
    TemperatureControlInterface*  GetITemperatureControl();
    OpticalAcquireInterface* GetIOpticalAcquire();
    ExtTemperatureControlInterface*  GetIExtTemperatureControl();
    ExtOpticalAcquireInterface* GetIExtOpticalAcquire();
    MotorControlInterface* GetIMotorControl();

    float GetDigestTemperature() const;
    float GetEnvironmentTemperature() const;
    Temperature GetCurrentTemperature();
	
	float GetReportThermostatTemp(int index) const;
    float GetReportEnvironmentTemp() const;
    float GetStoveADValue() const;

    float GetPressure(int index) const;

    double GetScanData(int index) const;
    int GetScanLen(void) const;
    double GetExScanData(int index) const;
    int GetExScanLen(void) const;
    double GetData(void);
    double GetExData(void);
    double NDIRResultHandle(int startIndex, int endIndex, int validCnt, int step, int increment,int filterStep, int throwNum, bool isExtra) const;
    void Filter(const double *buf, double *fbuf, int length, int filterStep, int throwNum) const;
    bool IsReachSteady(int num, int validCnt, int step, int increment, int filterStep, int throwNum, int index, bool isExtra) const;
    void ClearBuf(void);
    void ClearExBuf(void);
    void ClearAllRemainEvent()const;
    void ClearThermostatRemainEvent()const;
    void ClearPumpRemainEvent()const;
    // ---------------------------------------
    // IEventReceivable 接口
    void Register(ISignalNotifiable *handle);
    virtual void OnReceive(DscpEventPtr event);
    void StartSignalUpload();
    void TempMonitor();
    void StopSignalUpload();
    void SetBoxFanEnable(bool enable);
    OOLUA::Lua_func_ref setBaseLine;

public:
    // 设备接口集
    PeristalticPumpInterface * const IPeristalticPump;
    SolenoidValveInterface * const ISolenoidValve;
    OpticalMeterInterface * const IOpticalMeter;
    TemperatureControlInterface * const ITemperatureControl;
    OpticalAcquireInterface * const IOpticalAcquire;
    ExtTemperatureControlInterface * const IExtTemperatureControl;
    ExtOpticalAcquireInterface * const IExtOpticalAcquire;
    MotorControlInterface* const IMotorControl;

signals:
  void  BoxFanControlSignal(float temp);
  void  ExBoxFanControlSignal(float temp);
public slots:
  void  BoxFanControlSlot(float temp);
  void  ExBoxFanControlSlot(float temp);
  void  ThermostatMonitorSlot(void);
  void  BaseLineStatusMonitor(void);
private:
    list<ISignalNotifiable*> m_notifise;
    Temperature m_temperature;
    bool m_isEnable;
    bool m_isBoxFanRunning;
    bool m_weepingDetectEnable;
    int m_LEDPeriod;
    float m_insideEnvironmentTemp;
    float m_ExInsideEnvironmentTemp;

    float m_upEnvironmentTemp;
    float m_downEnvironmentTemp;
    float m_thermostatTempArray[8];
    float m_pressureArray[3];
    int m_tempMonitorControlPeriod;
    double m_scanData[DATA_MAX_LENGTH];
    int m_scanLen;
    double m_exScanData[DATA_MAX_LENGTH];
    int m_exScanLen;
    float m_stoveADValue;
    float m_MeasureTemp[DATA_MAX_LENGTH];
    float m_EnvTemp[DATA_MAX_LENGTH];
    float m_pressure[DATA_MAX_LENGTH];
    float m_exMeasureTemp[DATA_MAX_LENGTH];
    float m_exEnvTemp[DATA_MAX_LENGTH];
    float m_exPressure[DATA_MAX_LENGTH];
    QTimer *timer;
    QTimer *m_baseLineTimer;
    OOLUA::Lua_func_ref thermostatFunc;
    int m_timeOutLen;
};

}

#endif  //CONTROLLER_DRIVECONTROLNET_H_

