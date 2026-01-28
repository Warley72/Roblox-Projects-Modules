local TweenService = game:GetService("TweenService")

local BoostNotification = {}
BoostNotification.__index = BoostNotification

function BoostNotification.new(frame)
	local self = setmetatable({}, BoostNotification)
	self.frame = frame

	self.hiddenPosition = UDim2.fromScale(1.2, frame.Position.Y.Scale)
	self.visiblePosition = frame.Position

	frame.Position = self.hiddenPosition
	frame.Visible = false

	return self
end

function BoostNotification:Show()
	self.frame.Visible = true

	local tween = TweenService:Create(
		self.frame,
		TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
		{ Position = self.visiblePosition }
	)
	tween:Play()
end

function BoostNotification:Hide()
	local tween = TweenService:Create(
		self.frame,
		TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
		{ Position = self.hiddenPosition }
	)

	tween:Play()
	tween.Completed:Once(function()
		self.frame.Visible = false
	end)
end

function BoostNotification:SetTime(text)
	self.frame.Timer.Text = text
end

return BoostNotification
