--!strict
-- Debug-only path/talent input for testing before the real UI exists
-- (Milestone F). 1 selects Sword, 2 selects Body.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local Remotes = require(ReplicatedStorage.Shared.Net.Remotes)

local PathSelectController = {}

local function onInputBegan(input: InputObject, gameProcessedEvent: boolean)
	if gameProcessedEvent then
		return
	end

	if input.KeyCode == Enum.KeyCode.One then
		print("[Path] Selecting Sword...")
		Remotes.SelectPath:FireServer("Sword")
	elseif input.KeyCode == Enum.KeyCode.Two then
		print("[Path] Selecting Body...")
		Remotes.SelectPath:FireServer("Body")
	end
end

function PathSelectController.Start()
	UserInputService.InputBegan:Connect(onInputBegan)

	Remotes.TalentRolled.OnClientEvent:Connect(function(talentIds: { string })
		print(`[Talents] Rolled: {table.concat(talentIds, ", ")}`)
	end)

	print("[Path] Debug controls ready — 1: Sword, 2: Body")
end

return PathSelectController
