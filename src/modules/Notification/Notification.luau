local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

local Notification = {}

-- CONFIG
local OFFSCREEN_POS = UDim2.fromScale(1.2, 0.3)
local ONSCREEN_START = UDim2.fromScale(0.6, 0.3)

local SHOW_TIME = 3
local MAX_ONSCREEN = 3
local VERTICAL_SPACING = 0.11

local queue = {}
local showing = {}

-- Função interna
local function tweenTransparency(gui, value, time)
	if gui:IsA("ImageLabel") then
		TweenService:Create(gui, TweenInfo.new(time), {
			ImageTransparency = value,
		}):Play()
	end

	for _, child in ipairs(gui:GetDescendants()) do
		if child:IsA("TextLabel") then
			TweenService:Create(child, TweenInfo.new(time), {
				TextTransparency = value,
			}):Play()
		elseif child:IsA("ImageLabel") then
			TweenService:Create(child, TweenInfo.new(time), {
				ImageTransparency = value,
			}):Play()
		elseif child:IsA("UIStroke") then
			TweenService:Create(child, TweenInfo.new(time), {
				Transparency = value,
			}):Play()
		end
	end
end

local function updatePositions()
	for index, boost in ipairs(showing) do
		local targetPos = ONSCREEN_START + UDim2.new(0, 0, VERTICAL_SPACING * (index - 1), 0)

		TweenService:Create(
			boost,
			TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			{ Position = targetPos }
		):Play()
	end
end

local function showBoost(boostLabel)
	boostLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	boostLabel.Position = OFFSCREEN_POS
	boostLabel.Visible = true

	local scale = boostLabel:FindFirstChildOfClass("UIScale") or Instance.new("UIScale")
	scale.Parent = boostLabel
	scale.Scale = 1.1

	boostLabel.ImageTransparency = 1
	tweenTransparency(boostLabel, 1, 0)

	table.insert(showing, boostLabel)

	local index = #showing
	local targetPos = ONSCREEN_START + UDim2.new(0, 0, VERTICAL_SPACING * (index - 1), 0)

	local tweenIn = TweenService:Create(
		boostLabel,
		TweenInfo.new(0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
		{ Position = targetPos, ImageTransparency = 0 }
	)

	tweenIn:Play()
	tweenTransparency(boostLabel, 0, 0.45)

	tweenIn.Completed:Wait()

	TweenService:Create(
		scale,
		TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
		{ Scale = 1 }
	):Play()

	task.wait(SHOW_TIME)

	local tweenOut = TweenService:Create(
		boostLabel,
		TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
		{ Position = OFFSCREEN_POS, ImageTransparency = 1 }
	)

	tweenOut:Play()
	tweenTransparency(boostLabel, 1, 0.25)

	tweenOut.Completed:Wait()

	boostLabel.Visible = false
	scale.Scale = 1

	for i, v in ipairs(showing) do
		if v == boostLabel then
			table.remove(showing, i)
			break
		end
	end

	updatePositions()

	if #queue > 0 then
		local nextBoost = table.remove(queue, 1)
		task.spawn(showBoost, nextBoost)
	end
end

-- FUNÇÃO PÚBLICA
function Notification:Trigger()
	local player = Players.LocalPlayer
	local playerGui = player:WaitForChild("PlayerGui")
	local rightGui = playerGui:WaitForChild("Right")
	local boostsFrame = rightGui:WaitForChild("Boosts")

	local nextBoost = nil

	for _, b in ipairs(boostsFrame:GetChildren()) do
		if b:IsA("ImageLabel") and not table.find(showing, b) and not table.find(queue, b) then
			nextBoost = b
			break
		end
	end

	if nextBoost then
		if #showing < MAX_ONSCREEN then
			task.spawn(showBoost, nextBoost)
		else
			table.insert(queue, nextBoost)
		end
	end
end

return Notification