# Acend — Game Design Document

**Genre:** Ascension RPG (cultivation / xianxia-inspired)  
**Platform:** Roblox  
**Working title:** Acend  
**Status:** Pre-production / design phase

---

## Vision

Acend is not a strength simulator. It is an **Ascension RPG** where players forge a personal legend through cultivation, choice, and mastery.

The core fantasy:

> *You are not just becoming stronger — you are ascending through realms, shaping your identity, and leaving a mark on a living world.*

Two players who have played for 100 hours should feel **distinct** from each other. Progression should unlock **new ways to play**, not only higher numbers.

### Design Pillars

| Pillar | Meaning |
|--------|---------|
| **Identity over stats** | Build diversity matters more than a single DPS leaderboard |
| **Events over increments** | Breakthroughs, ascensions, and world shifts should feel memorable |
| **Practice over menus** | Mastery through use; choices through playstyle |
| **World over lobby** | The server should feel alive, reactive, and shared |
| **Risk over safety** | Failure, faction consequences, and boss adaptation create stories |

### What We Are Not Building

- A linear “click train → number go up” simulator
- A game where every player converges on one optimal build
- A static world where bosses exist only as damage sponges

---

## Core Progression Loop

```
Train & meditate
      ↓
Learn techniques
      ↓
Choose a cultivation path
      ↓
Breakthrough (realm advancement)
      ↓
Explore new regions
      ↓
Find rare treasures & materials
      ↓
Upgrade / evolve your weapon
      ↓
Fight dynamic bosses
      ↓
Unlock new abilities & fusions
      ↓
Change the world (server evolution)
      ↓
Ascend to a higher existence
      ↓
(Reincarnate / mentor / new saga)
```

Every step in this loop should answer: **“What can I do now that I couldn’t before?”**

---

## 1. Cultivation Realm System (Not Levels)

Replace generic levels with **realms** — stages of spiritual ascension. Each breakthrough is a **ceremony**, not a stat tick.

### Example Realm Ladder

| Realm | Fantasy |
|-------|---------|
| Mortal | Ordinary beginning; no techniques |
| Body Tempering | Physical foundation; unlocks body path |
| Spirit Gathering | Qi manipulation; elemental affinity awakens |
| Core Formation | Stable inner core; fusion & summons unlock |
| Nascent Soul | Soul projection; advanced bosses & PvP tiers |
| Immortal | Server-wide events; world evolution access |
| Celestial | Endgame ascension branches |

### Breakthrough Events

Breakthroughs should never be “press button, +1 realm.” Examples:

- **Meditation trial** — timed focus minigame or calm-zone challenge
- **Inner demon** — personal boss fight using your own build against you
- **Heavenly lightning** — survive waves of environmental damage
- **Treasure consumption** — spend rare pills, herbs, or spirit stones

### Failure & Consequence

Failed breakthroughs create story, not frustration:

- Temporary **realm instability** (reduced stats or technique cooldown penalty)
- **Qi deviation** debuff requiring recovery quest or meditation
- Lost materials (partial cost), not full character wipe
- Cooldown before next attempt

**Design goal:** Players remember their first Nascent Soul breakthrough. They do not remember reaching “Level 47.”

---

## 2. Playstyle Skill Trees (Not Stat Trees)

Skill trees must **change how you play**, not just add `+10% damage`.

### Cultivation Paths

#### Path of the Sword
- Fast combos, counterattacks, dash cancels, critical finishers
- High mobility, lower base HP

#### Path of the Body
- High HP, regeneration, heavy strikes, taunt / tank tools
- Slower but survives world bosses and lightning tribulations

#### Path of the Elements
- Fire, Ice, Lightning, Wind — each with different control and area denial
- Elemental interactions (fire spreads on wind, ice shatters on heavy hits)

#### Path of Summoning
- Spirit beasts, clones, golems
- Positioning and command gameplay instead of direct melee

### Tree Rules

- Players can **lean** into one path but may dabble in others at higher cost
- Respec is possible but expensive and lore-justified (e.g., “severing your dao”)
- Key nodes unlock **mechanics**, not just multipliers:
  - Parry window
  - Double jump
  - Spirit link (share damage with summon)
  - Element infusions on basic attacks

---

## 3. Dynamic Bosses

Bosses are **world events**, not static farming targets.

### Example: The Crimson Dragon Awakens

- Server announcement: *“The Crimson Dragon has awakened.”*
- Players converge on a live location
- Boss behavior:
  - Destroys structures / terrain (temporary or phased)
  - Changes weather and lighting
  - Summons minions at HP thresholds
  - **Flies to another region** if ignored too long
  - Enrages if fought with only one strategy (see Boss Learning)

### Boss Tiers

