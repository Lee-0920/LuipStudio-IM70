#ifndef COMMON_H
#define COMMON_H

#include <QObject>

#define PRECISE 0.000001

const QString g_trText[] =
{
    ///*****版本信息*****///
    QObject::tr("tr_version"),
    QObject::tr("tr_time"),
    ///*****主界面*****///
    QObject::tr("   运行 "),
    QObject::tr("   离线 "),
    QObject::tr("   故障 "),
    QObject::tr("   维护 "),
    QObject::tr("   校准 "),
    QObject::tr("触发测量"),
    QObject::tr("周期测量"),
    QObject::tr("整点测量"),
    QObject::tr("连续测量"),
    QObject::tr("手动测量"),
    QObject::tr("将于"),
    ///*****测量数据*****///
    QObject::tr("测量数据"),
    QObject::tr("全部"),
    QObject::tr("空白水"),
    QObject::tr("水样"),
    QObject::tr("标液"),
    QObject::tr("标液二"),
    QObject::tr("加标样"),
    QObject::tr("平行样"),
    QObject::tr("零点核查"),
    QObject::tr("量程核查"),
    QObject::tr("加标(内)"),
    QObject::tr("平行(内)"),
    QObject::tr("加标(外)"),
    QObject::tr("平行(外)"),
    QObject::tr("加标"),
    QObject::tr("平行"),
    QObject::tr("正常"),
    QObject::tr("离线"),
    QObject::tr("故障"),
    QObject::tr("校准"),
    QObject::tr("超量程"),
    QObject::tr("时间"),
    QObject::tr("结果"),
    QObject::tr("结果(mg/L)"),
    QObject::tr("结果(ug/L)"),
    QObject::tr("结果"),
    QObject::tr("吸光度(mAbs)"),
    QObject::tr("标识"),
    QObject::tr("类型"),
    QObject::tr("浓度"),
    QObject::tr("吸光度"),
    QObject::tr("核查"),
    QObject::tr("空白参考AD"),
    QObject::tr("空白测量AD"),
    QObject::tr("初始参考AD"),
    QObject::tr("初始测量AD"),
    QObject::tr("反应参考AD"),
    QObject::tr("反应测量AD"),
    QObject::tr("空白值消解室温度"),
    QObject::tr("空白值环境温度"),
    QObject::tr("初始值消解室温度"),
    QObject::tr("初始值环境温度"),
    QObject::tr("反应值消解室温度"),
    QObject::tr("反应值环境温度"),
    QObject::tr("读空白值消解室温度"),
    QObject::tr("读空白值环境温度"),
    QObject::tr("读初始值消解室温度"),
    QObject::tr("读初始值环境温度"),
    QObject::tr("读反应值消解室温度"),
    QObject::tr("读反应值环境温度"),
    QObject::tr("测量时长"),
    QObject::tr("加标液浓度"),
    QObject::tr("水样浓度"),
    QObject::tr("加标浓度"),
    QObject::tr("加标样浓度"),
    QObject::tr("回收率"),
    QObject::tr("平行样浓度"),
    QObject::tr("滴定体积(mL)"),
    QObject::tr("0点吸光度"),
    QObject::tr("0点浓度"),
    QObject::tr("0点空白参考AD"),
    QObject::tr("0点空白测量AD"),
    QObject::tr("0点初始参考AD"),
    QObject::tr("0点初始测量AD"),
    QObject::tr("0点反应参考AD"),
    QObject::tr("0点反应测量AD"),
    QObject::tr("0点空白消解室温度"),
    QObject::tr("0点空白环境温度"),
    QObject::tr("0点初始消解室温度"),
    QObject::tr("0点初始环境温度"),
    QObject::tr("0点反应消解室温度"),
    QObject::tr("0点反应环境温度"),
    QObject::tr("1点吸光度"),
    QObject::tr("1点浓度"),
    QObject::tr("1点空白参考AD"),
    QObject::tr("1点空白测量AD"),
    QObject::tr("1点初始参考AD"),
    QObject::tr("1点初始测量AD"),
    QObject::tr("1点反应参考AD"),
    QObject::tr("1点反应测量AD"),
    QObject::tr("1点空白消解室温度"),
    QObject::tr("1点空白环境温度"),
    QObject::tr("1点初始消解室温度"),
    QObject::tr("1点初始环境温度"),
    QObject::tr("1点反应消解室温度"),
    QObject::tr("1点反应环境温度"),
    QObject::tr("2点吸光度"),
    QObject::tr("2点浓度"),
    QObject::tr("2点空白参考AD"),
    QObject::tr("2点空白测量AD"),
    QObject::tr("2点初始参考AD"),
    QObject::tr("2点初始测量AD"),
    QObject::tr("2点反应参考AD"),
    QObject::tr("2点反应测量AD"),
    QObject::tr("2点空白消解室温度"),
    QObject::tr("2点空白环境温度"),
    QObject::tr("2点初始消解室温度"),
    QObject::tr("2点初始环境温度"),
    QObject::tr("2点反应消解室温度"),
    QObject::tr("2点反应环境温度"),
    QObject::tr("曲线线性度"),
    QObject::tr("校准时长"),
    ///*****测量波形*****///
    QObject::tr("测量波形"),
    QObject::tr("历史趋势"),
    ///*****校准曲线*****///
    QObject::tr("校准曲线"),
    QObject::tr("曲线"),
    QObject::tr("零点(mAbs)"),
    QObject::tr("标点(mAbs)"),
    QObject::tr("标点二(mAbs)"),
    QObject::tr("零点(mL)"),
    QObject::tr("标点(mL)"),
    QObject::tr("标点二(mL)"),
    QObject::tr("标点浓度: "),
    QObject::tr("斜率"),
    QObject::tr("截距"),
    QObject::tr("曲线线性度"),
    QObject::tr("线性度"),
    QObject::tr("校准时长"),
    QObject::tr("当前标线"),
    QObject::tr("校准浓度"),
    QObject::tr("标定浓度"),
    ///*****告警管理*****///
    QObject::tr("告警管理"),
    QObject::tr("所有告警"),
    QObject::tr("系统异常"),
    QObject::tr("通信异常"),
    QObject::tr("仪器故障"),
    QObject::tr("维护提示"),
    QObject::tr("升级异常"),
    QObject::tr("测量异常"),
    ///*****运行日志*****///
    QObject::tr("运行日志"),
    ///*****基本信号*****///
    QObject::tr("基本信号"),
    QObject::tr("测量模块"),
    QObject::tr("参考AD"),
    QObject::tr("测量AD"),
    QObject::tr("绝对吸光度"),
    QObject::tr("定量管"),
    QObject::tr("点一AD"),
    QObject::tr("点二AD"),
    QObject::tr("消解器"),
    QObject::tr("消解温度"),
    QObject::tr("仪器"),
    QObject::tr("环境温度"),
    QObject::tr("电极AD"),
    ///*****测量排期*****///
    QObject::tr("测量排期"),
    QObject::tr("水样测量"),
    QObject::tr("校准"),
    QObject::tr("空白核查"),
    QObject::tr("标液核查"),
    QObject::tr("标液二核查"),
    QObject::tr("加标回收", "Schedule"),
    QObject::tr("平行测量", "Schedule"),
    QObject::tr("仪器清洗"),
    QObject::tr("测量模式"),
    QObject::tr("间隔周期"),
    QObject::tr("整点设置"),
    QObject::tr("自动核查"),
    QObject::tr("自动校准"),
    QObject::tr("自动加标"),
    QObject::tr("自动平行"),
    QObject::tr("自动清洗"),
    QObject::tr("小时"),
    QObject::tr("修改"),
    QObject::tr("核查测量"),
    ///*****测量参数*****///
    QObject::tr("测量参数"),
    QObject::tr("量程"),
    QObject::tr("当前量程"),
    QObject::tr("零点核查量程"),
    QObject::tr("量程核查量程"),
    QObject::tr("量程自动切换"),
    QObject::tr("切换后生效模式"),
    QObject::tr("立即生效"),
    QObject::tr("下次生效"),
    QObject::tr("消解"),
    QObject::tr("消解温度"),
    QObject::tr("消解时间"),
    QObject::tr("反应"),
    QObject::tr("反应温度"),
    QObject::tr("反应时间"),
    QObject::tr("零点精准校准"),
    QObject::tr("标点精准校准"),
    QObject::tr("零点精准模式"),
    QObject::tr("标点精准模式"),
    QObject::tr("零点浓度"),
    QObject::tr("标点浓度"),
    QObject::tr("标点二浓度"),
    QObject::tr("标液浓度"),
    QObject::tr("标液二浓度"),
    QObject::tr("标线斜率"),
    QObject::tr("标线截距"),
    QObject::tr("量程校正"),
    QObject::tr("精准模式"),
    QObject::tr("偏差阈值"),
    QObject::tr("量程二校正液浓度"),
    QObject::tr("量程三校正液浓度"),
    QObject::tr("量程四校正液浓度"),
    QObject::tr("量程五校正液浓度"),
    QObject::tr("定量AD调节", "Param"),
    QObject::tr("定量一"),
    QObject::tr("定量二"),
    QObject::tr("测量AD调节", "Param"),
    QObject::tr("参考端"),
    QObject::tr("测量端"),
    QObject::tr("修正"),
    QObject::tr("修正系数"),
    QObject::tr("修正因子"),
    QObject::tr("平移因子"),
    QObject::tr("平移系数"),
    QObject::tr("浊度扣除"),
    QObject::tr("浊度补偿系数"),
    QObject::tr("测量前清洗"),
    QObject::tr("测量后清洗"),
    QObject::tr("水样管清洗"),
    QObject::tr("空白水体积"),
    QObject::tr("管路"),
    QObject::tr("水样管延长体积"),
    QObject::tr("水样更新体积"),
    QObject::tr("读初始值"),
    QObject::tr("读反应值"),
    QObject::tr("静置时间"),
    QObject::tr("内部校正"),
    QObject::tr("量程一校正因子"),
    QObject::tr("量程二校正因子"),
    QObject::tr("量程三校正因子"),
    QObject::tr("量程四校正因子"),
    QObject::tr("量程五校正因子"),
    QObject::tr("量程一校正系数"),
    QObject::tr("量程二校正系数"),
    QObject::tr("量程三校正系数"),
    QObject::tr("量程四校正系数"),
    QObject::tr("量程五校正系数"),
    QObject::tr("加热丝"),
    QObject::tr("最大占空比"),
    QObject::tr("高氯模式"),
    QObject::tr("PID调光"),
    QObject::tr("试剂二备用阀"),
    QObject::tr("三点校准"),
    QObject::tr("自动测量AD校准"),
    QObject::tr("测量时氙灯老化"),
    QObject::tr("测量加液"),
    QObject::tr("步数"),
    QObject::tr("步"),
    QObject::tr("功率等级"),
    QObject::tr("滴定算法切换阈值"),
    QObject::tr("峰顶高度"),
    QObject::tr("滴定终点阈值"),
    QObject::tr("转换"),
    QObject::tr("水样转换系数"),
    QObject::tr("零点核查转换系数"),
    QObject::tr("量程核查转换系数"),
    QObject::tr("清洗开关"),
    QObject::tr("间隔时间"),
    QObject::tr("电极清洗"),
    QObject::tr("测量控制"),
    QObject::tr("试剂一体积"),
    QObject::tr("预热目标温度"),
    QObject::tr("智能散热"),
    QObject::tr("低浓度-峰高阈值"),
    QObject::tr("高浓度-峰高阈值"),
    QObject::tr("漏液检测"),
    QObject::tr("进液阀"),
    QObject::tr("工作时间"),
    QObject::tr("暂停时间"),
    QObject::tr("冷却温度"),
    QObject::tr("反应1温度"),
    QObject::tr("反应2温度"),
    QObject::tr("反应3温度"),
    QObject::tr("反应1时间"),
    QObject::tr("反应2时间"),
    QObject::tr("反应3时间"),
    QObject::tr("磷补偿系数"),
    QObject::tr("补偿系数"),
    QObject::tr("标样核查"),
    QObject::tr("标样浓度"),
    QObject::tr("核查偏差限值"),
    QObject::tr("自动校准"),
    ///*****外联接口*****///
    QObject::tr("外联接口"),
    QObject::tr("上报"),
    QObject::tr("模式"),
    QObject::tr("运行"),
    QObject::tr("离线"),
    QObject::tr("故障"),
    QObject::tr("维护"),
    QObject::tr("校准"),
    QObject::tr("超标报警"),
    QObject::tr("报警"),
    QObject::tr("测量上限"),
    QObject::tr("测量下限"),
    QObject::tr("通信地址"),
    QObject::tr("传输速率"),
    QObject::tr("校验位"),
    QObject::tr("水样4-20mA"),
    QObject::tr("浓度下限"),
    QObject::tr("浓度上限"),
    QObject::tr("采水样"),
    QObject::tr("采水模式"),
    QObject::tr("外部触发"),
    QObject::tr("测量前采水"),
    QObject::tr("采至加样完"),
    QObject::tr("采至测量完"),
    QObject::tr("测量前采水时间"),
    QObject::tr("测量前静默时间"),
    QObject::tr("多功能继电器"),
    QObject::tr("继电器1"),
    QObject::tr("继电器2"),
    QObject::tr("测量下限"),
    QObject::tr("测量上限"),
    QObject::tr("测量指示"),
    QObject::tr("标定指示"),
    QObject::tr("清洗指示"),
    QObject::tr("采水指示"),
    QObject::tr("网络设置"),
    QObject::tr("设置IP模式"),
    QObject::tr("静态"),
    QObject::tr("动态"),
    QObject::tr("无"),
    QObject::tr("奇校验"),
    QObject::tr("偶校验"),
    ///*****系统参数*****///
    QObject::tr("系统参数"),
    QObject::tr("语言"),
    QObject::tr("仪器保护"),
    QObject::tr("故障停机"),
    QObject::tr("运行故障停机"),
    QObject::tr("更换试剂提醒"),
    QObject::tr("干烧保护"),
    QObject::tr("排液检查"),
    QObject::tr("特殊参数"),
    QObject::tr("二维码"),
    QObject::tr("Modbus表"),
    QObject::tr("CCEP认证协议"),
    QObject::tr("界面固化测量参数"),
    QObject::tr("Modbus固化测量参数"),
    QObject::tr("开放测量参数"),
    QObject::tr("扩展功能"),
    QObject::tr("显示屏"),
    QObject::tr("屏幕保护"),
    QObject::tr("自动暗屏时间"),
    QObject::tr("自动关屏时间"),
    QObject::tr("登录保持时间"),
	QObject::tr("量程映射"),
    QObject::tr("调试"),
    QObject::tr("开发者模式"),
    QObject::tr("桥接模式"),
    QObject::tr("桥接IP"),
    QObject::tr("水质云"),
    QObject::tr("云服务"),
    QObject::tr("服务器"),
    QObject::tr("端口"),
    QObject::tr("秒"),
    QObject::tr("地表水1.0"),
    QObject::tr("地表水0.5"),
    QObject::tr("负值修正"),
    QObject::tr("异常重测"),
    QObject::tr("干节点触发"),
    QObject::tr("多语言支持"),
    QObject::tr("HJ212上报"),
    QObject::tr("协议类型"),
    QObject::tr("上报间隔"),
    QObject::tr("打印机"),
    QObject::tr("打印功能"),
    QObject::tr("IP地址"),
    QObject::tr("自动打印"),
    ///*****维护界面*****///
    QObject::tr("维护"),
    QObject::tr("测量水样"),
    QObject::tr("校准"),
    QObject::tr("测标准液(核查)"),
    QObject::tr("测空白水"),
    QObject::tr("加标回收"),
    QObject::tr("平行测量"),
    QObject::tr("清洗定量管"),
    QObject::tr("清洗消解室"),
    QObject::tr("深度清洗"),
    QObject::tr("清洗所有管路"),
    QObject::tr("采集水样"),
    QObject::tr("定量泵自动校准"),
    QObject::tr("量程二校准"),
    QObject::tr("量程三校准"),
    QObject::tr("量程四校准"),
    QObject::tr("量程五校准"),
    QObject::tr("零点校准"),
    QObject::tr("标点校准"),
    QObject::tr("标点二校准"),
    QObject::tr("定量AD调节"),
    QObject::tr("测量AD调节"),
    QObject::tr("测加标样(外部)"),
    QObject::tr("测平行样(外部)"),
    QObject::tr("量程(标样)核查"),
    QObject::tr("一键更新试剂"),
    ///*****试剂管理*****///
    QObject::tr("试剂管理"),
    QObject::tr("标准液"),
    QObject::tr("空白水"),
    QObject::tr("零点核查液"),
    QObject::tr("量程核查液"),
    QObject::tr("废液桶"),
    QObject::tr("废水桶"),
    QObject::tr("试剂一"),
    QObject::tr("试剂二"),
    QObject::tr("试剂三"),
    QObject::tr("试剂四"),
    QObject::tr("试剂五"),
    QObject::tr("试剂六"),
    QObject::tr("滴定液"),
    QObject::tr("清洗液"),
    QObject::tr("更换标液"),
    QObject::tr("更换标液二"),
    QObject::tr("更换标准液"),
    QObject::tr("更换空白水"),
    QObject::tr("更换零点核查液"),
    QObject::tr("更换量程核查液"),
    QObject::tr("更换废液桶"),
    QObject::tr("更换废水桶"),
    QObject::tr("更换废液"),
    QObject::tr("更换废水"),
    QObject::tr("更换试剂一"),
    QObject::tr("更换试剂二"),
    QObject::tr("更换试剂三"),
    QObject::tr("更换试剂四"),
    QObject::tr("更换试剂五"),
    QObject::tr("更换试剂六"),
    QObject::tr("更换滴定液"),
    QObject::tr("更换清洗液"),
    ///*****耗材管理*****///
    QObject::tr("耗材管理"),
    QObject::tr("蠕动泵软管"),
    QObject::tr("夹断阀软管"),
    QObject::tr("计量管"),
    QObject::tr("计量O型圈"),
    QObject::tr("计量O形圈"),
    QObject::tr("PTFE硬管"),
    QObject::tr("紫外灯"),
    QObject::tr("更换蠕动泵软管"),
    QObject::tr("更换夹断阀软管"),
    QObject::tr("更换计量管"),
    QObject::tr("更换计量O型圈"),
    QObject::tr("更换计量O形圈"),
    QObject::tr("更换PTFE硬管"),
    QObject::tr("更换紫外灯"),
    ///*****管道操作*****///
    QObject::tr("填充水样"),
    QObject::tr("填充标液"),
    QObject::tr("填充标液二"),
    QObject::tr("填充零点核查液"),
    QObject::tr("填充量程核查液"),
    QObject::tr("填充空白水"),
    QObject::tr("填充试剂一"),
    QObject::tr("填充试剂二"),
    QObject::tr("填充试剂三"),
    QObject::tr("填充试剂四"),
    QObject::tr("填充试剂五"),
    QObject::tr("填充试剂六"),
    QObject::tr("吸消解器溶液"),
    QObject::tr("排至废液"),
    QObject::tr("排至废液桶"),
    QObject::tr("排至废水"),
    QObject::tr("排至废水桶"),
    QObject::tr("排至消解室"),
    QObject::tr("排至水样管"),
    QObject::tr("排至标液管"),
    QObject::tr("排至标液二管"),
    QObject::tr("排至零点核查液管"),
    QObject::tr("排至量程核查液管"),
    QObject::tr("排至空白水管"),
    QObject::tr("排至试剂一管"),
    QObject::tr("排至试剂二管"),
    QObject::tr("排至试剂三管"),
    QObject::tr("排至试剂四管"),
    QObject::tr("排至试剂五管"),
    QObject::tr("排至试剂六管"),
    QObject::tr("填充试剂二(备用)"),
    QObject::tr("排至试剂二管(备用)"),
    ///*****组合操作*****///
    QObject::tr("组合操作"),
    QObject::tr("吸空白水至消解室"),
    QObject::tr("排消解液至废液"),
    QObject::tr("排消解液至废水"),
    QObject::tr("气密性检查"),
    QObject::tr("测量池排废液"),
    QObject::tr("加试剂二至消解室(精确)"),
    QObject::tr("加试剂二至消解室(双重)"),
    QObject::tr("加试剂一至消解室(精确)"),
    QObject::tr("一键加热"),
    QObject::tr("一键加热(消解室)"),
    QObject::tr("一键加热(测量池)"),
    QObject::tr("一键加热(逐出室)"),
    ///*****硬件校准*****///
    QObject::tr("硬件校准"),
    QObject::tr("泵校准"),
    QObject::tr("泵一校准"),
    QObject::tr("泵二校准"),
    QObject::tr("泵三校准"),
    QObject::tr("泵四校准"),
    QObject::tr("定量泵"),
    QObject::tr("附加泵"),
    QObject::tr("废液泵"),
    QObject::tr("滴定泵"),
    QObject::tr("温度校准"),
    QObject::tr("负输入分压"),
    QObject::tr("参考电压"),
    QObject::tr("校准电压"),
    QObject::tr("定量校准"),
    QObject::tr("定量体积校准"),
    QObject::tr("定量点1"),
    QObject::tr("定量点2"),
    QObject::tr("恒温器PID"),
    QObject::tr("比例系数"),
    QObject::tr("积分系数"),
    QObject::tr("微分系数"),
    QObject::tr("定量AD校准", "Hardware"),
    QObject::tr("定量一"),
    QObject::tr("定量二"),
    QObject::tr("测量AD校准", "Hardware"),
    QObject::tr("参考端"),
    QObject::tr("测量端"),
    QObject::tr("参考端AD"),
    QObject::tr("测量端AD"),
    QObject::tr("LED目标AD"),
    QObject::tr("LED默认输出"),
    QObject::tr("定量LED光强"),
    QObject::tr("LED1光强"),
    QObject::tr("LED2光强"),
    QObject::tr("设置泵校准失败\n"),
    QObject::tr("驱动板连接断开,\n设置泵校准失败\n"),
    QObject::tr("设置温度校准系数失败\n"),
    QObject::tr("驱动板连接断开,\n设置温度校准系数失败\n"),
    QObject::tr("设置定量点失败\n"),
    QObject::tr("驱动板连接断开,\n设置定量点失败\n"),
    QObject::tr("上下位机定量点同步成功。"),
    QObject::tr("上下位机定量点同步失败。"),
    QObject::tr("设置恒温器PID失败\n"),
    QObject::tr("驱动板连接断开,\n设置恒温器PID失败\n"),
    QObject::tr("同步恒温器PID失败。"),
    QObject::tr("同步恒温器PID成功。"),
    QObject::tr("定量AD校准失败\n"),
    QObject::tr("驱动板连接断开,\n定量AD校准失败\n"),
    QObject::tr("测量AD校准失败\n"),
    QObject::tr("驱动板连接断开,\n测量AD校准失败\n"),
    QObject::tr("ml/步"),
    QObject::tr("万"),
    QObject::tr("定量LED光强修改失败\n"),
    QObject::tr("驱动板连接断开,\n定量LED光强修改失败\n"),

    ///*****智能诊断*****///
    QObject::tr("智能诊断"),
    QObject::tr("空白水阀"),
    QObject::tr("水样阀"),
    QObject::tr("标液阀"),
    QObject::tr("标液二阀"),
    QObject::tr("零点核查阀"),
    QObject::tr("量程核查阀"),
    QObject::tr("试剂一阀"),
    QObject::tr("试剂二阀"),
    QObject::tr("试剂三阀"),
    QObject::tr("试剂四阀"),
    QObject::tr("试剂五阀"),
    QObject::tr("试剂六阀"),
    QObject::tr("消解室阀"),
    QObject::tr("测量池阀"),
    QObject::tr("逐出室阀"),
    QObject::tr("废液阀"),
    QObject::tr("废水阀"),
    QObject::tr("透气阀"),
    QObject::tr("逐气阀"),
    QObject::tr("定量模块"),
    QObject::tr("测量模块"),
    QObject::tr("加热模块"),
    QObject::tr("冷却模块"),
    QObject::tr("消解加热模块"),
    QObject::tr("消解冷却模块"),
    QObject::tr("测量加热模块"),
    QObject::tr("测量冷却模块"),
    QObject::tr("停止"),
    QObject::tr("通过"),
    QObject::tr("未通过"),
    QObject::tr("诊断中..."),
    QObject::tr("智能冷却模块诊断结束"),
    QObject::tr("智能加热模块诊断结束"),
    QObject::tr("智能测量模块诊断结束"),
    QObject::tr("智能定量模块诊断结束"),
    QObject::tr("智能阀诊断结束"),
    ///*****通信检测*****///
    QObject::tr("通信检测"),
    QObject::tr("板卡通信"),
    QObject::tr("驱动板"),
    QObject::tr("液路板"),
    QObject::tr("温控板"),
    QObject::tr("信号板"),
    QObject::tr("反应板"),
    QObject::tr("测试中"),
    QObject::tr("未通过"),
    QObject::tr("通过"),
    ///*****硬件测试*****///
    QObject::tr("硬件测试"),
    QObject::tr("泵组"),
    QObject::tr("定量泵"),
    QObject::tr("阀组"),
    QObject::tr("水样阀"),
    QObject::tr("试剂一阀"),
    QObject::tr("试剂二阀"),
    QObject::tr("试剂三阀"),
    QObject::tr("试剂四阀"),
    QObject::tr("试剂五阀"),
    QObject::tr("试剂六阀"),
    QObject::tr("标准液阀"),
    QObject::tr("标准液二阀"),
    QObject::tr("空白水阀"),
    QObject::tr("零点核查液阀"),
    QObject::tr("量程核查液阀"),
    QObject::tr("废液阀"),
    QObject::tr("废水阀"),
    QObject::tr("消解室上阀"),
    QObject::tr("消解室下阀"),
    QObject::tr("消解模块"),
    QObject::tr("消解加热"),
    QObject::tr("消解风扇"),
    QObject::tr("测量模块"),
    QObject::tr("测量LED"),
    QObject::tr("光学定量"),
    QObject::tr("定量点一LED"),
    QObject::tr("定量点二LED"),
    QObject::tr("继电器"),
    QObject::tr("采水继电器"),
    QObject::tr("继电器1"),
    QObject::tr("继电器2"),
    QObject::tr("样品4-20mA"),
    QObject::tr("4mA输出"),
    QObject::tr("12mA输出"),
    QObject::tr("20mA输出"),
    QObject::tr("温度监控"),
    QObject::tr("机箱风扇"),
    QObject::tr("泵一"),
    QObject::tr("泵二"),
    QObject::tr("泵三"),
    QObject::tr("泵四"),
    QObject::tr("泵一(定量泵)"),
    QObject::tr("泵二(滴定泵)"),
    QObject::tr("泵三(废液泵)"),
    QObject::tr("泵四(搅拌泵)"),
    QObject::tr("搅拌电机"),
    QObject::tr("清洗液阀"),
    QObject::tr("消解测量池阀"),
    QObject::tr("滴定电极"),
    ///*****升级界面*****///
    QObject::tr("升级"),
    QObject::tr("主控板"),
    ///*****仪器信息*****///
    QObject::tr("仪器信息"),
    QObject::tr("深圳市朗石科学仪器有限公司"),
    QObject::tr("化学需氧量水质自动在线监测仪"),
    QObject::tr("化学需氧量水质自动在线监测仪(高氯版)"),
    QObject::tr("化学需氧量"),
    QObject::tr("氨氮水质自动在线监测仪"),
    QObject::tr("氨氮水质自动在线监测仪(水杨酸法)"),
    QObject::tr("氨氮"),
    QObject::tr("总磷水质自动在线监测仪"),
    QObject::tr("总磷"),
    QObject::tr("总氮水质自动在线监测仪"),
    QObject::tr("总氮水质自动在线监测仪(紫外法)"),
    QObject::tr("总氮"),
    QObject::tr("硝酸盐氮水质自动在线监测仪"),
    QObject::tr("硝酸盐氮"),
    QObject::tr("高锰酸盐水质自动在线监测仪"),
    QObject::tr("高锰酸盐"),
    QObject::tr("高锰酸盐指数水质自动在线监测仪"),
    QObject::tr("高锰酸盐指数"),
    QObject::tr("六价铬"),
    QObject::tr("六价铬水质自动在线监测仪"),
    QObject::tr("铜"),
    QObject::tr("铜水质自动在线监测仪"),
    QObject::tr("总铜"),
    QObject::tr("总铜水质自动在线监测仪"),
    QObject::tr("镍"),
    QObject::tr("镍水质自动在线监测仪"),
    QObject::tr("总镍"),
    QObject::tr("总镍水质自动在线监测仪"),
    QObject::tr("总锰"),
    QObject::tr("总锰水质自动在线监测仪"),
    QObject::tr("总铁"),
    QObject::tr("总铁水质自动在线监测仪"),
    QObject::tr("总锌"),
    QObject::tr("总锌水质自动在线监测仪"),
    QObject::tr("总铬"),
    QObject::tr("总铬水质自动在线监测仪"),
    QObject::tr("总镉"),
    QObject::tr("总镉水质自动在线监测仪"),
    QObject::tr("总银"),
    QObject::tr("总银水质自动在线监测仪"),
    QObject::tr("总砷"),
    QObject::tr("总砷水质自动在线监测仪"),
    QObject::tr("总汞"),
    QObject::tr("总汞水质自动在线监测仪"),
    QObject::tr("氰化物"),
    QObject::tr("氰化物水质自动在线监测仪"),
    QObject::tr("总氰化物"),
    QObject::tr("总氰化物水质自动在线监测仪"),
    QObject::tr("氟化物"),
    QObject::tr("氟化物水质自动在线监测仪"),
    QObject::tr("余氯"),
    QObject::tr("余氯水质自动在线监测仪"),
    QObject::tr("余(总)氯"),
    QObject::tr("余(总)氯水质自动在线监测仪"),
    ///*****板卡信息*****///
    QObject::tr("板卡信息"),
    ///*****网络设置*****///
    QObject::tr("网络设置"),
    ///*****系统时间*****///
    QObject::tr("系统时间"),
    ///*****系统设置*****///
    QObject::tr("系统设置"),
    QObject::tr("系统日志导出"),
    QObject::tr("系统日志清除"),
    ///*****状态*****///
    QObject::tr("空闲"),
    QObject::tr("测水样"),
    QObject::tr("测量水样"),
    QObject::tr("测标液"),
    QObject::tr("测标准液"),
    QObject::tr("测量标准液"),
    QObject::tr("测标液二"),
    QObject::tr("测标准液二"),
    QObject::tr("测量标准液二"),
    QObject::tr("测空白"),
    QObject::tr("测空白水"),
    QObject::tr("测量空白水"),
    QObject::tr("校准"),
    QObject::tr("标定"),
    QObject::tr("清洗消解室"),
    QObject::tr("清洗消解器"),
    QObject::tr("清洗定量管"),
    QObject::tr("清洗所有管路"),
    QObject::tr("采水样"),
    QObject::tr("采集水样"),
    QObject::tr("一键运行"),
    QObject::tr("消解室冷却"),
    QObject::tr("泵校准"),
    QObject::tr("自动泵校准"),
    QObject::tr("定量泵校准"),
    QObject::tr("管道操作"),
    QObject::tr("智能诊断"),
    QObject::tr("通信检测"),
    QObject::tr("硬件测试"),
    QObject::tr("主控板升级"),
    QObject::tr("驱动板升级"),
    QObject::tr("液路板升级"),
    QObject::tr("温控板升级"),
    QObject::tr("信号板升级"),
    QObject::tr("反应板升级"),
    QObject::tr("主控板升级成功"),
    QObject::tr("驱动板升级成功"),
    QObject::tr("液路板升级成功"),
    QObject::tr("温控板升级成功"),
    QObject::tr("信号板升级成功"),
    QObject::tr("反应板升级成功"),
    QObject::tr("主控板升级失败"),
    QObject::tr("驱动板升级失败"),
    QObject::tr("液路板升级失败"),
    QObject::tr("温控板升级失败"),
    QObject::tr("信号板升级失败"),
    QObject::tr("反应板升级失败"),
    QObject::tr("深度清洗"),
    QObject::tr("量程一校准"),
    QObject::tr("量程二校准"),
    QObject::tr("量程三校准"),
    QObject::tr("量程四校准"),
    QObject::tr("量程五校准"),
    QObject::tr("预处理清洗"),
    QObject::tr("一键填充试剂一"),
    QObject::tr("组合操作"),
    QObject::tr("零点校准"),
    QObject::tr("标点校准"),
    QObject::tr("零点核查"),
    QObject::tr("量程核查"),
    QObject::tr("跨度核查"),
    QObject::tr("测加标"),
    QObject::tr("测加标样"),
    QObject::tr("加标回收"),
    QObject::tr("测平行"),
    QObject::tr("测平行样"),
    QObject::tr("平行回收"),
    QObject::tr("定量AD调节"),
    QObject::tr("定量AD校准"),
    QObject::tr("定量模块校准"),
    QObject::tr("测量模块校准"),
    QObject::tr("定量模块AD校准"),
    QObject::tr("测量AD调节"),
    QObject::tr("测量AD校准"),
    QObject::tr("测量模块AD校准"),
    QObject::tr("补偿AD校准"),
    QObject::tr("故障"),
    ///*****动作*****///
    QObject::tr("空闲"),
    QObject::tr("测量前排液"),
    QObject::tr("测量后排液"),
    QObject::tr("测量前清洗"),
    QObject::tr("测量后清洗"),
    QObject::tr("读初始值"),
    QObject::tr("读反应值"),
    QObject::tr("读空白值"),
    QObject::tr("润洗"),
    QObject::tr("加待测样"),
    QObject::tr("加试剂一"),
    QObject::tr("加试剂二"),
    QObject::tr("加试剂三"),
    QObject::tr("加试剂四"),
    QObject::tr("加试剂五"),
    QObject::tr("加试剂六"),
    QObject::tr("定量管清洗"),
    QObject::tr("预热"),
    QObject::tr("消解"),
    QObject::tr("反应"),
    QObject::tr("消解液预热"),
    QObject::tr("加热消解"),
    QObject::tr("消解加热"),
    QObject::tr("消解冷却"),
    QObject::tr("清洗"),
    QObject::tr("冷却"),
    QObject::tr("采水"),
    QObject::tr("静置"),
    QObject::tr("填充空白水"),
    QObject::tr("排至空白水管"),
    QObject::tr("填充水样"),
    QObject::tr("排至水样管"),
    QObject::tr("填充标液"),
    QObject::tr("排至标液管"),
    QObject::tr("填充标液二"),
    QObject::tr("排至标液二管"),
    QObject::tr("填充滴定管"),
    QObject::tr("排至滴定管"),
    QObject::tr("填充清洗液"),
    QObject::tr("排至清洗液管"),
    QObject::tr("填充试剂一"),
    QObject::tr("排至试剂一管"),
    QObject::tr("填充试剂二"),
    QObject::tr("排至试剂二管"),
    QObject::tr("填充试剂三"),
    QObject::tr("排至试剂三管"),
    QObject::tr("填充试剂四"),
    QObject::tr("排至试剂四管"),
    QObject::tr("填充试剂五"),
    QObject::tr("排至试剂五管"),
    QObject::tr("填充试剂六"),
    QObject::tr("排至试剂六管"),
    QObject::tr("填充试剂1"),
    QObject::tr("排至试剂1管"),
    QObject::tr("填充试剂2"),
    QObject::tr("排至试剂2管"),
    QObject::tr("填充试剂3"),
    QObject::tr("排至试剂3管"),
    QObject::tr("填充试剂4"),
    QObject::tr("排至试剂4管"),
    QObject::tr("填充试剂5"),
    QObject::tr("排至试剂5管"),
    QObject::tr("填充试剂6"),
    QObject::tr("排至试剂6管"),
    QObject::tr("吸消解室溶液"),
    QObject::tr("排至消解室"),
    QObject::tr("吸消解器溶液"),
    QObject::tr("排至消解器"),
    QObject::tr("排至测量池"),
    QObject::tr("排至消解测量池"),
    QObject::tr("测量池排废液"),
    QObject::tr("排至废液"),
    QObject::tr("排至废水"),
    QObject::tr("加热模块诊断"),
    QObject::tr("制冷模块诊断"),
    QObject::tr("冷却模块诊断"),
    QObject::tr("测量模块诊断"),
    QObject::tr("定量模块诊断"),
    QObject::tr("空白水阀诊断"),
    QObject::tr("水样阀诊断"),
    QObject::tr("标液阀诊断"),
    QObject::tr("标液二阀诊断"),
    QObject::tr("标准液阀诊断"),
    QObject::tr("标准液二阀诊断"),
    QObject::tr("清洗液阀诊断"),
    QObject::tr("零点核查液阀诊断"),
    QObject::tr("量程核查液阀诊断"),
    QObject::tr("试剂一阀诊断"),
    QObject::tr("试剂二阀诊断"),
    QObject::tr("试剂三阀诊断"),
    QObject::tr("试剂四阀诊断"),
    QObject::tr("试剂五阀诊断"),
    QObject::tr("试剂六阀诊断"),
    QObject::tr("消解室阀诊断"),
    QObject::tr("消解器阀诊断"),
    QObject::tr("废液阀诊断"),
    QObject::tr("废水阀诊断"),
    QObject::tr("泵测试"),
    QObject::tr("定量泵测试"),
    QObject::tr("滴定泵测试"),
    QObject::tr("试剂一泵测试"),
    QObject::tr("废液泵测试"),
    QObject::tr("搅拌泵测试"),
    QObject::tr("空白水阀测试"),
    QObject::tr("水样阀测试"),
    QObject::tr("标液阀测试"),
    QObject::tr("标液二阀测试"),
    QObject::tr("标准液阀测试"),
    QObject::tr("标准液二阀测试"),
    QObject::tr("清洗液阀测试"),
    QObject::tr("进液阀测试"),
    QObject::tr("试剂一阀测试"),
    QObject::tr("试剂二阀测试"),
    QObject::tr("试剂三阀测试"),
    QObject::tr("试剂四阀测试"),
    QObject::tr("试剂五阀测试"),
    QObject::tr("试剂六阀测试"),
    QObject::tr("消解室上阀测试"),
    QObject::tr("消解室下阀测试"),
    QObject::tr("消解器上阀测试"),
    QObject::tr("消解器下阀测试"),
    QObject::tr("消解上阀测试"),
    QObject::tr("消解下阀测试"),
    QObject::tr("废液阀测试"),
    QObject::tr("废水阀测试"),
    QObject::tr("零点核查液阀测试"),
    QObject::tr("量程核查液阀测试"),
    QObject::tr("加热测试"),
    QObject::tr("制冷测试"),
    QObject::tr("冷却测试"),
    QObject::tr("消解加热测试"),
    QObject::tr("消解冷却测试"),
    QObject::tr("测量LED"),
    QObject::tr("定量点一LED"),
    QObject::tr("定量点二LED"),
    QObject::tr("机箱风扇"),
    QObject::tr("机箱冷却"),
    QObject::tr("机箱风扇测试"),
    QObject::tr("消解风扇测试"),
    QObject::tr("采水继电器"),
    QObject::tr("继电器1"),
    QObject::tr("继电器2"),
    QObject::tr("样品4mA输出"),
    QObject::tr("样品12mA输出"),
    QObject::tr("样品20mA输出"),
    QObject::tr("核查4mA输出"),
    QObject::tr("核查12mA输出"),
    QObject::tr("核查20mA输出"),
    QObject::tr("驱动板检测"),
    QObject::tr("复制"),
    QObject::tr("升级"),
    QObject::tr("擦除"),
    QObject::tr("烧写"),
    QObject::tr("清空残留液"),
    QObject::tr("清空空白水管"),
    QObject::tr("清空标液管"),
    QObject::tr("清空标液二管"),
    QObject::tr("清空零点核查液管"),
    QObject::tr("清空量程核查液管"),
    QObject::tr("清空试剂一管"),
    QObject::tr("清空试剂二管"),
    QObject::tr("清空试剂三管"),
    QObject::tr("清空试剂四管"),
    QObject::tr("清空试剂五管"),
    QObject::tr("清空试剂六管"),
    QObject::tr("清空水样管"),
    QObject::tr("清空滴定管"),
    QObject::tr("清空清洗液管"),
    QObject::tr("清洗水样管"),
    QObject::tr("清洗空白水管"),
    QObject::tr("清洗标液管"),
    QObject::tr("清洗标液二管"),
    QObject::tr("清洗零点核查液管"),
    QObject::tr("清洗量程核查液管"),
    QObject::tr("清洗试剂一管"),
    QObject::tr("清洗试剂二管"),
    QObject::tr("清洗试剂三管"),
    QObject::tr("清洗试剂四管"),
    QObject::tr("清洗试剂五管"),
    QObject::tr("清洗试剂六管"),
    QObject::tr("清洗滴定管"),
    QObject::tr("清洗清洗液管"),
    QObject::tr("排空水样管"),
    QObject::tr("排空空白水管"),
    QObject::tr("排空标液管"),
    QObject::tr("排空标液二管"),
    QObject::tr("排空零点核查液管"),
    QObject::tr("排空量程核查液管"),
    QObject::tr("排空试剂一管"),
    QObject::tr("排空试剂二管"),
    QObject::tr("排空试剂三管"),
    QObject::tr("排空试剂四管"),
    QObject::tr("排空试剂五管"),
    QObject::tr("排空试剂六管"),
    QObject::tr("排空废液管"),
    QObject::tr("排空废水管"),
    QObject::tr("排空滴定管"),
    QObject::tr("排空清洗液管"),
    QObject::tr("吸空白水至消解室"),
    QObject::tr("排消解液至废液"),
    QObject::tr("排消解液至废水"),
    QObject::tr("吸空白水至测量池"),
    QObject::tr("排测量池至废液"),
    QObject::tr("排测量池至废水"),
    QObject::tr("吸空白水至逐出室"),
    QObject::tr("排逐出液至废液"),
    QObject::tr("排逐出液至废水"),
    QObject::tr("清洗测量池"),
    QObject::tr("排空测量池"),
    QObject::tr("气密性检查"),
    QObject::tr("定量AD调节"),
    QObject::tr("测量AD调节"),
    QObject::tr("定量管排至废液"),
    QObject::tr("定量管排至废水"),
    QObject::tr("定量管排至废液桶"),
    QObject::tr("定量管排至废水桶"),
    QObject::tr("升级中"),
    QObject::tr("采集"),
    QObject::tr("下载"),
    QObject::tr("解压"),
    QObject::tr("冲洗消解室"),
    QObject::tr("老化"),
    QObject::tr("高速闪烁"),
    QObject::tr("滴定"),
    QObject::tr("滴定预处理"),
    QObject::tr("加待测样一"),
    QObject::tr("加待测样二"),
    QObject::tr("滴定前恒温"),
    QObject::tr("加试剂一至消解室"),
    QObject::tr("加试剂二至消解室"),
    QObject::tr("加液"),
    QObject::tr("恒温"),
    QObject::tr("排液"),
    QObject::tr("测量池冷却"),
    QObject::tr("测量池预热"),
    QObject::tr("一键填充滴定管"),
    QObject::tr("滴定泵手动校准"),
    QObject::tr("手动泵校准"),
    QObject::tr("读初始值清洗"),
    QObject::tr("读初始值前清洗"),
    ///*****告警*****///
    QObject::tr("抽取失败"),
    QObject::tr("抽取被停止"),
    QObject::tr("光学采集失败"),
    QObject::tr("光学采集被停止"),
    QObject::tr("请更换试剂"),
    QObject::tr("耗材已过期"),
    QObject::tr("温控故障"),
    QObject::tr("恒温被停止"),
    QObject::tr("DncpStack失败"),
    QObject::tr("通信异常"),
    QObject::tr("升级失败"),
    QObject::tr("用户停止"),
    QObject::tr("仪器运行故障"),
    QObject::tr("排消解液异常"),
    QObject::tr("消解室加液异常"),
    QObject::tr("蠕动泵校准失败"),
    QObject::tr("水样超标"),
    QObject::tr("水样超上限"),
    QObject::tr("水样超下限"),
    QObject::tr("水样超量程"),
    QObject::tr("量程切换"),
    QObject::tr("校准结果错误"),
    QObject::tr("校准结果错误"),
    QObject::tr("系统异常"),
    QObject::tr("std异常"),
    QObject::tr("静态AD调节失败"),
    QObject::tr("静态AD调节被停止"),
    QObject::tr("泵操作异常"),
    QObject::tr("恒温异常"),
    QObject::tr("恒温失败异常"),
    QObject::tr("恒温超时异常"),
    QObject::tr("光学采集异常"),
    QObject::tr("废液"),
    QObject::tr("废水"),
    QObject::tr("抽"),
    QObject::tr("排"),
    QObject::tr("自动恒温"),
    QObject::tr("加热"),
    QObject::tr("自然冷却"),
    QObject::tr("度"),
    QObject::tr("外部"),
    QObject::tr("外"),
    QObject::tr("内"),
    QObject::tr("定量"),
    QObject::tr("事件"),
    QObject::tr("命令"),
    QObject::tr("校准完成"),
    QObject::tr("校准总时间"),
    QObject::tr("泵抽"),
    QObject::tr("泵排"),
    QObject::tr("抽"),
    QObject::tr("排"),
    QObject::tr("失败"),
    QObject::tr("溢出"),
    QObject::tr("抽取不上"),
    QObject::tr("出现气泡"),
    QObject::tr("事件超时"),
    QObject::tr("传感器异常"),
    QObject::tr("目标"),
    QObject::tr("消解混合液"),
    QObject::tr("消解器排液完成"),
    QObject::tr("消解器排液异常"),
    QObject::tr("泵校准失败"),
    QObject::tr("定量泵校准失败"),
    QObject::tr("超时"),
    QObject::tr("滴定异常"),
    QObject::tr("滴定被停止异常"),
    QObject::tr("滴定超出最大体积异常"),
    QObject::tr("标线结果计算异常"),
    QObject::tr("滴定被停止"),
    QObject::tr("滴定失败"),
    QObject::tr("滴定被终止"),
    QObject::tr("滴定结束"),
    QObject::tr("运行权限"),
    QObject::tr("过期"),
    ///*****日志*****///
    QObject::tr("用户终止"),
    QObject::tr("测量完成"),
    QObject::tr("校准完成"),
    QObject::tr("一键运行完成"),
    QObject::tr("零点校准完成"),
    QObject::tr("标点校准完成"),
    QObject::tr("标点二校准完成"),
    QObject::tr("量程[1]校准完成"),
    QObject::tr("量程[2]校准完成"),
    QObject::tr("量程[3]校准完成"),
    QObject::tr("量程[4]校准完成"),
    QObject::tr("量程[5]校准完成"),
    QObject::tr("清洗流程总时间"),
    QObject::tr("测量流程总时间"),
    QObject::tr("校准总时间"),
    QObject::tr("一键运行总时间"),
    QObject::tr("零点校准总时间"),
    QObject::tr("标点校准总时间"),
    QObject::tr("标点二校准总时间"),
    QObject::tr("量程[1]校准总时间"),
    QObject::tr("量程[2]校准总时间"),
    QObject::tr("量程[3]校准总时间"),
    QObject::tr("量程[4]校准总时间"),
    QObject::tr("量程[5]校准总时间"),
    QObject::tr("量程自动切换至1"),
    QObject::tr("量程自动切换至2"),
    QObject::tr("量程自动切换至3"),
    QObject::tr("量程自动切换至4"),
    QObject::tr("量程自动切换至5"),
    QObject::tr("水样超量程下限"),
    QObject::tr("水样超量程上限"),
    QObject::tr("测量AD校准完成"),
    QObject::tr("定量AD校准完成"),
    QObject::tr("测量AD调节完成"),
    QObject::tr("定量AD调节完成"),
    QObject::tr("测量AD校准结束"),
    QObject::tr("定量AD校准结束"),
    QObject::tr("测量AD调节结束"),
    QObject::tr("定量AD调节结束"),
    QObject::tr("测量模块校准结束"),
    QObject::tr("定量模块校准结束"),
    QObject::tr("下位机板卡AD调节功能无效"),
    QObject::tr("AD调节功能无效"),
    QObject::tr("参考端AD调节成功"),
    QObject::tr("参考端AD调节失败"),
    QObject::tr("测量端AD调节成功"),
    QObject::tr("测量端AD调节失败"),
    QObject::tr("定量点1AD调节成功"),
    QObject::tr("定量点1AD调节失败"),
    QObject::tr("定量点2AD调节成功"),
    QObject::tr("定量点2AD调节失败"),
    QObject::tr("泵校准结束"),
    QObject::tr("定量泵校准结束"),
    QObject::tr("自动泵校准结束"),
    QObject::tr("手动泵校准结束"),
    QObject::tr("清洗完成"),
    QObject::tr("采集水样结束"),
    QObject::tr("组合操作结束"),
    QObject::tr("通信检测结束"),
    QObject::tr("管道操作结束"),
    QObject::tr("管路操作结束"),
    QObject::tr("智能冷却模块诊断结束"),
    QObject::tr("智能加热模块诊断结束"),
    QObject::tr("智能测量模块诊断结束"),
    QObject::tr("智能定量模块诊断结束"),
    QObject::tr("智能阀诊断结束"),
    QObject::tr("恢复默认测量排期"),
    QObject::tr("测量排期恢复默认"),
    QObject::tr("修改测量排期"),
    QObject::tr("恢复默认系统参数"),
    QObject::tr("系统参数恢复默认"),
    QObject::tr("系统参数恢复默认参数"),
    QObject::tr("修改系统参数"),
    QObject::tr("恢复默认测量参数"),
    QObject::tr("测量参数恢复默认"),
    QObject::tr("测量参数恢复默认参数"),
    QObject::tr("修改测量参数"),
    QObject::tr("恢复默认外联接口"),
    QObject::tr("外联接口恢复默认"),
    QObject::tr("外联接口恢复默认参数"),
    QObject::tr("修改外联接口"),
    QObject::tr("故障终止"),
    QObject::tr("清除停机故障"),
    QObject::tr("清除故障"),
    QObject::tr("下载失败"),
    QObject::tr("校准数据导出成功"),
    QObject::tr("校准数据导出失败"),
    QObject::tr("测量数据导出成功"),
    QObject::tr("测量数据导出失败"),
    QObject::tr("日志导出成功"),
    QObject::tr("日志导出失败"),
    QObject::tr("日志数据导出成功"),
    QObject::tr("日志数据导出失败"),
    QObject::tr("告警数据导出成功"),
    QObject::tr("告警数据导出失败"),
    QObject::tr("普通用户登录"),
    QObject::tr("运维员登录"),
    QObject::tr("管理员登录"),
    QObject::tr("工程师登录"),
    QObject::tr("超级管理员登录"),
    QObject::tr("普通用户"),
    QObject::tr("运维员"),
    QObject::tr("管理员"),
    QObject::tr("工程师"),
    QObject::tr("超级管理员"),
    QObject::tr("修改硬件校准参数"),
    QObject::tr("硬件测试结束"),
    QObject::tr("一键清除数据"),
    QObject::tr("一键恢复出厂设置"),
    QObject::tr("恢复默认密码"),
    QObject::tr("触摸屏校准"),
    QObject::tr("系统设置"),
    QObject::tr("激活出厂模式"),
    QObject::tr("主控板软件升级成功"),
    QObject::tr("主控板软件升级失败"),
    QObject::tr("曲线数据异常"),
    QObject::tr("曲线导出失败"),
    QObject::tr("曲线导出成功"),
    QObject::tr("温度校准成功"),
    QObject::tr("温度校准失败"),
    QObject::tr("温度校准流程结束"),
    QObject::tr("参考端AD正常"),
    QObject::tr("测量端AD正常"),
    QObject::tr("定量点"),
    QObject::tr("AD调节成功"),
    QObject::tr("AD调节失败"),
    QObject::tr("量程自动切换至"),
    QObject::tr("更改"),
    QObject::tr("双光路模式"),
    QObject::tr("温控模块"),
    QObject::tr("消解室加热"),
    QObject::tr("测量池加热"),
    QObject::tr("逐出室加热"),
    QObject::tr("消解室温度"),
    QObject::tr("消解器温度"),
    QObject::tr("逐出室温度"),
    QObject::tr("测量池温度"),
    QObject::tr("消解室温控"),
    QObject::tr("消解器温控"),
    QObject::tr("逐出室温控"),
    QObject::tr("测量池温控"),
    QObject::tr("试剂三温控"),
    QObject::tr("慢加热功率"),
    QObject::tr("试剂三加热功率"),
    QObject::tr("试剂三预热温度"),
    QObject::tr("试剂三恒温温度"),
    QObject::tr("试剂三恒温时间"),
    QObject::tr("试剂三加热冒泡速度"),
    QObject::tr("试剂三恒温冒泡速度"),
    QObject::tr("步/秒"),
    QObject::tr("消解器加热丝"),
    QObject::tr("逐出室加热丝"),
    QObject::tr("测量池加热丝"),
    QObject::tr("冷却泵"),
    QObject::tr("泵速"),
    QObject::tr("冷却泵速度"),
    QObject::tr("逐气速度"),
    QObject::tr("消解室清洗"),
    QObject::tr("逐出室清洗"),
    QObject::tr("测量池清洗"),
    QObject::tr("测量前"),
    QObject::tr("测量后"),
    QObject::tr("加热丝功率"),
    QObject::tr("风扇功率"),
    QObject::tr("参数更改记录"),
    QObject::tr("数据上报"),
    QObject::tr("串口协议"),
    QObject::tr("分"),
    QObject::tr("分钟"),
    QObject::tr("开"),
    QObject::tr("关"),
    QObject::tr("成功"),
    QObject::tr("标样"),
    QObject::tr("系统日志导出成功"),
    QObject::tr("系统日志导出失败"),
};

#endif // COMMON_H
