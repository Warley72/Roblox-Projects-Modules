local TweenService = game:GetService("TweenService")

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local BoostNotificationController = {} 

BoostNotificationController.__index = BoostNotificationController

local SHOW_TIME = 5
local TWEEN_IN_TIME = 0.4
local TWEEN_OUT_TIME = 0.5

local OFFSCREEN_POS = UDim2.fromScale(1.9, 0.5)
local ONSCREEN_POS = UDim2.fromScale(0.60, 0.5)

function BoostNotificationController.new()
	return setmetatable({
		gui = nil,
		boostsFolder = nil,
		queue = {},
		isShowing = false,
		isReady = false, --
	}, BoostNotificationController)
end

function BoostNotificationController:Init()
    
	local playerGui = player:WaitForChild("PlayerGui")

	self.gui = playerGui:WaitForChild("Right")
	self.gui.Enabled = true 

	self.boostsFolder = self.gui:WaitForChild("Boosts")

	for _, boost in ipairs(self.boostsFolder:GetChildren()) do
		if boost:IsA("Frame") then
			boost.Position = OFFSCREEN_POS
			boost.Visible = false
		end
	end

	self.isReady = true
	self:_processQueue()
end

function BoostNotificationController:ShowBoost(boostName)
	table.insert(self.queue, boostName)
	self:_processQueue()
end

function BoostNotificationController:_processQueue()
	if not self.isReady then
		return
	end
	if self.isShowing then
		return
	end
	if #self.queue == 0 then
		return
	end

	self.isShowing = true

	local boostName = table.remove(self.queue, 1)
	local boostFrame = self.boostsFolder:FindFirstChild(boostName)

	if not boostFrame then
		self.isShowing = false
		self:_processQueue()
		return
	end

	boostFrame.Visible = false
	boostFrame.Position = OFFSCREEN_POS
	task.wait()
	boostFrame.Visible = true

	local tweenIn = TweenService:Create(
		boostFrame,
		TweenInfo.new(TWEEN_IN_TIME, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
		{ Position = ONSCREEN_POS }
	)

	tweenIn:Play()
	tweenIn.Completed:Wait()

	task.wait(SHOW_TIME)

	local tweenOut = TweenService:Create(
		boostFrame,
		TweenInfo.new(TWEEN_OUT_TIME, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
		{ Position = OFFSCREEN_POS }
	)

	tweenOut:Play()
	tweenOut.Completed:Wait()

	boostFrame.Visible = false
	boostFrame.Position = OFFSCREEN_POS

	self.isShowing = false
	self:_processQueue()
end

return BoostNotificationController