| Tier | Scope | Example |
|------|-------|---------|
| Zone boss | 1–5 players | Corrupted spirit in a dungeon |
| Regional boss | 10–30 players | Bandit king assaulting a village |
| World boss | Full server | Crimson Dragon, Heavenly Beast |
| Tribulation entity | Personal / party | Inner demon, lightning spirit |

### Rewards

- Rare breakthrough materials
- Weapon evolution progress
- World-state triggers (see World Evolution)
- **Legend entries** (see Additional Ideas)

---

## 4. Weapon Growth (Evolution, Not Replacement)

Players bond with **one primary weapon** that grows with them.

### Evolution Chain Example

```
Rusty Sword
    → Spirit Sword        (100+ battles, basic mastery)
    → Dragon Slayer       (boss essence, fire path synergy)
    → Heavenly Blade      (ascension material, realm gate)
    → [Branch] Storm Sovereign / Void Reaver / etc.
```

### Evolution Inputs

- Battle count (mastery)
- Boss essences dropped from specific encounters
- Cultivation path alignment
- Player choices during ascension

### Why This Matters

- Emotional attachment to gear
- Visual prestige (glow, aura, trail effects)
- Fewer inventory headaches than constant weapon swapping
- Secondary weapons / tools can exist for variety without replacing identity

---

## 5. Random Cultivation Talents

Each new character rolls **innate talents** at creation (or first login). No two cultivators are identical.

### Example Talent Pool

| Talent | Effect |
|--------|--------|
| Fire Affinity | +20% fire damage |
| Weak Water Resistance | -15% water defense |
| Fast Meditation | +25% offline / passive training speed |
| Unstable Core | +10% breakthrough reward, +15% failure risk |
| Beast Whisperer | Summon path starts stronger |
| Sword Prodigy | Sword techniques level 2x faster |

### Talent Design Rules

- Every talent should have a **tradeoff** or niche — avoid pure “S-tier” rolls
- Reroll options exist but are rare (premium item, endgame quest, or reincarnation)
- Talents influence **AI recommendations** for path choice, not hard locks
- Display talents on player inspect / legend card for social identity

---

## 6. Living World

The world should generate **unexpected opportunities**, not just static NPCs.

### World Events (Rotating)

- Villages attacked by demon beasts
- Merchant caravans traveling between hubs (escort / raid choices)
- Meteorites crashing — temporary mining zones with rare ore
- Ancient ruins appearing for limited time
- Bosses migrating between regions

### Event Cadence (Suggested)

- **Micro events:** every 5–15 minutes (caravan, small invasion)
- **Major events:** every 30–60 minutes (ruins, regional boss)
- **Server saga events:** weekly or triggered by community milestones

### Player Agency

- Ignoring events has consequences (village destroyed → prices rise, quests change)
- Participating unlocks faction reputation and unique materials

---

## 7. Reputation & Factions

Actions define how the world treats you.

### Example Factions

- Holy Sect
- Demon Cult
- Mercenary Guild
- Wanderer’s Alliance
- Imperial Court

### Reputation States

| Standing | Effect |
|----------|--------|
| Hero | Discounts, exclusive righteous techniques |
| Villain | Black market access, feared by guards |
| Demon Cult Leader | Summon & corruption bonuses, hunted in holy zones |
| Exile | Neutral zones only until redeemed |

### Mechanics

- Quest choices shift reputation
- Some NPCs refuse service at extreme standings
- Faction wars can be **server-wide** with territory control
- Reputation visible on nameplate / legend card

---

## 8. Boss Learning (Adaptive AI)

Bosses **adapt to dominant player strategies** over a fight or across repeated encounters.

### Examples

| Player behavior | Boss adaptation |
|-----------------|-----------------|
| Everyone uses swords | Gains blade deflection / sword resistance |
| Everyone uses fire | Starts absorbing fire, heals from burns |
| Everyone kites | Gains gap closers and arena shrink |
| Same party comps | Targets healers or summoners first |

### Safeguards

- Adaptation is **readable** (visual cue: boss “absorbs flame,” UI telegraph)
- Caps on resistance so no strategy is fully invalidated
- Encourages party composition variety and technique fusion
- Resets on new spawn or weekly rotation so farming stays fresh

---

## 9. Technique Fusion

Reduce skill bloat. Let players **experiment** by combining techniques.

### Fusion Examples

| Input A | Input B | Output |
|---------|---------|--------|
| Fireball | Wind Slash | Flaming Tornado |
| Lightning | Sword art | Thunder Blade |
| Ice wall | Body slam | Avalanche Crash |
| Summon wolf | Fire aura | Ember Pack |

### Fusion Rules

- Discoveries can be **recipe-based** (hidden combos) or **lab-based** (spend materials to experiment)
- Failed fusions consume materials but may grant mastery XP
- Fusion slots limited by realm — higher realms = more complex combos
- Share fusion recipes through mentor system or guild codex

---

## 10. Ascension Choices

