local ReplicatedStorage = game:GetService("ReplicatedStorage")

local HoverEffect = require(ReplicatedStorage.Modules.Inventory.UI.effects.HoverEffect)
local OpenAnimation = require(ReplicatedStorage.Modules.Inventory.UI.animations.OpenAnimation)
local CloseAnimation = require(ReplicatedStorage.Modules.Inventory.UI.animations.CloseAnimation)

local isOpen = false

local function InventoryController(hover)

	HoverEffect:Apply(hover)

	hover.MouseButton1Click:Connect(function()

		if isOpen then
			CloseAnimation()
			isOpen = false
		else
			OpenAnimation()
			isOpen = true
		end

	end)

end
return InventoryController