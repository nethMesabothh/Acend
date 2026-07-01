--!strict
-- Owns player data: loads/saves profiles via ProfileStore and exposes a
-- Signal other services can subscribe to when a profile becomes ready.

local Players = game:GetService("Players")

local ServerPackages = game:GetService("ServerScriptService").ServerPackages
local ProfileStore = require(ServerPackages.ProfileStore)

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Signal = require(ReplicatedStorage.Packages.Signal)

local GameConfig = require(ReplicatedStorage.Shared.Config.GameConfig)
local Remotes = require(ReplicatedStorage.Shared.Net.Remotes)

type ProfileData = {
	Coins: number,
}

local TEMPLATE: ProfileData = {
	Coins = GameConfig.StartingCoins,
}

local playerStore = ProfileStore.New("PlayerData", TEMPLATE)

local PlayerDataService = {}
PlayerDataService.ProfileLoaded = Signal.new()

local profiles: { [Player]: typeof(playerStore:StartSessionAsync("", {})) } = {}

local function onPlayerAdded(player: Player)
	local profile = playerStore:StartSessionAsync(`{player.UserId}`, {
		Cancel = function()
			return player.Parent ~= Players
		end,
	})

	if profile == nil then
		player:Kick("Failed to load your data. Please rejoin.")
		return
	end

	profile:AddUserId(player.UserId)
	profile:Reconcile()

	profile.OnSessionEnd:Connect(function()
		profiles[player] = nil
		player:Kick("Your data session ended. Please rejoin.")
	end)

	if player.Parent == Players then
		profiles[player] = profile
		PlayerDataService.ProfileLoaded:Fire(player, profile)
		Remotes.CoinsUpdated:FireClient(player, profile.Data.Coins)
	else
		profile:EndSession()
	end
end

local function onPlayerRemoving(player: Player)
	local profile = profiles[player]
	if profile then
		profile:EndSession()
	end
end

function PlayerDataService.GetProfile(player: Player)
	return profiles[player]
end

function PlayerDataService.Start()
	Players.PlayerAdded:Connect(onPlayerAdded)
	Players.PlayerRemoving:Connect(onPlayerRemoving)

	for _, player in Players:GetPlayers() do
		task.spawn(onPlayerAdded, player)
	end
end

return PlayerDataService
