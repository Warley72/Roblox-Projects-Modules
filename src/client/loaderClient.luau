local Modules = game.ReplicatedStorage.Modules

for _, system in pairs(Modules:GetChildren()) do
	
	local clientFolder = system:FindFirstChild("Client")
	
	if clientFolder then
		for _, module in pairs(clientFolder:GetChildren()) do
			require(module)
		end
	end
	
end