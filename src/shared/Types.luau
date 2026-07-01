--!strict
-- Shared type definitions used by both server and client code.

export type ProfileData = {
	Coins: number,

	-- cultivation
	Realm: string, -- "Mortal" | "BodyTempering"
	Qi: number,
	Path: string?, -- nil until chosen: "Sword" | "Body"
	Talents: { string },

	-- techniques
	EquippedTechnique: string?,
	TechniqueMastery: { [string]: number }, -- techniqueId -> use count

	-- weapon
	WeaponStage: string, -- "RustySword" | "SpiritSword"
	CombatWins: number,

	-- breakthrough
	BreakthroughCooldownUntil: number?, -- os.time() when ready again
	HasCompletedTutorial: boolean,
}

return {}
