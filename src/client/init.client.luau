local BoostNotificationController = require(script.BoostNotification.BoostNotification)

local boostController = BoostNotificationController.new()
boostController:Init()

task.delay(2, function()
	boostController:ShowBoost("2xDamage")
end)

task.delay(2, function()
	boostController:ShowBoost("2xDrops")
end)

task.delay(2, function()
	boostController:ShowBoost("2xLuck")
end)

task.delay(2, function()
	boostController:ShowBoost("2xPower")
end)

task.delay(2, function()
	boostController:ShowBoost("2xXp")
end)

task.delay(2, function()
	boostController:ShowBoost("3xStars")
end)