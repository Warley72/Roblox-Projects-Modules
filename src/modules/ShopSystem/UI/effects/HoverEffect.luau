local TweenService = game:GetService("TweenService")

local HoverEffect = {}

function HoverEffect:Apply(button)

	local scale = button:FindFirstChildOfClass("UIScale")

	if not scale then
		scale = Instance.new("UIScale")
		scale.Scale = 1
		scale.Parent = button
	end

	local tweenInfo = TweenInfo.new(
		0.2,
		Enum.EasingStyle.Quad,
		Enum.EasingDirection.Out
	)

	local hoverTween = TweenService:Create(scale, tweenInfo, {
		Scale = 1.1
	})

	local leaveTween = TweenService:Create(scale, tweenInfo, {
		Scale = 1
	})

	button.MouseEnter:Connect(function()
		hoverTween:Play()
	end)

	button.MouseLeave:Connect(function()
		leaveTween:Play()
	end)
end
return HoverEffect