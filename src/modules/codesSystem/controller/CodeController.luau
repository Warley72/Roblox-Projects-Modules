local ReplicatedStorage = game:GetService("ReplicatedStorage")

local HoverEffect = require(ReplicatedStorage.Modules.codesSystem.UI.effects.HoverEffect)
local OpenAnimation = require(ReplicatedStorage.Modules.codesSystem.UI.animations.OpenAnimation)
local CloseAnimation = require(ReplicatedStorage.Modules.codesSystem.UI.animations.CloseAnimation)

local CodesController = {}
local isOpen = false

function CodesController.OpenButton(button)

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

function CodesController.CloseButton(button)

	HoverEffect:Apply(button)

	button.MouseButton1Click:Connect(function()

		CloseAnimation()
		isOpen = false

	end)

end
return CodesController