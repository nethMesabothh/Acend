--!strict
-- Combat techniques and their mastery evolution chain.

export type TechniqueId = "QuickSlash" | "HeavySlash" | "IronPalm"

export type MasteryTier = {
	UsesRequired: number,
	UnlocksTechnique: TechniqueId,
}

export type TechniqueDefinition = {
	Id: TechniqueId,
	Name: string,
	Path: "Sword" | "Body",
	QiPerHit: number,
	Cooldown: number,
	MasteryTiers: { MasteryTier },
}

local Techniques: { [TechniqueId]: TechniqueDefinition } = {
	QuickSlash = {
		Id = "QuickSlash",
		Name = "Quick Slash",
		Path = "Sword",
		QiPerHit = 3,
		Cooldown = 0.6,
		MasteryTiers = {
			{ UsesRequired = 500, UnlocksTechnique = "HeavySlash" },
		},
	},
	HeavySlash = {
		Id = "HeavySlash",
		Name = "Heavy Slash",
		Path = "Sword",
		QiPerHit = 5,
		Cooldown = 0.9,
		MasteryTiers = {},
	},
	IronPalm = {
		Id = "IronPalm",
		Name = "Iron Palm",
		Path = "Body",
		QiPerHit = 5,
		Cooldown = 1.1,
		MasteryTiers = {},
	},
}

return Techniques
