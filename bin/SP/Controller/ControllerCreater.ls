
function  CreateControllers()
    local controllerManager = ControllerManager.Instance()
    for i, controller in pairs(setting.plugins.controllers) do
        local name = controller.name
        local text = controller.text
        local addr = DscpAddress.new(controller.address[1],  controller.address[2],  controller.address[3], controller.address[4])
        if type(name)  == "string" then
            if name == "TOCDriveControllerPlugin"then
                    dc = TOCDriveController.new(addr)
                    controllerManager:AddController(name, text, dc)
            elseif name == "LiquidControllerPlugin"then
                    lc = LiquidController.new(addr)
                    controllerManager:AddController(name, text, lc)
            end
        end

        addr = nil
    end
end

function  CreatePumps()

    pumps = {}
    for _,v in pairs(setting.liquidType)  do
        if v ~= setting.liquidType.map then
            if pumps[v.pump +1]  == nil and (v.ex == nil or v.ex == false) then
                pump = PeristalticPump:new()
                pump.index =  v.pump
                pump.isRunning = false
                pump.peristalticPumpInterface = dc:GetIPeristalticPump()
                pumps[v.pump +1] = pump
            end
            if v.ex == true then
                pump = ExPeristalticPump:new()
                pump.index =  v.pump
                pump.isRunning = false
                pump.exPeristalticPumpInterface = lc:GetIExtPeristalticPump()
                pumps[v.pump +1] = pump
            end
            --print(v.name)
        end
    end
end


function CreateMotors()
    --motor x
    motorX = Motor:new()
    motorX.index = 0
    motorX.isRunning = false
    motorX.motorControlInterface = dc:GetIMotorControl()
    motorX.localPos = 9999

    --motor z
    motorZ = Motor:new()
    motorZ.index = 1
    motorZ.isRunning = false
    motorZ.motorControlInterface = dc:GetIMotorControl()
    motorZ.localPos = 9999
end

function  CreateOperator()
    op = Operator:new()
end

function  StopOperator()
    op:Stop()
end