At major milestones, players choose **what they become** — not just “stronger.”

### Ascension Branches

| Path | Identity | Unlocks |
|------|----------|---------|
| God | Divine light, support & smite | Holy zones, blessing abilities |
| Demon | Corruption, lifesteal, fear | Demon realms, sacrifice mechanics |
| Dragon | Transformation, breath attacks | Flight segments, scale armor |
| Machine | Precision, shields, overclock | Crafting bonuses, energy cores |

### Branch Effects

- Unique ability kits (not just recolors)
- Different story quests and NPC reactions
- Visual transformation (aura, form shift, idle animation)
- Some branches gate certain fusions or weapon evolutions

**Rule:** Ascension is **meaningful and hard to reverse**. Players should deliberate, discuss, and theorycraft.

---

## 11. World Evolution (Server Memory)

The server **remembers** what the community accomplishes.

### Example Timeline

| Phase | World State |
|-------|-------------|
| Week 1 | Peaceful Forest — tutorial hubs, low-tier beasts |
| Week 3 | Corrupted Forest — demon influence after failed world boss |
| Week 8 | Ancient Kingdom Ruins appear — new dungeon layer unlocked |

### Triggers

- World boss defeated / failed
- Total realm breakthroughs across server
- Faction war outcomes
- Seasonal “tribulation” events

### Persistence Model

- **Soft persistence:** visual and spawn changes persist on server until reset
- **Hard persistence:** milestone flags stored in DataStore / server profile (ProfileStore-friendly)
- Seasonal resets with **legacy titles** for participants

---

## 12. Mentor System

High-realm players guide newcomers — retention for both cohorts.

### Mentor Benefits

| Role | Benefit |
|------|---------|
| Mentor | Exclusive cosmetics, mentor currency, legend prestige |
| Disciple | XP bonus near mentor, technique scrolls, breakthrough hints |

### Activities

- Teach techniques (temporary loan or unlock quest)
- Co-breakthrough support (inner demon party assist)
- Shared world event bonuses when fighting together
- Mentor hall / sect housing (social hub)

### Safeguards

- Anti-boosting: bonuses cap if power gap is too large
- Mentor reputation — bad mentors can be reported / delisted

---

## 13. Mastery Through Practice

Techniques improve by **use**, not only by spending points.

### Example: Punch Mastery

| Uses | Evolution |
|------|-----------|
| 0 | Punch |
| 5,000 | Heavy Punch |
| 20,000 | Shockwave Punch |
| 100,000 | Planet Breaker |

### Mastery Rules

- XP gain scales with **meaningful** use (hit confirms, not whiffing air AFK)
- Diminishing returns on repetitive macro targets — variety bonus for mixed combat
- Mastery visible on technique icon and legend card
- Some evolutions require **both** mastery and a breakthrough material

---

## Additional Ideas (Recommended)

These complement the core plan and strengthen differentiation on Roblox.

### 14. Legend Codex (Personal & Server History)

Every player has a **Legend Codex** — a readable journal of milestones:

- First breakthrough, ascension choice, weapon evolution
- World bosses participated in
- Faction betrayals and heroic deeds

**Why:** Gives players a story to tell and share on social media. Turns stats into narrative.

### 15. Spirit Root Quality (Growth Curve, Not Just Talents)

At character creation, roll **spirit root quality** (e.g., Mortal Root → Heavenly Root).

- Affects training speed and breakthrough difficulty
- Does not hard-cap power — a Mortal Root legend is more impressive socially
- Ties into reincarnation: “ascend with a flawed root” for permanent legacy bonus

### 16. Qi Economy & Training Modes

Different training methods consume different resources:

| Mode | Resource | Best for |
|------|----------|----------|
| Meditation | Time, calm zones | Safe passive growth |
| Combat training | Stamina, food | Active mastery |
| Tribulation training | Risk, materials | Burst progression |
| Sect chamber | Sect contribution | Social / guild play |

Prevents one-button optimal strategy and supports both active and casual players.

### 17. Alchemy & Crafting Loop

Support breakthroughs with a crafting layer:

- Herbs from biomes, ores from meteorites, essences from bosses
- Pill quality affects breakthrough success rate
- Bad pills cause Qi deviation — risk/reward crafting

Connects **Living World** events to **Realm System** directly.

### 18. Reincarnation (Long-Term Prestige)

At endgame, players may **reincarnate**:

- Reset realm to Mortal (or Body Tempering)
- Keep: talents (partial), legend codex, cosmetic ascensions, some fusion knowledge
- Gain: permanent “Dao fragment” bonuses, new talent slot, exclusive title

Fits cultivation lore and extends retention beyond linear cap.

### 19. Sects (Player-Run Organizations)

Guild system with cultivation flavor:

- Shared sect hall, contribution shop, sect techniques
- Sect vs sect territory during world events
- Sect tribulation — entire guild must cooperate for a breakthrough ritual

