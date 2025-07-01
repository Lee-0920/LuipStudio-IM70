--[[
 * @brief 单个蠕动泵。
 * @details 对单个蠕动泵的功能进行封装。
--]]

ExPeristalticPump =
{
    index = 0,
    isRunning = false,
    exPeristalticPumpInterface =  0,
}

ExOffsetIndex = 16

function ExPeristalticPump:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    self.__metatable = "ExPeristalticPump"
    return o
end

function ExPeristalticPump:GetFactor()
    return self.exPeristalticPumpInterface:GetPumpFactor(self.index - ExOffsetIndex);
end

function ExPeristalticPump:SetFactor(factor)
    return  self.exPeristalticPumpInterface:SetPumpFactor(self.index - ExOffsetIndex, factor)

end

function ExPeristalticPump:GetMotionParam()
    return self.exPeristalticPumpInterface:GetMotionParam(self.index - ExOffsetIndex)
end

function ExPeristalticPump:SetMotionParam(param)
    return self.exPeristalticPumpInterface:SetMotionParam(self.index - ExOffsetIndex, param)
end

function ExPeristalticPump:GetStatus()
    return self.exPeristalticPumpInterface:GetPumpStatus(self.index - ExOffsetIndex)
end

function ExPeristalticPump:Start(dir, volume, speed)
    self.isRunning = true;
    return self.exPeristalticPumpInterface:StartPump(self.index - ExOffsetIndex, dir, volume, speed)
end

function ExPeristalticPump:Stop()
    self.isRunning = false;
    return self.exPeristalticPumpInterface:StopPump(self.index - ExOffsetIndex)
end

function ExPeristalticPump:GetVolume()
    return self.exPeristalticPumpInterface:GetPumpVolume(self.index - ExOffsetIndex)
end

function ExPeristalticPump:ExpectResult(timeout)
    local  pumpResult = ExPumpResult.new()
    pumpResult:SetIndex(0)
    pumpResult:SetResult(ExPumpOperateResult.Failed)

    pumpResult = self.exPeristalticPumpInterface:ExpectPumpResult(timeout)

    self.isRunning = false

    return pumpResult
end
