--!strict
-- Cultivation paths available in Phase 1.

local Techniques = require(script.Parent.Techniques)

export type PathId = "Sword" | "Body"

export type PathDefinition = {
	Id: PathId,
	Name: string,
	StartingTechnique: Techniques.TechniqueId,
}

local Paths: { [PathId]: PathDefinition } = {
	Sword = {
		Id = "Sword",
		Name = "Path of the Sword",
		StartingTechnique = "QuickSlash",
	},
	Body = {
		Id = "Body",
		Name = "Path of the Body",
		StartingTechnique = "IronPalm",
	},
}

return Paths
