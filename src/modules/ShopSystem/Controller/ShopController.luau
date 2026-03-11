local ReplicatedStorage = game:GetService("ReplicatedStorage")

local HoverEffect = require(ReplicatedStorage.Modules.ShopSystem.UI.effects.HoverEffect)
local OpenAnimation = require(ReplicatedStorage.Modules.ShopSystem.UI.animations.OpenAnimation)
local CloseAnimation = require(ReplicatedStorage.Modules.ShopSystem.UI.animations.CloseAnimation)

local ShopController = {}
local isOpen = false

function ShopController.OpenButton(button)

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

function ShopController.CloseButton(button)

	HoverEffect:Apply(button)

	button.MouseButton1Click:Connect(function()

		CloseAnimation()
		isOpen = false

	end)

end
return ShopController