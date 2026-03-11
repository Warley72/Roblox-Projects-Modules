local ReplicatedStorage = game:GetService("ReplicatedStorage")

local HoverEffect = require(ReplicatedStorage.Modules.GachaSystem.UI.effects.HoverEffect)
local OpenAnimation = require(ReplicatedStorage.Modules.GachaSystem.UI.animations.OpenAnimation)
local CloseAnimation = require(ReplicatedStorage.Modules.GachaSystem.UI.animations.CloseAnimation)

local GachaController = {}
local isOpen = false

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
return GachaController