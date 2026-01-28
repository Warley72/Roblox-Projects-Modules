local BoostNotificationController = require(script.controllers.BoostNotificationController)

local boostController = BoostNotificationController.new()
boostController:Init()

task.delay(1, function()
	boostController:ShowBoost("2xPower")
end)

task.delay(3, function()
	boostController:ShowBoost("2xXp")
end)

task.delay(3, function()
	boostController:ShowBoost("2xDamage")
end)

task.delay(3, function()
	boostController:ShowBoost("2xDrops")
end)

task.delay(3, function()
	boostController:ShowBoost("3xStars")
end)

task.delay(3, function()
	boostController:ShowBoost("2xLuck")
end)