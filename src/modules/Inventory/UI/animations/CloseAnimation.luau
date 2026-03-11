local TweenService = game:GetService("TweenService")

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local inventoryFrame = playerGui:WaitForChild("Inventory"):WaitForChild("Frame")
local uiScale = inventoryFrame:FindFirstChild("UIScale")

if not uiScale then
	uiScale = Instance.new("UIScale")
	uiScale.Scale = 1
	uiScale.Parent = inventoryFrame
end

local isAnimating = false

local function closeInventory()
	if isAnimating then return end
	isAnimating = true

	local tween = TweenService:Create(
		uiScale,
		TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
		{ Scale = 0.8 }
	)

	tween:Play()
	tween.Completed:Wait()

	inventoryFrame.Visible = false
	isAnimating = false
end
return closeInventory