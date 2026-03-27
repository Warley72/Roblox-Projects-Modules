local ReplicatedStorage = game:GetService("ReplicatedStorage")

local HoverEffect = require(ReplicatedStorage.Modules.GachaSystem.UI.effects.HoverEffect)
local OpenAnimation = require(ReplicatedStorage.Modules.GachaSystem.UI.animations.OpenAnimation)
local CloseAnimation = require(ReplicatedStorage.Modules.GachaSystem.UI.animations.CloseAnimation)
local RollAnimation = require(ReplicatedStorage.Modules.GachaSystem.UI.animations.RollAnimation)

local GachaController = {}
local isOpen = false

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local rollsFrame = playerGui:WaitForChild("Rolls"):WaitForChild("Frame")

function GachaController.OpenButton(button)
	HoverEffect:Apply(button)

	button.MouseButton1Click:Connect(function()
		if isOpen then
			CloseAnimation()
			isOpen = false
		else
			OpenAnimation()
			isOpen = true
		end
	end)
end

function GachaController.CloseButton(button)
	HoverEffect:Apply(button)

	button.MouseButton1Click:Connect(function()
		CloseAnimation()
		isOpen = false
	end)
end

function GachaController.SingleButton(button)
	HoverEffect:Apply(button)

	local isRolling = false

	button.MouseButton1Click:Connect(function()
		if isRolling then return end
		isRolling = true

		-- FECHA GACHA
		if isOpen then
			CloseAnimation()
			isOpen = false
		end

		task.wait(0.3)

		-- ABRE ROLLS
		rollsFrame.Visible = true

		-- CAMINHO DO CONTAINER
		local container = rollsFrame
			:WaitForChild("MainBg")
			:WaitForChild("Frame")

		-- RESET POSIÇÃO
		container.Position = UDim2.new(0, 0, 0, 0)

		-- 🔥 INICIA LOOP
		RollAnimation:Play(container)

		-- ⏱ tempo girando (ajusta aqui)
		task.wait(3)

		-- 🛑 PARA O LOOP
		RollAnimation:Stop(container)

		isRolling = false
	end)
end

return GachaController