### 20. Duel Philosophy (Structured PvP)

Optional PvP with cultivation rules:

- **Realm suppression** in low-level zones (higher realm stats capped)
- Technique bans in ranked duels
- Spectator mode with betting (cosmetic currency only to avoid gambling issues)

### 21. Anti-Grind & Fair Play

Mastery and training systems need guardrails:

- Diminishing returns on same-target farming
- Daily variety bonus for trying new zones / bosses
- Server-side validation of training gains (no client-trusted stats)
- Report tools for exploit macros

Critical for Roblox where auto-clickers are common.

### 22. Mobile-First Combat UX

Large player base on mobile:

- Generous aim assist for skill shots
- Hold-to-charge vs tap patterns
- UI scales for technique fusion and codex on small screens

Design combat once with mobile parity, not as a PC afterthought.

---

## Player Identity Summary

After long-term play, a player’s identity is the combination of:

- Cultivation realm & path
- Elemental affinities & random talents
- Weapon evolution branch
- Technique fusions discovered
- Faction reputation & ascension choice
- Mastery profile (what they practiced most)
- Legend codex entries
- Mentor / sect affiliations

**Target:** Two 100-hour players can meet and immediately see they took different journeys.

---

## Differentiation vs. Typical Roblox Training Games

| Typical training game | Acend |
|----------------------|-------|
| Level 1 → 1000 | Mortal → Celestial with breakthrough events |
| +10% damage nodes | Path mechanics that change combat |
| Static boss in a box | Migrating, adaptive world bosses |
| New sword every hour | One weapon that evolves with you |
| Same build for everyone | Talents, paths, fusions, ascensions |
| Lobby with train button | Living world with server memory |
| Solo grind | Mentors, sects, world events |

---

## Suggested Development Phases

Build vertically — one polished slice before full scope.

### Phase 0 — Foundation (Current)

- [x] Rojo project structure
- [x] ProfileStore player data
- [x] Service / controller bootstrap
- [ ] Expand `ProfileData` schema for cultivation fields

### Phase 1 — Vertical Slice (MVP)

**Goal:** One complete loop that feels like Acend, not a generic sim.

- 2 realms: Mortal → Body Tempering
- 2 paths: Sword + Body (one technique each, mastery tracking)
- 1 zone boss + 1 simple breakthrough event
- Weapon evolution: Rusty Sword → Spirit Sword
- Basic HUD (realm, Qi, technique, coins/materials)
- Talent roll on first join (3 talents)

**Success metric:** A new player can train, breakthrough, evolve a weapon, and beat a boss in one session — and tell a friend what path they chose.

### Phase 2 — Identity & Depth

- Full 4 paths (add Elements + Summoning)
- Technique fusion (5–10 recipes)
- Faction reputation (2 factions)
- Random world micro-events (caravan, meteorite)

### Phase 3 — Social & World

- World boss with migration
- Boss learning (basic adaptation)
- World evolution flags (server memory)
- Mentor system

### Phase 4 — Endgame & Live Ops

- Ascension branches (God / Demon / Dragon / Machine)
- Reincarnation
- Sects
- Seasonal tribulations & saga events

---

## Technical Notes (Roblox / Acend Codebase)

Align systems with the existing architecture:

| System | Suggested location |
|--------|-------------------|
| Player profile schema | `src/shared/Types.luau` + `PlayerDataService` |
| Balancing tables | `src/shared/Config/` (realms, talents, fusion recipes) |
| Server logic | `src/server/Services/` (CultivationService, BossService, WorldEventService) |
| Client UI & combat | `src/client/Controllers/` |
| Networking | `src/shared/Net/Remotes.luau` |
| World state | Server DataStore or ProfileStore `ServerProfile` keyed by place/job |

### Key Data to Persist (Player)

- Realm, path, talents, spirit root
- Technique mastery counts & unlocked fusions
- Weapon evolution stage & battle count
- Faction reputation map
- Ascension branch (if chosen)
- Legend codex entries (compressed IDs + timestamps)

### Key Data to Persist (Server)

- World evolution phase
- Active / last world boss state
- Faction territory outcomes
- Weekly event flags

---

## Open Design Questions

Decide these before Phase 1 implementation:

1. **Breakthrough failure rate** — How punishing should early realms be?
2. **Pay model** — Cosmetics only vs. convenience (avoid pay-to-realm)
3. **Server size** — 20-player cozy vs. 50+ for world bosses
4. **PvP default** — Opt-in duels only, or faction open conflict zones?
5. **Reincarnation timing** — Available at Immortal, or earlier soft prestige?

---

## One-Line Pitch

**Acend:** Forge your own cultivation legend in a living world — where your path, talents, weapon, and choices matter as much as your power.

---

*Document version: 1.0 — July 2026*
