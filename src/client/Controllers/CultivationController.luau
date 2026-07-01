--!strict
-- Debug-only input bindings for testing the cultivation loop before the real
-- HUD exists (Milestone F). M toggles meditation, B requests a breakthrough.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local Remotes = require(ReplicatedStorage.Shared.Net.Remotes)

local CultivationController = {}

local meditating = false

local function onInputBegan(input: InputObject, gameProcessedEvent: boolean)
	if gameProcessedEvent then
		return
	end

	if input.KeyCode == Enum.KeyCode.M then
		meditating = not meditating
		Remotes.RequestMeditate:FireServer(meditating)
		print(if meditating then "[Cultivation] Started meditating..." else "[Cultivation] Stopped meditating.")
	elseif input.KeyCode == Enum.KeyCode.B then
		print("[Cultivation] Requesting breakthrough...")
		Remotes.RequestBreakthrough:FireServer()
	end
end

function CultivationController.Start()
	UserInputService.InputBegan:Connect(onInputBegan)

	Remotes.CultivationUpdated.OnClientEvent:Connect(function(data: any)
		print(
			`[Cultivation] Realm={data.Realm} Qi={data.Qi}/{data.QiRequired} Path={data.Path} Technique={data.EquippedTechnique}`
		)
	end)

	Remotes.BreakthroughResult.OnClientEvent:Connect(function(result: any)
		if result.Success then
			print(`[Breakthrough] Success! New realm: {result.Realm}`)
		elseif result.Reason == "TrialStarted" then
			print(`[Breakthrough] Trial started, survive {result.Duration}s...`)
		else
			print(`[Breakthrough] Failed: {result.Reason}`)
		end
	end)

	print("[Cultivation] Debug controls ready — M: toggle meditate, B: breakthrough")
end

return CultivationController
