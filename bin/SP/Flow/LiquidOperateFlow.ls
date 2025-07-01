LiquidOperateFlow = Flow:new
{
    source = setting.liquidType.none,
    dest = setting.liquidType.none,
    mode = 0,
    sVolume = 0,
    dVolume = 0,
    action = setting.runAction.suckFromBlank
}

function LiquidOperateFlow:new(o, source, dir, type, vol, action)
    o = o or {}
    setmetatable(o, self)
    self.__index = self

    o.source = source
    o.dir = dir
    o.type = type
    o.volume = vol
    o.action = action

    return o
end

function LiquidOperateFlow:GetRuntime()
    return 0
end

function LiquidOperateFlow:OnStart()
    -- 初始化下位机
    dc:GetIDeviceStatus():Initialize()
    -- 初始化液路板
    lc:GetIDeviceStatus():Initialize()

    --检测消解室是否为安全温度
    op:CheckDigestSafety()

end

function LiquidOperateFlow:OnProcess()

    self.isUserStop = false
    self.isFinish = false

    self.dateTime = os.time()

    local runStatus = Helper.Status.SetStatus(setting.runStatus.liquidOperate)
    StatusManager.Instance():SetStatus(runStatus)

    local runAction = Helper.Status.SetAction(self.action)
    StatusManager.Instance():SetAction(runAction)

    local err,result = pcall
    (
        function()

            if self.source == setting.liquidType.airReagent then
                --检查是否在复位点，避免往燃烧炉排废液爆炸
                local factor = dc:GetIPeristalticPump():GetPumpFactor(3)
                local drainSpeed = setting.liquid.syringeSlowDrainSpeed * factor
                if self.type == setting.component.xPos.exposureCell then
                    op:ManipulatorReset()
                    op:AutoMove(setting.component.xPos.exposureCell, setting.component.zPos.bottom)
                    op:SyringeReset()
                    op:SyringeSuck(setting.liquidType.syringeNone, self.volume)
                elseif self.type == setting.component.xPos.sampleMixer then
                    op:ManipulatorReset()
                    op:AutoMove(setting.component.xPos.sampleMixer, setting.component.zPos.bottom)
                    op:SyringeReset()
                    op:SyringeSuck(setting.liquidType.syringeNone, self.volume)
                elseif self.type == setting.component.xPos.standardCell then
                    op:ManipulatorReset()
                    op:AutoMove(setting.component.xPos.standardCell, setting.component.zPos.bottom)
                    op:SyringeReset()
                    op:SyringeSuck(setting.liquidType.syringeNone, self.volume)
                elseif self.type == setting.component.xPos.diluteCell then
                    op:ManipulatorReset()
                    op:AutoMove(setting.component.xPos.diluteCell, setting.component.zPos.bottom)
                    op:SyringeReset()
                    op:SyringeSuck(setting.liquidType.syringeNone, self.volume)
                elseif self.type == setting.component.xPos.exposureCell then
                    op:ManipulatorReset()
                    op:AutoMove(setting.component.xPos.exposureCell, setting.component.zPos.bottom)
                    op:SyringeReset()
                    op:SyringeSuck(setting.liquidType.syringeNone, self.volume)
                else
                    if self.dir == RollDirection.Suck then
                        op:SyringeReset()
                        op:SyringeSuck(setting.liquidType.syringeNone, self.volume, drainSpeed/4)
                    elseif self.dir == RollDirection.Drain then
                        local motionParam = MotionParam.new()
                        local acceleration = setting.liquid.syringeSuckAcceleration
                        motionParam =  dc:GetIPeristalticPump():GetMotionParam(3)
                        if math.abs(motionParam:GetAcceleration() - acceleration) > 0.001 then
                            motionParam:SetAcceleration(acceleration)
                            motionParam:SetSpeed(drainSpeed)
                            log:debug("[重设注射泵参数]： Set Speed " .. drainSpeed .. ", Set Acceleration " .. acceleration)
                            dc:GetIPeristalticPump():SetMotionParam(3, motionParam)
                        end
                        --op:SyringeDrain(setting.liquidType.syringeNone, self.volume, drainSpeed/4)
                        op:SyringToWaste(self.volume, setting.liquid.addDiluteSampleSpeed)
                    end
                end
            else
                if self.dir == RollDirection.Suck then
                    op:Pump(self.source, self.volume, 0.7)
                elseif self.dir == RollDirection.Drain then
                    op:Drain(self.source, self.volume, 0.7)
                end
            end

            return true
        end
    )
    if not err then      -- 出现异常
        if type(result) == "table" then
            if getmetatable(result) == PumpStoppedException then 			--泵操作被停止异常。
                self.isUserStop = true
                error(result)
            elseif getmetatable(result)== MeterStoppedException then			--定量被停止异常。
                self.isUserStop = true
                error(result)
            else
                error(result)
            end
        else
            error(result)
        end
    end

    self.isFinish = true
end

function LiquidOperateFlow:OnStop()

    -- 初始化下位机
    dc:GetIDeviceStatus():Initialize()
    -- 初始化液路板
    lc:GetIDeviceStatus():Initialize()
    
    --保存试剂余量表
    ReagentRemainManager.SaveRemainStatus()

    if not self.isFinish then
        if self.isUserStop then
            self.result = "用户终止"
            log:info("用户终止")
        else
            self.result = "故障终止"
            log:warn("故障终止")
        end
    else
        self.result = "管路操作结束"
        log:info("管路操作结束")
        local str = "管路操作流程总时间 = " .. tostring(os.time() - self.dateTime)
        log:debug(str)
    end
end
