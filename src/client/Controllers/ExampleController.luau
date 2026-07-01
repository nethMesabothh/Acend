--!strict
-- Listens for the server's CoinsUpdated remote and prints the balance.
-- Replace this with real UI logic once you have a HUD to wire it to.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remotes = require(ReplicatedStorage.Shared.Net.Remotes)

local ExampleController = {}

function ExampleController.Start()
	Remotes.CoinsUpdated.OnClientEvent:Connect(function(coins: number)
		print(`Coins updated: {coins}`)
	end)
end

return ExampleController
