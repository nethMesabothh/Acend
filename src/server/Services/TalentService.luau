--!strict
-- Rolls 3 random talents on a player's first join. Uses its own
-- once-only check rather than ProfileStore's Reconcile, since Reconcile only
-- backfills missing keys — it cannot run roll logic for existing profiles.

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Remotes = require(ReplicatedStorage.Shared.Net.Remotes)
local Talents = require(ReplicatedStorage.Shared.Config.Talents)

local PlayerDataService = require(script.Parent.PlayerDataService)

local TALENT_ROLL_COUNT = 3

local TalentService = {}

local function rollTalents(count: number): { string }
	local pool = table.clone(Talents.Ids)
	local rolled = {}

	for _ = 1, math.min(count, #pool) do
		local index = math.random(1, #pool)
		table.insert(rolled, pool[index])
		table.remove(pool, index)
	end

	return rolled
end

local function onProfileLoaded(player: Player)
	local profile = PlayerDataService.GetProfile(player)
	if not profile then
		return
	end

	if #profile.Data.Talents == 0 then
		profile.Data.Talents = rollTalents(TALENT_ROLL_COUNT)
	end

	Remotes.TalentRolled:FireClient(player, profile.Data.Talents)
end

function TalentService.Start()
	PlayerDataService.ProfileLoaded:Connect(onProfileLoaded)
end

return TalentService
