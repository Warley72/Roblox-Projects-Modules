local Modules = game.ReplicatedStorage.Modules

for _, system in pairs(Modules:GetChildren()) do
	
	local serverFolder = system:FindFirstChild("Server")
	
	if serverFolder then
		for _, module in pairs(serverFolder:GetChildren()) do
			require(module)
		end
	end
	
end