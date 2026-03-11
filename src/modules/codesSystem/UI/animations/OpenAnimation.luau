local TweenService = game:GetService("TweenService")

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local CodesFrame = playerGui:WaitForChild("Codes"):WaitForChild("Frame")

local uiScale = CodesFrame:FindFirstChild("UIScale")

if not uiScale then
	uiScale = Instance.new("UIScale")
	uiScale.Scale = 1
	uiScale.Parent = CodesFrame
end

local isAnimating = false

local function openCodes()
	if isAnimating then return end
	isAnimating = true

	CodesFrame.Visible = true
	uiScale.Scale = 0.8

	local tween = TweenService:Create(
		uiScale,
		TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
		{ Scale = 1 }
	)

	tween:Play()
	tween.Completed:Wait()
    
	isAnimating = false
end
return openCodes