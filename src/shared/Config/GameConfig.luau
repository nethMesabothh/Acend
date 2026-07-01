--!strict
-- Balancing/data tables live here, separate from logic, so designers can
-- tweak numbers without touching service code.

export type GameConfig = {
	StartingCoins: number,
	StartingRealm: string,
	StartingWeaponStage: string,

	QiPerMeditationTick: number,
	MeditationTickInterval: number,
	QiPerTechniqueHitMin: number,
	QiPerTechniqueHitMax: number,

	BreakthroughTrialDuration: number, -- seconds
	BreakthroughSuccessChance: number, -- 0-1
	BreakthroughFailQiLossPercent: number, -- 0-1
	BreakthroughCooldownSeconds: number,

	MasteryTier1Uses: number,
	SpiritSwordCombatWinsRequired: number,

	QiAuraColor: Color3,
}

local GameConfig: GameConfig = {
	StartingCoins = 0,
	StartingRealm = "Mortal",
	StartingWeaponStage = "RustySword",

	QiPerMeditationTick = 1,
	MeditationTickInterval = 2,
	QiPerTechniqueHitMin = 3,
	QiPerTechniqueHitMax = 5,

	BreakthroughTrialDuration = 20,
	BreakthroughSuccessChance = 0.85,
	BreakthroughFailQiLossPercent = 0.25,
	BreakthroughCooldownSeconds = 30,

	MasteryTier1Uses = 500,
	SpiritSwordCombatWinsRequired = 50,

	QiAuraColor = Color3.fromRGB(140, 200, 255),
}

return GameConfig
