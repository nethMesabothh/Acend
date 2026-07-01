--!strict
-- Central registry of RemoteEvents/RemoteFunctions. Add new remotes here
-- instead of creating Instances ad hoc, so every network call is traceable
-- from one place.

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local FOLDER_NAME = "RemoteEvents"

local function getOrCreateFolder(): Folder
	local existing = ReplicatedStorage:FindFirstChild(FOLDER_NAME)
	if existing then
		return existing :: Folder
	end

	local folder = Instance.new("Folder")
	folder.Name = FOLDER_NAME
	folder.Parent = ReplicatedStorage
	return folder
end

local function getOrCreateRemoteEvent(folder: Folder, name: string): RemoteEvent
	local existing = folder:FindFirstChild(name)
	if existing then
		return existing :: RemoteEvent
	end

	local remote = Instance.new("RemoteEvent")
	remote.Name = name
	remote.Parent = folder
	return remote
end

local folder = getOrCreateFolder()

-- Declare every remote your game uses here.
local Remotes = {
	-- cultivation loop (Phase 1)
	CultivationUpdated = getOrCreateRemoteEvent(folder, "CultivationUpdated"),
	RequestMeditate = getOrCreateRemoteEvent(folder, "RequestMeditate"),
	RequestBreakthrough = getOrCreateRemoteEvent(folder, "RequestBreakthrough"),
	BreakthroughResult = getOrCreateRemoteEvent(folder, "BreakthroughResult"),
	SelectPath = getOrCreateRemoteEvent(folder, "SelectPath"),
	UseTechnique = getOrCreateRemoteEvent(folder, "UseTechnique"),
	TalentRolled = getOrCreateRemoteEvent(folder, "TalentRolled"),
	WeaponEvolved = getOrCreateRemoteEvent(folder, "WeaponEvolved"),
}

return Remotes
