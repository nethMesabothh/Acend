--!strict
-- Weapon evolution chain. One slot, no inventory swapping in Phase 1.

local Realms = require(script.Parent.Realms)

export type WeaponStage = "RustySword" | "SpiritSword"

export type WeaponDefinition = {
	Id: WeaponStage,
	Name: string,
	NextStage: WeaponStage?,
	RequiredRealm: Realms.RealmId?,
	RequiredCombatWins: number?,
}

local Weapons: { [WeaponStage]: WeaponDefinition } = {
	RustySword = {
		Id = "RustySword",
		Name = "Rusty Sword",
		NextStage = "SpiritSword",
		RequiredRealm = "BodyTempering",
		RequiredCombatWins = 50,
	},
	SpiritSword = {
		Id = "SpiritSword",
		Name = "Spirit Sword",
		NextStage = nil,
		RequiredRealm = nil,
		RequiredCombatWins = nil,
	},
}

return Weapons
