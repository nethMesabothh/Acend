--!strict
-- Balancing/data tables live here, separate from logic, so designers can
-- tweak numbers without touching service code.

export type GameConfig = {
	StartingCoins: number,
}

local GameConfig: GameConfig = {
	StartingCoins = 0,
}

return GameConfig
