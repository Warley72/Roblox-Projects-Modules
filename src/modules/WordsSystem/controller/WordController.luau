local ReplicatedStorage = game:GetService("ReplicatedStorage")

local HoverEffect = require(ReplicatedStorage.Modules.WordsSystem.UI.effects.HoverEffect)
local OpenAnimation = require(ReplicatedStorage.Modules.WordsSystem.UI.animations.OpenAnimation)
local CloseAnimation = require(ReplicatedStorage.Modules.WordsSystem.UI.animations.CloseAnimation)

local WordController = {}
local isOpen = false

function WordController.OpenButton(button)

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

function WordController.CloseButton(button)

	HoverEffect:Apply(button)

	button.MouseButton1Click:Connect(function()

		CloseAnimation()
		isOpen = false

	end)

end
return WordController