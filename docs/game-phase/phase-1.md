# Phase 1 — Vertical Slice (MVP)

**Status:** In progress  
**Parent doc:** [GAME_DESIGN.md](../GAME_DESIGN.md)  
**Started:** July 2026

---

## Purpose

Phase 1 is our **first real development**. The goal is not to build the full game — it is to ship **one complete cultivation loop** that feels like Acend, not a generic Roblox training sim.

When Phase 1 is done, a new player should be able to:

1. Join the game and receive random talents
2. Choose a cultivation path (Sword or Body)
3. Cultivate Qi through combat or meditation
4. Attempt a breakthrough from **Mortal** → **Body Tempering**
5. Evolve their weapon from **Rusty Sword** → **Spirit Sword**
6. Defeat a zone boss
7. Tell a friend which path they chose and what happened during their breakthrough

> **Success metric:** One session, one story, one identity — not just a bigger number.

---

## Core Mechanic (Phase 1 Scope)

Everything in this phase supports the core loop:

```
Cultivate Qi  →  Breakthrough trial  →  Unlock Body Tempering
      ↑                                        │
      └──── fight, meditate, use techniques ───┘
```

Phase 1 does **not** include factions, world bosses, fusion, ascension branches, sects, or server world evolution. Those come in later phases.

---

## What We Are Building

### 1. Cultivation System

| Feature | Description |
|---------|-------------|
| Qi | Primary progression resource; fills toward next breakthrough |
| Realms | **Mortal** and **Body Tempering** only |
| Cultivation modes | **Combat** (hit enemies / use technique) and **Meditation** (stand in zone, slower but safe) |
| Breakthrough | Triggered at 100% Qi; simple trial before realm advances |
| Failure | Soft penalty only (lose some Qi, short cooldown) — keep early game forgiving |

### 2. Cultivation Paths (2 of 4)

| Path | Phase 1 technique | Playstyle |
|------|-------------------|-----------|
| **Sword** | Quick Slash | Fast strikes, mobility |
| **Body** | Iron Palm | Slower, higher damage, more survivability |

- Player picks path after tutorial or on first spawn
- One technique per path in Phase 1
- Technique use grants Qi + mastery XP

### 3. Mastery (Minimal)

- Track use count per technique
- One mastery milestone in Phase 1 (e.g. Quick Slash → **Heavy Slash** at 500 uses)
- Mastery shown in HUD; evolution is a feel-good reward, not required to finish Phase 1

### 4. Talents (On First Join)

- Roll **3 random talents** from a small pool (5–8 talents)
- Each talent has a clear bonus and optional tradeoff
- Stored in player profile; shown on a simple talents panel
- Examples: Fire Affinity, Fast Meditation, Unstable Core

### 5. Weapon Evolution

| Stage | How to unlock |
|-------|----------------|
| Rusty Sword | Default on join |
| Spirit Sword | Body Tempering realm + 50 combat wins (or boss kill) |

- One weapon slot; no inventory swapping in Phase 1
- Visual change on evolution (color, trail, or mesh swap if asset ready)

### 6. Zone Boss

- **One** scripted boss in a dedicated arena or zone
- Designed for 1–3 players
- Drops breakthrough material (optional bonus) and counts toward weapon evolution
- Static AI is fine for Phase 1 — dynamic migration comes in Phase 3

### 7. Basic HUD

| UI element | Shows |
|------------|--------|
| Realm & path | e.g. `Mortal — Path of the Sword` |
| Qi bar | Current / required for breakthrough |
| Technique | Equipped technique + mastery progress |
| Talents | Compact list or icon row |
| Weapon | Name + evolution stage |
| Materials | Coins / spirit stones (if used in Phase 1) |

Replace `ExampleController` print-only coin feedback with real UI.

### 8. World (Minimal)

- Training / meditation zone (safe area)
- Combat zone with basic enemies (respawning mobs)
- Boss arena
- Spawn hub connecting zones

Default baseplate is acceptable; zones can be marked with parts + labels until art passes.

---

## Out of Scope (Phase 1)

Do not build these yet — they belong to later phases:

- Spirit Gathering realm and above
- Element and Summoning paths
- Technique fusion
- Faction reputation
- World events (caravans, meteorites)
- Dynamic / migrating bosses
- Boss learning AI
- Mentor system
- Ascension branches (God / Demon / Dragon / Machine)
- Reincarnation
- Sects
- Legend Codex (full version)
- PvP

