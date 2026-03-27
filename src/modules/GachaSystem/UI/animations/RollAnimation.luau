local TweenService = game:GetService("TweenService")

local RollAnimation = {}

function RollAnimation:Play(container)

	if container:GetAttribute("Rolling") then return end
	container:SetAttribute("Rolling", true)

	local moveAmount = 200 
	local speed = 0.3 

	task.spawn(function()
		while container:GetAttribute("Rolling") do

			local tween = TweenService:Create(container, TweenInfo.new(
				speed,
				Enum.EasingStyle.Linear
			), {
				Position = container.Position - UDim2.new(0, moveAmount, 0, 0)
			})

			tween:Play()
			tween.Completed:Wait()

			if container.Position.X.Offset <= -1000 then
				container.Position = UDim2.new(0, 0, 0, 0)
			end

		end
	end)

end

function RollAnimation:Stop(container)
	container:SetAttribute("Rolling", false)
end

return RollAnimation