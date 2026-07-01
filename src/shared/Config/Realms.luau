--!strict
-- Realm progression ladder for Phase 1 (Mortal -> Body Tempering only).

export type RealmId = "Mortal" | "BodyTempering"

export type RealmDefinition = {
	Id: RealmId,
	Name: string,
	QiRequired: number?, -- Qi needed to attempt breakthrough into NextRealm
	NextRealm: RealmId?,
}

local Realms: { [RealmId]: RealmDefinition } = {
	Mortal = {
		Id = "Mortal",
		Name = "Mortal",
		QiRequired = 100,
		NextRealm = "BodyTempering",
	},
	BodyTempering = {
		Id = "BodyTempering",
		Name = "Body Tempering",
		QiRequired = nil,
		NextRealm = nil,
	},
}

return Realms