---

## Technical Plan

Aligned with the existing Acend codebase (Rojo, Wally, ProfileStore, service/controller pattern).

### New / Updated Files

```
src/
├── shared/
│   ├── Types.luau                    ← expand ProfileData
│   ├── Config/
│   │   ├── GameConfig.luau           ← Qi rates, breakthrough thresholds
│   │   ├── Realms.luau               ← Mortal, Body Tempering definitions
│   │   ├── Paths.luau                ← Sword, Body definitions
│   │   ├── Talents.luau              ← talent pool + effects
│   │   ├── Techniques.luau           ← technique stats + mastery tiers
│   │   └── Weapons.luau              ← evolution chain
│   └── Net/
│       └── Remotes.luau              ← cultivation, breakthrough, path pick, HUD sync
├── server/
│   └── Services/
│       ├── PlayerDataService.luau    ← new profile fields, reconcile
│       ├── CultivationService.luau   ← Qi gain, breakthrough logic
│       ├── CombatService.luau        ← damage, technique validation (server-authoritative)
│       ├── TalentService.luau        ← roll on first join
│       └── BossService.luau          ← zone boss spawn + rewards
└── client/
    └── Controllers/
        ├── CultivationController.luau  ← meditation, breakthrough UI flow
        ├── CombatController.luau       ← technique input, VFX placeholders
        ├── HudController.luau          ← realm, Qi, talents, weapon
        └── PathSelectController.luau     ← first-time path choice
```

### ProfileData (Phase 1 Fields)

```luau
export type ProfileData = {
    -- existing
    Coins: number,

    -- cultivation
    Realm: string,              -- "Mortal" | "BodyTempering"
    Qi: number,
    Path: string?,              -- nil until chosen: "Sword" | "Body"
    Talents: { string },        -- 3 talent ids

    -- techniques
    EquippedTechnique: string?,
    TechniqueMastery: { [string]: number },  -- techniqueId -> use count

    -- weapon
    WeaponStage: string,        -- "RustySword" | "SpiritSword"
    CombatWins: number,

    -- breakthrough
    BreakthroughCooldownUntil: number?,  -- os.time() when ready again
    HasCompletedTutorial: boolean,
}
```

### Remotes (Phase 1)

| Remote | Direction | Purpose |
|--------|-----------|---------|
| `CultivationUpdated` | Server → Client | Qi, realm, path sync |
| `RequestMeditate` | Client → Server | Start/stop meditation |
| `RequestBreakthrough` | Client → Server | Begin breakthrough trial |
| `BreakthroughResult` | Server → Client | Success / fail + rewards |
| `SelectPath` | Client → Server | First-time path choice |
| `UseTechnique` | Client → Server | Combat technique (validated) |
| `TalentRolled` | Server → Client | Initial talent display |
| `WeaponEvolved` | Server → Client | Weapon stage change |

### Architecture Rules

- **Server authoritative** — Qi, damage, breakthrough outcomes, mastery counts never trusted from client
- **Config-driven** — balance numbers in `shared/Config/`, not hardcoded in services
- **Subscribe on load** — services listen to `PlayerDataService.ProfileLoaded` before acting on a player
- **One service per domain** — cultivation, combat, boss stay separate; avoid a god script

---

## Development Milestones

### Milestone A — Data & Config
- [ ] Expand `ProfileData` in `Types.luau`
- [ ] Update `PlayerDataService` template + reconcile
- [ ] Add config modules: Realms, Paths, Talents, Techniques, Weapons
- [ ] Add Phase 1 remotes to `Remotes.luau`
- [ ] Remove or repurpose placeholder `Coins`-only flow if unused

### Milestone B — Cultivation Loop
- [ ] `CultivationService`: Qi gain from meditation
- [ ] `CultivationService`: breakthrough request + simple trial (survive timer or kill 1 weak enemy)
- [ ] Realm advance Mortal → Body Tempering on success
- [ ] Soft failure state (Qi loss + cooldown)
- [ ] `CultivationController` + server sync

### Milestone C — Path & Talents
- [ ] `TalentService`: roll 3 talents on first join
- [ ] Path select UI on first spawn (Sword vs Body)
- [ ] Grant starting technique based on path
- [ ] Talent modifiers applied to Qi rate / damage (at least 2 talents functional)

