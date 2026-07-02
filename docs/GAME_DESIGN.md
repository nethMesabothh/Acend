# Acend — Game Design Document

**Genre:** Cultivation Stage-Clearer
**Platform:** Roblox
**Working title:** Acend
**Status:** Pre-production / design phase

---

## Vision

Acend is a **cultivation stage-clearer**: train, grow stronger, and push through an escalating ladder of stages. The loop stays tight and legible — no menus to get lost in, no systems that don't pay off in your hands within a session.

The core fantasy:

> *You are a cultivator forging both body and spirit — strong enough in each to face any foe, weak in neither.*

### Design Pillars

| Pillar | Meaning |
|--------|---------|
| **Two powers, one cultivator** | Body (Strength) and Spirit (Qi) are separate stats you grow separately — not one number that goes up |
| **Right tool, right foe** | Beasts fall only to Physical damage. Demons fall only to Magic damage. No single build clears everything |
| **Stage by stage** | Clear a stage, get stronger, push to the next. Progress is always visible and always earned |
| **Growth you can feel** | Breakthroughs, mastery, and weapon evolution are events worth remembering, not stat ticks |

### What We Are Not Building (For Now)

- A sprawling living-world MMO with factions, migrating world bosses, and server memory (see [Future Ideas](#future-ideas-backlog) — not cut, just not now)
- A game where one damage type trivializes every fight
- A linear "click train → number go up" simulator with no build decisions

---

## Core Progression Loop

```
Cultivate (Spirit / Qi)  +  Train (Body / Strength)
                  ↓
       Breakthrough (realm advances)
                  ↓
      New techniques, higher damage caps
                  ↓
     Clear the next Stage (Beasts / Demons / Boss)
                  ↓
   Materials, Coins, weapon evolution progress
                  ↓
              Repeat, harder
```

Every step should answer: **"What can I fight now that I couldn't before?"**

---

## 1. Two Paths to Power

Every cultivator grows through **two separate stats**, not one:

| Stat | Gained by | Governs |
|------|-----------|---------|
| **Qi (Spirit Power)** | Cultivation — meditation in safe zones | Magic damage, max Qi |
| **Strength (Body Power)** | Training — active combat drills / sparring | Physical damage, max Stamina/HP |

Neither stat is optional. A player who only meditates can out-damage any Demon but will bounce off every Beast. A player who only trains is the reverse. **Breakthrough to the next realm requires meeting a threshold in both** — you cannot out-grind one stat to skip the other.

This replaces the old "pick one skill tree" model: the two stats aren't a build choice you make once, they're both always growing, and the *ratio* between them is your identity (a Body-heavy cultivator, a Spirit-heavy one, or a balanced one).

### Cultivation Realm Ladder (Kept from original design)

| Realm | Fantasy |
|-------|---------|
| Mortal | Ordinary beginning; no techniques |
| Body Tempering | Physical foundation; Strength techniques unlock |
| Spirit Gathering | Qi manipulation; Magic techniques unlock |
| Core Formation | Stable inner core; higher stage tiers unlock |
| Nascent Soul | Soul projection; advanced stages |

Breakthroughs remain **events, not stat ticks**: a trial (survive a timer, or later, an inner-demon fight), with a soft failure penalty (partial Qi/Strength loss + cooldown), never a full reset.

---

## 2. Combat: Physical vs. Magic

Two damage types. Every technique deals one or the other.

| Damage Type | Source Stat | Effective Against | No Effect Against |
|-------------|-------------|--------------------|--------------------|
| **Physical** | Strength | Beasts | Demons |
| **Magic** | Qi | Demons | Beasts |

This is a **hard gate, not a percentage bonus** — a Beast takes 0 damage from Magic, a Demon takes 0 damage from Physical. That's the point: it forces real investment in both stats (or real teamwork with someone who covers your gap), rather than a soft "+20% vs X" that a strong enough single build can ignore.

**Enemy Types**

| Type | Weak to | Immune to | Fantasy |
|------|---------|-----------|---------|
| Beast | Physical | Magic | Feral creatures, wildlife corrupted by Qi |
| Demon | Magic | Physical | Spirits, corrupted Qi given form |
| *(Later)* Mixed / Boss | Both required | — | Multi-phase fights, gates real dual investment |

---

## 3. Stage System

Replaces an open living world (for now) with a **sequential ladder of stages** — legible, testable, and finishable in a session.

- Stages are numbered (Stage 1, 2, 3, …), each a self-contained arena.
- Each stage has a fixed enemy composition: a **Beast stage**, a **Demon stage**, or a **Mixed stage**.
- Clearing all waves in a stage spawns a **stage boss**; defeating it clears the stage and unlocks the next.
- Difficulty (enemy count, HP, damage) scales with stage number.
- Rewards per clear: Coins, breakthrough materials, weapon evolution progress.

This keeps "explore a living world" as a **future idea**, not a Phase 1 dependency — stages give the same sense of escalating challenge without needing server-wide state, migration logic, or world events to already exist.

---

## 4. Weapon Growth (Evolution, Not Replacement)

Unchanged in spirit from the original design — players bond with **one primary weapon** that evolves with them.

```
Rusty Sword
    → Spirit Sword     (realm advance + stage clears)
    → Dragon Slayer     (boss essence, later phases)
    → Heavenly Blade     (ascension material, later phases)
```

Evolution inputs: stage-boss kills, realm advancement, cultivation path alignment. Visual prestige (glow, trail) on each evolution — no inventory swapping needed.

---

## 5. Random Cultivation Talents

Kept from the original design, reframed slightly to touch the new Body/Spirit split:

| Talent | Effect |
|--------|--------|
| Fire Affinity | +10% Magic damage, -5% Qi from meditation |
| Fast Meditation | +25% Qi from meditation, -10% Qi from combat |
| Unstable Core | +15% combat Qi, +10% breakthrough fail chance |
| Iron Body | +10% max health, -5% move speed |
| Swift Feet | +10% move speed, -5% max health |
| Lucky Star | +10% combat Qi, no tradeoff |

Every talent has a tradeoff or niche — no pure "S-tier" rolls. Rolled 3-at-a-time on first join.

---

## Player Identity Summary

After a session or two, a player's identity is the combination of:

- Cultivation realm (overall power tier)
- Body/Spirit balance (Strength vs. Qi investment)
- Talents rolled
- Weapon evolution stage
- Stages cleared / current stage
- Mastery profile (which techniques they practiced most)

**Target:** Two players who've played a few hours can compare "how far did you get" and "are you a body or spirit cultivator" and immediately have something to talk about.

---

## Suggested Development Phases

Build vertically — one polished slice before expanding.

### Phase 0 — Foundation (Complete)

- [x] Rojo project structure
- [x] ProfileStore player data
- [x] Service / controller bootstrap
- [x] `ProfileData` schema for cultivation fields

### Phase 1 — Vertical Slice (MVP) — In Progress

**Goal:** Train, cultivate, breakthrough, evolve a weapon, and clear a handful of stages against both enemy types, in one session.

- 1 realm ladder: Mortal → Body Tempering → Spirit Gathering (enough to unlock both damage types)
- Dual stat growth: Qi (cultivation) + Strength (training)
- Physical vs. Magic damage split; Beast vs. Demon enemy types
- 3–5 sequential stages, each with a stage boss
- Weapon evolution: Rusty Sword → Spirit Sword
- Talent roll on first join (3 talents)
- Basic HUD (realm, Qi, Strength, current stage, weapon)

See [phase-1.md](./game-phase/phase-1.md) for the detailed milestone breakdown.

### Phase 2 — More Stages, More Depth

- More stages (10+), harder Mixed-type stages requiring both damage types
- Technique variety per damage type (2–3 Physical, 2–3 Magic techniques)
- Light technique fusion (a handful of recipes)
- Weapon evolution branches

### Phase 3 — Revisit Scope (Decide Later)

Only after Phase 1 and 2 prove the core loop is fun: decide whether to grow toward the original living-world vision (see below) or stay focused on deeper stage content. Don't commit engineering effort to world systems until the core loop is validated.

---

## Future Ideas (Backlog)

Everything below was part of the original, larger vision. **Not cut — deliberately deferred.** None of it blocks Phase 1 or 2, and none of it should be built until the core stage-clear loop is proven fun. Revisit if/when Phase 3 planning starts.

<details>
<summary>Dynamic, adaptive world bosses</summary>

Server-wide boss events that migrate between regions, adapt to dominant player strategies (see original "Boss Learning"), and change the world state (weather, terrain damage, minion waves).
</details>

<details>
<summary>Living World & World Evolution</summary>

Rotating world events (caravans, meteorites, ruins), a world that "remembers" server milestones (corrupted forests, unlocked ruins), soft/hard persistence model.
</details>

<details>
<summary>Reputation & Factions</summary>

Holy Sect / Demon Cult / Mercenary Guild etc., reputation states (Hero/Villain/Exile), faction wars with territory control.
</details>

<details>
<summary>Ascension Branches</summary>

God / Demon / Dragon / Machine — major identity choices at endgame with unique kits, unlocked story, visual transformation.
</details>

<details>
<summary>Technique Fusion (Full)</summary>

Combine techniques into new ones (Fireball + Wind Slash → Flaming Tornado), recipe-based and lab-based discovery, fusion slots gated by realm.
</details>

<details>
<summary>Mentor System</summary>

High-realm players guide newcomers for shared bonuses, cosmetics, and prestige; anti-boosting safeguards.
</details>

<details>
<summary>Sects (Player-Run Organizations)</summary>

Guild system with shared halls, contribution shops, sect vs. sect territory, sect-wide breakthrough rituals.
</details>

<details>
<summary>Reincarnation</summary>

Endgame prestige loop: reset realm, keep partial talents/cosmetics, gain permanent "Dao fragment" bonuses.
</details>

<details>
<summary>Duel Philosophy (Structured PvP)</summary>

Opt-in ranked duels with realm suppression and technique bans; cosmetic-only spectator betting.
</details>

<details>
<summary>Legend Codex, Spirit Root Quality, Alchemy & Crafting, Anti-Grind guardrails, Mobile-first combat UX</summary>

Supporting systems from the original design — all still good ideas, all deferred until the core loop is proven.
</details>

---

## Technical Notes (Roblox / Acend Codebase)

Align systems with the existing architecture — unchanged from before:

| System | Location |
|--------|----------|
| Player profile schema | `src/shared/Types.luau` + `PlayerDataService` |
| Balancing tables | `src/shared/Config/` (realms, talents, techniques, stages, enemies) |
| Server logic | `src/server/Services/` (CultivationService, CombatService, StageService) |
| Client UI & combat | `src/client/Controllers/` |
| Networking | `src/shared/Net/Remotes.luau` |

### Key Data to Persist (Player)

- Realm, Qi, Strength, talents
- Technique mastery counts
- Weapon evolution stage
- Highest stage cleared
- Coins / materials

---

## Open Design Questions

Decide these during Phase 1 implementation:

1. **Breakthrough requirement** — hard threshold in *both* Qi and Strength, or a combined "Power" score? (Current lean: both, to reinforce the dual-stat identity.)
2. **How many stages for the Phase 1 slice?** (Current lean: 3–5, enough to show Beast/Demon/Mixed variety.)
3. **Do Beasts/Demons ever mix within one stage**, or only at "Mixed" stages? (Current lean: pure stages first, Mixed stages later as the harder variant.)
4. **Pay model** — cosmetics only vs. convenience (avoid pay-to-clear-stages).
5. **Server size** — small (solo/co-op stage clearing) vs. larger shared-world server. Given the stage-clear focus, small/solo-friendly is the current lean.

---

## One-Line Pitch

**Acend:** Train your body, cultivate your spirit, and clear your way up — because no single power gets you through everything.

---

*Document version: 2.0 — July 2026 (revised: cultivation stage-clearer scope, Physical/Magic duality, deferred living-world systems)*
