--!strict
-- Owns the Qi/meditation/breakthrough loop: gains from meditation, the
-- breakthrough trial, realm advancement, and the soft failure penalty.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Remotes = require(ReplicatedStorage.Shared.Net.Remotes)
local GameConfig = require(ReplicatedStorage.Shared.Config.GameConfig)
local Realms = require(ReplicatedStorage.Shared.Config.Realms)
local Paths = require(ReplicatedStorage.Shared.Config.Paths)
local Talents = require(ReplicatedStorage.Shared.Config.Talents)

local PlayerDataService = require(script.Parent.PlayerDataService)

type PlayerState = {
	Meditating: boolean,
	BreakthroughInProgress: boolean,
}

local CultivationService = {}

local playerStates: { [Player]: PlayerState } = {}

local function syncCultivation(player: Player)
	local profile = PlayerDataService.GetProfile(player)
	if not profile then
		return
	end

	local realmDefinition = Realms[profile.Data.Realm :: Realms.RealmId]

	Remotes.CultivationUpdated:FireClient(player, {
		Realm = profile.Data.Realm,
		Qi = profile.Data.Qi,
		QiRequired = realmDefinition and realmDefinition.QiRequired or nil,
		Path = profile.Data.Path,
		EquippedTechnique = profile.Data.EquippedTechnique,
	})
end

local function meditationLoop(player: Player)
	while true do
		task.wait(GameConfig.MeditationTickInterval)

		local state = playerStates[player]
		if not state or not state.Meditating then
			break
		end

		local profile = PlayerDataService.GetProfile(player)
		if not profile then
			break
		end

		local realmDefinition = Realms[profile.Data.Realm :: Realms.RealmId]
		local qiCap = realmDefinition and realmDefinition.QiRequired

		local qiGain = GameConfig.QiPerMeditationTick * Talents.GetStatMultiplier(profile.Data.Talents, "MeditationQiRate")
		local newQi = profile.Data.Qi + qiGain
		if qiCap then
			newQi = math.min(newQi, qiCap)
		end
		profile.Data.Qi = newQi

		syncCultivation(player)
	end
end

local function onRequestMeditate(player: Player, wantsToMeditate: boolean)
	local state = playerStates[player]
	if not state or state.BreakthroughInProgress then
		return
	end

	if wantsToMeditate == state.Meditating then
		return
	end

	state.Meditating = wantsToMeditate
	if player.Character then
		player.Character:SetAttribute("Meditating", wantsToMeditate)
	end

	if wantsToMeditate then
		task.spawn(meditationLoop, player)
	end
end

local function onRequestBreakthrough(player: Player)
	local state = playerStates[player]
	local profile = PlayerDataService.GetProfile(player)
	if not state or not profile or state.BreakthroughInProgress then
		return
	end

	local realmDefinition = Realms[profile.Data.Realm :: Realms.RealmId]
	if not realmDefinition or not realmDefinition.QiRequired or not realmDefinition.NextRealm then
		Remotes.BreakthroughResult:FireClient(player, { Success = false, Reason = "MaxRealm" })
		return
	end

	if profile.Data.Qi < realmDefinition.QiRequired then
		Remotes.BreakthroughResult:FireClient(player, { Success = false, Reason = "NotEnoughQi" })
		return
	end

	local cooldownUntil = profile.Data.BreakthroughCooldownUntil
	if cooldownUntil and os.time() < cooldownUntil then
		Remotes.BreakthroughResult:FireClient(player, {
			Success = false,
			Reason = "OnCooldown",
			CooldownUntil = cooldownUntil,
		})
		return
	end

	state.Meditating = false
	state.BreakthroughInProgress = true
	if player.Character then
		player.Character:SetAttribute("Meditating", false)
	end
	Remotes.BreakthroughResult:FireClient(player, {
		Success = false,
		Reason = "TrialStarted",
		Duration = GameConfig.BreakthroughTrialDuration,
	})

	task.wait(GameConfig.BreakthroughTrialDuration)

	state = playerStates[player]
	profile = PlayerDataService.GetProfile(player)
	if not state or not profile then
		return
	end

	state.BreakthroughInProgress = false

	local baseFailChance = 1 - GameConfig.BreakthroughSuccessChance
	local failChance =
		math.clamp(baseFailChance * Talents.GetStatMultiplier(profile.Data.Talents, "BreakthroughFailChance"), 0, 1)
	local succeeded = math.random() > failChance

	if succeeded then
		profile.Data.Realm = realmDefinition.NextRealm
		profile.Data.Qi = 0
		profile.Data.BreakthroughCooldownUntil = nil
		Remotes.BreakthroughResult:FireClient(player, { Success = true, Realm = profile.Data.Realm })
	else
		local qiLoss = math.floor(profile.Data.Qi * GameConfig.BreakthroughFailQiLossPercent)
		profile.Data.Qi = math.max(0, profile.Data.Qi - qiLoss)
		profile.Data.BreakthroughCooldownUntil = os.time() + GameConfig.BreakthroughCooldownSeconds

		Remotes.BreakthroughResult:FireClient(player, {
			Success = false,
			Reason = "TrialFailed",
			CooldownUntil = profile.Data.BreakthroughCooldownUntil,
		})
	end

	syncCultivation(player)
end

local function onSelectPath(player: Player, pathId: string)
	local profile = PlayerDataService.GetProfile(player)
	if not profile or profile.Data.Path ~= nil then
		return -- already chosen; Phase 1 has no respec
	end

	local pathDefinition = Paths[pathId :: Paths.PathId]
	if not pathDefinition then
		return
	end

	profile.Data.Path = pathDefinition.Id
	profile.Data.EquippedTechnique = pathDefinition.StartingTechnique
	syncCultivation(player)
end

local function onProfileLoaded(player: Player)
	playerStates[player] = { Meditating = false, BreakthroughInProgress = false }
	syncCultivation(player)
end

local function onPlayerRemoving(player: Player)
	playerStates[player] = nil
end

function CultivationService.Start()
	PlayerDataService.ProfileLoaded:Connect(onProfileLoaded)
	Players.PlayerRemoving:Connect(onPlayerRemoving)

	Remotes.RequestMeditate.OnServerEvent:Connect(onRequestMeditate)
	Remotes.RequestBreakthrough.OnServerEvent:Connect(onRequestBreakthrough)
	Remotes.SelectPath.OnServerEvent:Connect(onSelectPath)
end

return CultivationService
