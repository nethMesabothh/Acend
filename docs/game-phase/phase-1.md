# Phase 1 — Vertical Slice (MVP)

**Status:** In progress
**Parent doc:** [GAME_DESIGN.md](../GAME_DESIGN.md)
**Started:** July 2026
**Revised:** July 2026 — rescoped around the cultivation stage-clearer pivot (Physical/Magic duality, Stage system replacing the single zone boss). Milestones A–C below are implementation-compatible with the revision; only D–F changed shape.

---

## Purpose

Phase 1 is our **first real development**. The goal is not to build the full game — it is to ship **one complete loop**: cultivate your spirit, train your body, breakthrough, and clear a handful of stages that actually require both.

When Phase 1 is done, a new player should be able to:

1. Join the game and receive random talents
2. Choose a cultivation path (Sword or Body — both Physical-flavored; Magic is available to everyone once unlocked)
3. Grow **two separate stats**: Qi (via meditation) and Strength (via training)
4. Attempt a breakthrough from **Mortal** → **Body Tempering**
5. Evolve their weapon from **Rusty Sword** → **Spirit Sword**
6. Clear a Beast stage (Physical only), a Demon stage (Magic only), and feel *why* both stats matter
7. Tell a friend which path they chose and whether they got walled by an enemy type their build couldn't touch

> **Success metric:** One session, one story — including "I got wrecked by Demons until I trained my Qi."

---

## Core Mechanic (Phase 1 Scope)

```
Cultivate (Qi)  +  Train (Strength)  →  Breakthrough  →  Clear Stages
      ↑                                                        │
      └──────────── fight, meditate, use techniques ───────────┘
```

