/**
 * @file
 * @brief 电磁阀控制接口。
 * @details 
 * @version 1.0.0
 * @author kim@erchashu.com
 * @date 2015/3/7
 */


#if !defined(CONTROLLER_API_EXTSOLENOIDVALVEINTERFACE_H)
#define CONTROLLER_API_EXTSOLENOIDVALVEINTERFACE_H

#include "ControllerPlugin/API/DeviceInterface.h"
#include "System/Types.h"
#include "ValveMap.h"
#include "../LuipShare.h"

namespace Controller
{
namespace API
{    


/**
 * @brief 电磁阀控制接口。
 * @details 定义了一序列电磁阀控制相关的操作。
 */
class LUIP_SHARE ExtSolenoidValveInterface : public DeviceInterface
{
public:
    ExtSolenoidValveInterface(DscpAddress addr);
    // 查询系统支持的总电磁阀数目。
    int GetTotalValves();
    // 查询当前开启的阀门映射图。
    ExValveMap GetValveMap();
    // 设置要开启的阀门映射图。
    bool SetValveMap(ExValveMap map);
    //  设置常开阀
    bool SetValveMapNormalOpen(ExValveMap map);

};

}
}

#endif  //CONTROLNET_API_SOLENOIDVALVEINTERFACE_H