### Milestone D — Combat & Mastery
- [ ] Basic enemies in combat zone (server-spawned, simple chase + melee)
- [ ] `CombatService` + `CombatController`: one technique per path
- [ ] Qi + mastery increment on valid hits
- [ ] One mastery evolution threshold (optional polish)

### Milestone E — Weapon & Boss
- [ ] Track `CombatWins` on enemy / boss kills
- [ ] Weapon evolution Rusty Sword → Spirit Sword
- [ ] One zone boss with HP bar (client) and loot / win credit (server)
- [ ] Boss reachable after or during Body Tempering

### Milestone F — HUD & Polish
- [ ] `HudController`: realm, Qi bar, path, technique, talents, weapon
- [ ] Breakthrough moment feedback (screen flash, sound placeholder, chat message)
- [ ] Zone labels or map markers for train / fight / boss areas
- [ ] Playtest full loop start to finish

---

## Balancing Targets (Starting Values)

Tune in `GameConfig.luau` — these are first guesses:

| Setting | Value |
|---------|-------|
| Qi required (Mortal → Body Tempering) | 100 |
| Qi per meditation tick | 1 every 2s |
| Qi per technique hit | 3–5 |
| Breakthrough trial | Survive 20s in a small arena OR defeat inner demon (1 weak mob) |
| Breakthrough fail Qi loss | 25% of current Qi |
| Breakthrough cooldown | 30 seconds |
| Mastery tier 1 | 500 technique uses |
| Spirit Sword requirement | Body Tempering + 50 combat wins |

Adjust after first playtest.

---

## Acceptance Criteria (Phase 1 Complete)

All of the following must be true:

- [ ] New player joins → talents rolled → path selection shown
- [ ] Player can fill Qi bar via meditation **or** combat
- [ ] Player can attempt breakthrough; success advances to Body Tempering
- [ ] Failed breakthrough applies soft penalty, not a kick or hard reset
- [ ] Sword and Body paths feel different in combat (speed vs power)
- [ ] Weapon evolves to Spirit Sword when conditions met
- [ ] Zone boss can be defeated and counts toward progression
- [ ] HUD shows realm, Qi, path, technique, talents, weapon
- [ ] All progression persists across rejoin (ProfileStore)
- [ ] No client-trusted stat changes for Qi, mastery, or realm

---

## Current Codebase Status

**Phase 0 (complete):**

- [x] Rojo project structure
- [x] ProfileStore via `PlayerDataService`
- [x] Service / controller auto-bootstrap
- [x] Central remotes registry
- [x] Example client listening for `CoinsUpdated`

**Phase 1 (not started in code):**

- [ ] Profile schema expansion
- [ ] Cultivation system
- [ ] All milestones A–F above

---

## Open Decisions (Resolve During Phase 1)

| Question | Recommendation for Phase 1 |
|----------|---------------------------|
| Breakthrough failure rate | Forgiving — ~80–90% success for first realm |
| Meditation vs combat balance | Combat 2–3× faster; meditation safer for AFK-light players |
| Coins in Phase 1 | Keep as secondary currency for a future shop; not core loop |
| Boss difficulty | Beatable solo at Body Tempering with learned technique |
| Art scope | Placeholder parts + UI first; swap assets later |

---

## Playtest Script

Use this checklist when testing Phase 1:

1. Join as a new player (or wipe test data)
2. Note the 3 rolled talents
3. Pick Sword or Body
4. Meditate until ~30% Qi — confirm HUD updates
5. Fight enemies with your technique — confirm Qi and mastery rise
6. Attempt breakthrough before 100% Qi — should fail gracefully
7. Reach 100% Qi — attempt breakthrough — pass trial
8. Confirm Body Tempering realm and any unlocks
9. Grind combat wins / beat boss — confirm Spirit Sword evolution
10. Leave and rejoin — confirm all data saved

---

## After Phase 1

When this phase is complete, move to **Phase 2** (Identity & Depth):

- Add Element and Summoning paths
- Technique fusion (5–10 recipes)
- Two factions with reputation
- Random world micro-events

Do not start Phase 2 until the Phase 1 playtest script passes and the core loop feels fun.

---

*Phase 1 document version: 1.0 — July 2026*
