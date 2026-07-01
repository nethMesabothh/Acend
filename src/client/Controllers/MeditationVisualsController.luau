--!strict
-- Applies a Qi aura to any character whose "Meditating" attribute is true,
-- and freezes its idle animation so it visibly holds still. Runs identically
-- on every client, so a meditating player looks the same to everyone
-- watching, not just themself.
--
-- NOTE: current Roblox R15 rigs (even a bare CreateHumanoidModelFromDescription
-- rig) have zero Motor6Ds — they're fully constraint-driven (BallSocketConstraint
-- / AnimationConstraint) — so direct joint posing (the classic Motor6D.C0
-- tutorial approach) no longer works on any rig. A real meditation pose needs
-- an actual Animation asset played through Animator; see PathSelectController's
-- follow-up conversation for options.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local GameConfig = require(ReplicatedStorage.Shared.Config.GameConfig)

local MeditationVisualsController = {}

local function createAura(rootPart: BasePart)
	local attachment = Instance.new("Attachment")
	attachment.Name = "QiAuraAttachment"

	local emitter = Instance.new("ParticleEmitter")
	emitter.Name = "QiAura"
	emitter.Texture = "rbxasset://textures/particles/sparkles_main.dds"
	emitter.Color = ColorSequence.new(GameConfig.QiAuraColor)
	emitter.Size = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0.4),
		NumberSequenceKeypoint.new(1, 0),
	})
	emitter.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0.2),
		NumberSequenceKeypoint.new(1, 1),
	})
	emitter.Lifetime = NumberRange.new(0.8, 1.4)
	emitter.Rate = 20
	emitter.Speed = NumberRange.new(2, 3)
	emitter.SpreadAngle = Vector2.new(180, 180)
	emitter.Parent = attachment

	attachment.Parent = rootPart
end

local function applyMeditationVisuals(character: Model)
	local animateScript = character:FindFirstChild("Animate")
	if animateScript then
		(animateScript :: Instance & { Disabled: boolean }).Disabled = true
	end

	local rootPart = character:FindFirstChild("HumanoidRootPart")
	if rootPart and rootPart:IsA("BasePart") and not rootPart:FindFirstChild("QiAuraAttachment") then
		createAura(rootPart)
	end
end

local function clearMeditationVisuals(character: Model)
	local animateScript = character:FindFirstChild("Animate")
	if animateScript then
		(animateScript :: Instance & { Disabled: boolean }).Disabled = false
	end

	local rootPart = character:FindFirstChild("HumanoidRootPart")
	local attachment = rootPart and rootPart:FindFirstChild("QiAuraAttachment")
	if attachment then
		attachment:Destroy()
	end
end

local function watchCharacter(character: Model)
	if character:GetAttribute("Meditating") then
		applyMeditationVisuals(character)
	end

	character:GetAttributeChangedSignal("Meditating"):Connect(function()
		if character:GetAttribute("Meditating") then
			applyMeditationVisuals(character)
		else
			clearMeditationVisuals(character)
		end
	end)
end

local function watchPlayer(player: Player)
	if player.Character then
		watchCharacter(player.Character)
	end
	player.CharacterAdded:Connect(watchCharacter)
end

function MeditationVisualsController.Start()
	for _, player in Players:GetPlayers() do
		watchPlayer(player)
	end
	Players.PlayerAdded:Connect(watchPlayer)
end

return MeditationVisualsController
