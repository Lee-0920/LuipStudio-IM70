setting.ui.operation.motorOperator =
{
    name ="motorOperator",
    text= "电机操作",
    rowCount = 3,
    superRow = 0,
    administratorRow = 0,
    writePrivilege=  RoleType.Maintain,
    readPrivilege = RoleType.Maintain,
    -- row = 1
    {
        name = "MoveToZero",
        text= "移动至原点",
        data = 0,
        createFlow= function(step)
            local flow = MotorOperateFlow:new({}, setting.component.xPos.zero, step)
            flow.name = setting.ui.operation.motorOperator[1].name
            FlowList.AddFlow(flow)
        end,
        writePrivilege=  RoleType.Maintain,
        readPrivilege = RoleType.Maintain,
    },
    -- row = 2
    {
        name = "MoveToStoveCell",
        text= "X单点移动",
        data = 200,
        createFlow= function(step)
            local flow = MotorOperateFlow:new({}, setting.component.xPos.stoveCell, step)
            flow.name = setting.ui.operation.motorOperator[2].name
            FlowList.AddFlow(flow)
        end,
        writePrivilege=  RoleType.Maintain,
        readPrivilege = RoleType.Maintain,
    },   
    -- row = 2
    {
        name = "ExposureCell",
        text= "坐标移动",
        data = 200,
        createFlow= function(step)
            local flow = MotorOperateFlow:new({}, setting.component.xPos.exposureCell, step)
            flow.name = setting.ui.operation.motorOperator[3].name
            FlowList.AddFlow(flow)
        end,
        writePrivilege=  RoleType.Maintain,
        readPrivilege = RoleType.Maintain,
    },   

    checkvalue = function(value)
        local ret = false
        if type(value) == "string" then
            local integerPatterm = "^[-+]?%d?%d?%d?%d$"
            if string.find(value, integerPatterm) then
                local num = tonumber(value)
                ret = true
            end
        end

        return value
    end,
}
return setting.ui.operation.motorOperator
