/**
 * @file
 * @brief 阀映射图。
 * @details 
 * @version 1.0.0
 * @author kim@erchashu.com
 * @date 2015/3/7
 */


#include "ValveMap.h"

namespace Controller
{
namespace API
{

ExValveMap::ExValveMap()
{

}

ExValveMap::ExValveMap(Uint32 data)
{
    m_map = data;
}

void ExValveMap::SetData(Uint32 data)
{
    m_map = data;
}

Uint32 ExValveMap::GetData()
{
    return m_map;
}

void ExValveMap::SetOn(int index)
{
    m_map |= 1 << index;
}

void ExValveMap::SetOff(int index)
{
    m_map &= ~(1 << index);
}

bool ExValveMap::IsOn(int index)
{
    return (m_map & (1 << index));
}

void ExValveMap::clear()
{
    m_map = 0;
}

}
}
