local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer

local BoostNotificationController = {}
BoostNotificationController.__index = BoostNotificationController

-- CONFIG
local SHOW_TIME = 2
local TWEEN_IN_TIME = 0.4
local TWEEN_OUT_TIME = 0.4

-- POSIÇÕES
local OFFSCREEN_POS = UDim2.fromScale(1.2, 0.5)
local ONSCREEN_POS = UDim2.fromScale(0.85, 0.5)

function BoostNotificationController.new()
	return setmetatable({
		gui = nil,
		boostsFolder = nil,
		queue = {},
		isShowing = false
	}, BoostNotificationController)
end

function BoostNotificationController:Init()
	print("BoostNotificationController INIT")

	local playerGui = player:WaitForChild("PlayerGui")

	self.gui = playerGui:WaitForChild("Right", 5)
	if not self.gui then
		warn("Right não encontrado")
		return
	end

	self.boostsFolder = self.gui:WaitForChild("Boosts", 5)
	if not self.boostsFolder then
		warn("Boosts não encontrado")
		return
	end
	for _, boost in pairs(self.boostsFolder:GetChildren()) do
		if boost:IsA("Frame") then
			boost.Position = OFFSCREEN_POS
			boost.Visible = false
		end
	end
end

function BoostNotificationController:ShowBoost(boostName)
	if not self.boostsFolder then
		warn("BoostsFolder nil")
		return
	end

	table.insert(self.queue, boostName)
	self:_processQueue()
end

function BoostNotificationController:_processQueue()
	if self.isShowing then return end
	if #self.queue == 0 then return end

	self.isShowing = true

	local boostName = table.remove(self.queue, 1)
	local boostFrame = self.boostsFolder:FindFirstChild(boostName)

	if not boostFrame then
		warn("Boost não encontrado:", boostName)
		self.isShowing = false
		return
	end

	boostFrame.Visible = true
	boostFrame.Position = OFFSCREEN_POS

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
	self.isShowing = false
	
	self:_processQueue()
end

return BoostNotificationController