Phase 1 does **not** include: Elements/Summoning paths, technique fusion, factions, world bosses, living-world events, sects, ascension branches, mentor system, or Mixed-type stages (pure Beast/Demon stages only for now). Those are deferred — see [Future Ideas](../GAME_DESIGN.md#future-ideas-backlog) in the GDD.

---

## What We Are Building

### 1. Cultivation System (Milestone B — built)

| Feature | Description |
|---------|-------------|
| Qi | Spirit-power resource; fills toward breakthrough; grown via meditation |
| Realms | **Mortal** and **Body Tempering** only |
| Breakthrough | Triggered at 100% Qi; timed trial; soft failure (Qi loss + cooldown) |

### 2. Training System (Milestone D — new)

| Feature | Description |
|---------|-------------|
| Strength | Body-power resource; grown via active combat drills (using a Physical technique on a target) |
| No meditation equivalent | Strength cannot be gained passively — it requires actually fighting, mirroring Qi's safe/passive meditation |

### 3. Cultivation Paths (2 of 4) — built, reused as-is

| Path | Phase 1 technique | Damage Type |
|------|-------------------|-------------|
| **Sword** | Quick Slash | Physical |
| **Body** | Iron Palm | Physical |

Both Phase 1 paths are Physical-flavored (matches the original design). Everyone additionally gets one baseline **Magic** technique once Spirit Gathering-adjacent Qi thresholds are reached — see Milestone D for the exact unlock rule to design.

### 4. Combat: Physical vs. Magic (Milestone D — new, core to the pivot)

| Damage Type | Source Stat | Hits | No Effect On |
|-------------|-------------|------|---------------|
| Physical | Strength | Beasts | Demons |
| Magic | Qi | Demons | Beasts |

This is a hard gate (0 damage, not reduced damage) — see GDD §2 for rationale. `CombatService` must check `(technique.DamageType, enemy.Type)` before applying damage, server-side, every hit.

### 5. Mastery (Minimal) — built, reused

- Track use count per technique; Quick Slash → Heavy Slash at 500 uses.

### 6. Talents (On First Join) — built, reused

- 3 random talents from the existing pool; unchanged.

### 7. Weapon Evolution — built config, needs stage-clear hook

| Stage | How to unlock |
|-------|----------------|
| Rusty Sword | Default on join |
| Spirit Sword | Body Tempering realm + clearing Stage 3 (was: "50 combat wins" — replaced with stage-clear count to tie into the new structure) |

### 8. Stage System (Milestone E — new, replaces "Zone Boss")

- **3–5 sequential stages**, each a self-contained arena:
  - Stage 1 — Beast (Physical only)
  - Stage 2 — Demon (Magic only)
  - Stage 3 — Beast, harder
  - Stage 4 — Demon, harder
  - Stage 5 — Boss stage (may require both damage types across phases — simplest version: two phases, one per damage type)
- Clearing a stage's waves spawns that stage's boss; beating it unlocks the next stage and grants rewards.
- Static spawns/AI is fine for Phase 1 — dynamic/adaptive bosses are a Future Idea, not Phase 1.

### 9. Basic HUD (Milestone F)

| UI element | Shows |
|------------|--------|
| Realm & path | e.g. `Mortal — Path of the Sword` |
| Qi bar | Current / required for breakthrough |
| Strength bar | Current training progress |
| Stage | Current stage number, cleared/total |
| Technique | Equipped technique(s) + damage type icon + mastery progress |
| Talents | Compact list or icon row |
| Weapon | Name + evolution stage |

Replace the debug print-based `CultivationController`/`PathSelectController` output with real UI.

### 10. World (Minimal)

- Meditation zone (safe, passive Qi gain)
- Training zone (Strength gain via drills)
- One arena per stage
- Default baseplate + labeled parts is acceptable; art passes come later.

---

## Out of Scope (Phase 1)

- Mixed-type stages beyond a simple two-phase final boss
- Elements and Summoning paths
- Technique fusion
- Faction reputation, world events, migrating/adaptive bosses
- Mentor system, sects, ascension branches, reincarnation
- PvP

---

## Technical Plan

### New / Updated Files

```
src/
├── shared/
│   ├── Types.luau                    ← add Strength, StagesCleared
│   ├── Config/
│   │   ├── GameConfig.luau           ← (built) add training rate, damage formulas
│   │   ├── Realms.luau               ← (built)
│   │   ├── Paths.luau                ← (built)
│   │   ├── Talents.luau              ← (built)
│   │   ├── Techniques.luau           ← (built) add DamageType field
│   │   ├── Weapons.luau              ← (built) rework unlock condition to stage-based
│   │   ├── Enemies.luau              ← NEW: Beast/Demon type definitions + resistances
│   │   └── Stages.luau               ← NEW: stage definitions (enemy waves, boss, rewards)
│   └── Net/
│       └── Remotes.luau              ← (built) add StageUpdated, EnterStage, StageCleared
├── server/
│   └── Services/
│       ├── PlayerDataService.luau    ← (built) add Strength/StagesCleared to template
│       ├── CultivationService.luau   ← (built) add Strength check to breakthrough gate
│       ├── TalentService.luau        ← (built)
│       ├── CombatService.luau        ← NEW: technique validation, damage-type resistance check, Strength gain
│       └── StageService.luau         ← NEW: stage progression, wave spawning, boss, rewards
└── client/
    └── Controllers/
        ├── CultivationController.luau     ← (built, debug) replace with real HUD in Milestone F
        ├── PathSelectController.luau      ← (built, debug)
        ├── MeditationVisualsController.luau ← (built)
        ├── CombatController.luau          ← NEW: technique input, hit VFX placeholders
        ├── StageController.luau           ← NEW: stage/wave UI feedback
        └── HudController.luau             ← NEW (Milestone F)
```

### ProfileData (Phase 1 Fields)

```luau
export type ProfileData = {
    -- existing (built)
    Coins: number,
    Realm: string,
    Qi: number,
    Path: string?,
    Talents: { string },
    EquippedTechnique: string?,
    TechniqueMastery: { [string]: number },
    WeaponStage: string,
    CombatWins: number,
    BreakthroughCooldownUntil: number?,
    HasCompletedTutorial: boolean,

    -- new for the pivot
    Strength: number,           -- body power, grown via training
    StagesCleared: number,      -- highest stage cleared
}
```

### Remotes (Phase 1)

| Remote | Direction | Purpose | Status |
|--------|-----------|---------|--------|
| `CultivationUpdated` | Server → Client | Qi, realm, path sync | Built |
| `RequestMeditate` | Client → Server | Start/stop meditation | Built |
| `RequestBreakthrough` | Client → Server | Begin breakthrough trial | Built |
| `BreakthroughResult` | Server → Client | Success / fail + rewards | Built |
| `SelectPath` | Client → Server | First-time path choice | Built |
| `TalentRolled` | Server → Client | Initial talent display | Built |
| `WeaponEvolved` | Server → Client | Weapon stage change | Declared, not wired |
| `UseTechnique` | Client → Server | Combat technique (validated) | Declared, not wired |
| `EnterStage` | Client → Server | Request to enter a stage | New |
| `StageUpdated` | Server → Client | Wave/boss progress sync | New |
| `StageCleared` | Server → Client | Stage cleared + rewards | New |

### Architecture Rules (unchanged)

- **Server authoritative** — Qi, Strength, damage, breakthrough outcomes, stage clears never trusted from client.
- **Config-driven** — balance numbers in `shared/Config/`, including per-technique `DamageType` and per-enemy `Type`.
- **Subscribe on load** — services listen to `PlayerDataService.ProfileLoaded`.
- **One service per domain** — cultivation, combat, stages stay separate.

---

## Development Milestones

### Milestone A — Data & Config — **Done**
- [x] `ProfileData` in `Types.luau`
- [x] `PlayerDataService` template + reconcile
- [x] Config modules: Realms, Paths, Talents, Techniques, Weapons
- [x] Phase 1 remotes declared in `Remotes.luau`
- [ ] Add `Strength`, `StagesCleared` to `ProfileData` + template
- [ ] Add `Enemies.luau`, `Stages.luau` config modules
- [ ] Add `DamageType` field to each technique in `Techniques.luau`

### Milestone B — Cultivation Loop — **Done**
- [x] `CultivationService`: Qi gain from meditation
- [x] `CultivationService`: breakthrough request + 20s trial + 85% base success roll
- [x] Realm advance Mortal → Body Tempering on success
- [x] Soft failure state (Qi loss + cooldown)
- [x] Qi capped at realm's `QiRequired`
- [x] Talent modifiers applied (`MeditationQiRate`, `BreakthroughFailChance`)
- [ ] Breakthrough gate also requires a Strength threshold (once Milestone D lands)

### Milestone C — Path & Talents — **Done**
- [x] `TalentService`: roll 3 talents on first join (own check, not Reconcile)
- [x] `SelectPath` handling: grants starting Physical technique
- [x] Debug controls: `PathSelectController`

### Milestone D — Training & Combat — **Not started (rescoped from "Combat & Mastery")**
- [ ] Training zone: Strength gain from active technique use on a target dummy/enemy
- [ ] `CombatService`: technique validation, server-authoritative damage
- [ ] Damage-type resistance check: Physical techniques do 0 damage to Demons, Magic techniques do 0 damage to Beasts
- [ ] Baseline Magic technique granted to all players once a Qi/realm threshold is met
- [ ] Qi + mastery increment on valid hits (existing mastery system extends naturally)
- [ ] `CombatController`: technique input, hit VFX placeholders

### Milestone E — Stages & Weapon — **Not started (rescoped from "Weapon & Boss")**
- [ ] `Stages.luau`: define Stage 1 (Beast) through Stage 5 (boss, two-phase)
- [ ] `Enemies.luau`: Beast/Demon type definitions + resistances
- [ ] `StageService`: wave spawning, stage-clear detection, boss spawn, rewards
- [ ] Weapon evolution Rusty Sword → Spirit Sword on Body Tempering + Stage 3 clear
- [ ] `StageController`: stage/wave UI feedback (client)

### Milestone F — HUD & Polish — **Not started**
- [ ] `HudController`: realm, Qi bar, Strength bar, current stage, path, technique(s), talents, weapon
- [ ] Damage-type indicator on technique icons (so "this won't work on Demons" is legible before you swing)
- [ ] Breakthrough / stage-clear feedback (screen flash, sound placeholder, chat message)
- [ ] Replace debug print output in `CultivationController`/`PathSelectController` with real UI
- [ ] Playtest full loop start to finish

---

## Balancing Targets (Starting Values)

Tune in `GameConfig.luau` — first guesses; existing Qi/breakthrough values already implemented, Strength/combat values are new:

| Setting | Value | Status |
|---------|-------|--------|
| Qi required (Mortal → Body Tempering) | 100 | Built |
| Qi per meditation tick | 1 every 2s | Built |
| Breakthrough trial duration | 20s | Built |
| Breakthrough base success chance | 85% | Built |
| Breakthrough fail Qi loss | 25% of current Qi | Built |
| Breakthrough cooldown | 30 seconds | Built |
| Mastery tier 1 | 500 technique uses | Built |
| Strength required (Mortal → Body Tempering) | 100 (mirrors Qi) | New — needs config |
| Strength per successful training hit | 3–5 | New — needs config |
| Physical/Magic damage to wrong enemy type | 0 (hard gate) | New — needs config |
| Spirit Sword requirement | Body Tempering + Stage 3 cleared | Changed from "50 combat wins" |

Adjust after first playtest.

---

## Acceptance Criteria (Phase 1 Complete)

- [ ] New player joins → talents rolled → path selection shown
- [x] Player can fill Qi bar via meditation
- [ ] Player can fill Strength bar via training (active combat drills)
- [x] Player can attempt breakthrough; success advances to Body Tempering
- [x] Failed breakthrough applies soft penalty, not a kick or hard reset
- [ ] A Physical-only build cannot damage Demons; a Magic-only build cannot damage Beasts (verified in Studio, not just in code)
- [ ] Sword and Body paths feel different in combat (speed vs power), both Physical
- [ ] Weapon evolves to Spirit Sword when conditions met
- [ ] Player can clear at least 3 sequential stages, including one of each enemy type
- [ ] HUD shows realm, Qi, Strength, path, technique(s), talents, weapon, current stage
- [x] Cultivation progression persists across rejoin (ProfileStore)
- [ ] Strength and stage progress also persist across rejoin
- [x] No client-trusted stat changes for Qi, mastery, or realm
- [ ] No client-trusted stat changes for Strength or stage clears

---

## Current Codebase Status

**Phase 0 (complete):**

- [x] Rojo project structure, ProfileStore, service/controller bootstrap, central remotes registry

**Phase 1 (in progress):**

- [x] Milestone A — Data & Config (needs Strength/Stages additions)
- [x] Milestone B — Cultivation Loop
- [x] Milestone C — Path & Talents
- [x] Meditation visual feedback (Qi aura particle effect + frozen idle while meditating) — confirmed working live in Studio; a real body-pose animation is deferred (current Roblox R15 rigs are fully constraint-based, so classic Motor6D joint-posing doesn't work on any character — a real `Animation` asset is required and wasn't in scope yet)
- [ ] Milestone D — Training & Combat
- [ ] Milestone E — Stages & Weapon
- [ ] Milestone F — HUD & Polish

---

## Open Decisions (Resolve During Milestone D/E)

| Question | Recommendation |
|----------|-----------------|
| Breakthrough failure rate | Keep forgiving — 85% success, already tuned |
| Strength gain balance vs. Qi | Mirror meditation's numbers 1:1 to start (3-5 per hit vs 1 per 2s tick — combat should feel faster, matching original "combat 2-3x faster" intent) |
| How is the baseline Magic technique granted? | Simplest: available to everyone once Qi ≥ 50% of Mortal's requirement, no separate unlock quest |
| Coins in Phase 1 | Still secondary; not core loop |
| Stage difficulty curve | Beatable solo; Stage 5 boss may need a partner if playtesting shows it's too hard alone |

---

## Playtest Script

1. Join as a new player (or wipe test data)
2. Note the 3 rolled talents, pick Sword or Body
3. Meditate until ~30% Qi — confirm HUD updates
4. Train (fight a dummy) until Strength rises — confirm HUD updates
5. Attempt breakthrough before 100% Qi/Strength — should fail gracefully
6. Reach both thresholds — attempt breakthrough — pass trial
7. Enter Stage 1 (Beast) — confirm Physical technique works, Magic technique (if equipped) does nothing
8. Enter Stage 2 (Demon) — confirm the reverse
9. Clear Stage 3 — confirm Spirit Sword evolution
10. Leave and rejoin — confirm all data (including Strength, stage progress) saved

---

## After Phase 1

When this phase is complete, move to **Phase 2** (More Stages, More Depth) — see [GAME_DESIGN.md](../GAME_DESIGN.md#phase-2--more-stages-more-depth).

Do not start Phase 2 until the Phase 1 playtest script passes and the Physical/Magic gate actually feels like a real decision, not busywork.

---

*Phase 1 document version: 2.0 — July 2026 (revised for the cultivation stage-clearer pivot)*
