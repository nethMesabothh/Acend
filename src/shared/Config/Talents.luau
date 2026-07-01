--!strict
-- Talent pool rolled 3-at-a-time on first join. Each talent has a clear
-- bonus and an optional tradeoff, per Phase 1 design doc.

export type TalentId = "FireAffinity" | "FastMeditation" | "UnstableCore" | "IronBody" | "SwiftFeet" | "LuckyStar"

export type TalentStat =
	"MeditationQiRate"
	| "CombatQiRate"
	| "TechniqueDamage"
	| "MoveSpeed"
	| "MaxHealth"
	| "BreakthroughFailChance"

export type TalentEffect = {
	Stat: TalentStat,
	Multiplier: number,
}

export type TalentDefinition = {
	Id: TalentId,
	Name: string,
	Description: string,
	Bonus: TalentEffect,
	Tradeoff: TalentEffect?,
}

local Talents: { [TalentId]: TalentDefinition } = {
	FireAffinity = {
		Id = "FireAffinity",
		Name = "Fire Affinity",
		Description = "+10% technique damage, -5% Qi from meditation.",
		Bonus = { Stat = "TechniqueDamage", Multiplier = 1.1 },
		Tradeoff = { Stat = "MeditationQiRate", Multiplier = 0.95 },
	},
	FastMeditation = {
		Id = "FastMeditation",
		Name = "Fast Meditation",
		Description = "+25% Qi from meditation, -10% Qi from combat.",
		Bonus = { Stat = "MeditationQiRate", Multiplier = 1.25 },
		Tradeoff = { Stat = "CombatQiRate", Multiplier = 0.9 },
	},
	UnstableCore = {
		Id = "UnstableCore",
		Name = "Unstable Core",
		Description = "+15% Qi from all sources, +10% breakthrough fail chance.",
		Bonus = { Stat = "CombatQiRate", Multiplier = 1.15 },
		Tradeoff = { Stat = "BreakthroughFailChance", Multiplier = 1.1 },
	},
	IronBody = {
		Id = "IronBody",
		Name = "Iron Body",
		Description = "+10% max health, -5% move speed.",
		Bonus = { Stat = "MaxHealth", Multiplier = 1.1 },
		Tradeoff = { Stat = "MoveSpeed", Multiplier = 0.95 },
	},
	SwiftFeet = {
		Id = "SwiftFeet",
		Name = "Swift Feet",
		Description = "+10% move speed, -5% max health.",
		Bonus = { Stat = "MoveSpeed", Multiplier = 1.1 },
		Tradeoff = { Stat = "MaxHealth", Multiplier = 0.95 },
	},
	LuckyStar = {
		Id = "LuckyStar",
		Name = "Lucky Star",
		Description = "+10% Qi from combat. No tradeoff.",
		Bonus = { Stat = "CombatQiRate", Multiplier = 1.1 },
		Tradeoff = nil,
	},
}

local TalentIds: { TalentId } = {
	"FireAffinity",
	"FastMeditation",
	"UnstableCore",
	"IronBody",
	"SwiftFeet",
	"LuckyStar",
}

-- Combines every Bonus/Tradeoff a player's rolled talents apply to `stat`
-- into a single multiplier (1 = no effect).
local function getStatMultiplier(talentIds: { string }, stat: TalentStat): number
	local multiplier = 1

	for _, talentId in talentIds do
		local definition = Talents[talentId :: TalentId]
		if not definition then
			continue
		end

		if definition.Bonus.Stat == stat then
			multiplier *= definition.Bonus.Multiplier
		end

		if definition.Tradeoff and definition.Tradeoff.Stat == stat then
			multiplier *= definition.Tradeoff.Multiplier
		end
	end

	return multiplier
end

return {
	Definitions = Talents,
	Ids = TalentIds,
	GetStatMultiplier = getStatMultiplier,
}
