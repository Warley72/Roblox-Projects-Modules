local TweenService = game:GetService("TweenService")

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local xpBar = playerGui:WaitForChild("XPBar")
local fill = xpBar:WaitForChild("Bar")
local text = xpBar:WaitForChild("TextLabel")

local level = 1
local currentXP = 0
local maxXP = 100

local function updateBar()

	local percent = currentXP / maxXP

	local tween = TweenService:Create(
		fill,
		TweenInfo.new(0.25),
		{Size = UDim2.new(percent,0,1,0)}
	)

	tween:Play()

	text.Text = "Lv."..level.." ("..currentXP.."/"..maxXP..")"

end

return updateBar