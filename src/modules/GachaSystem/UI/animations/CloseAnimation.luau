local TweenService = game:GetService("TweenService")

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local GachaFrame = playerGui:WaitForChild("Gacha"):WaitForChild("Frame")

local uiScale = GachaFrame:FindFirstChild("UIScale")

if not uiScale then
	uiScale = Instance.new("UIScale")
	uiScale.Scale = 1
	uiScale.Parent = GachaFrame
end

local isAnimating = false

local function closeGacha()
	if isAnimating then return end
	isAnimating = true

	local tween = TweenService:Create(
		uiScale,
		TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
		{ Scale = 0.8 }
	)

	tween:Play()
	tween.Completed:Wait()

	GachaFrame.Visible = false
	isAnimating = false
end
return closeGacha