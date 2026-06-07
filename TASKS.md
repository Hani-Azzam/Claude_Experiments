# Tel Aviv & Jaffa RPG — Task Tracker

_Updated as milestones are built and tested._

---

## Status Legend
- `[ ]` Not started
- `[~]` In progress
- `[x]` Done
- `[!]` Blocked / needs decision

---

## Milestone 1 — World & Movement (`tlv-rpg-v1.html`)

- [ ] 640×480 landscape canvas setup with mobile viewport
- [ ] Tilemap: 2D array, tile types (grass, sand, pavement, road, wall)
- [ ] Tile renderer using `fillRect`
- [ ] Player sprite (16×16, top-down ¾ view, rect-based)
- [ ] 4-direction movement (WASD + arrow keys)
- [ ] Collision detection against wall/building tiles
- [ ] Camera follows player (world larger than viewport)
- [ ] Touch D-pad (bottom-left)
- [ ] Building footprints placed on map: Shuk HaCarmel, Beach, Old Jaffa Port, Dizengoff Square, café
- [ ] Zone detection + location name HUD

---

## Milestone 2 — NPCs & Dialogue (`tlv-rpg-v2.html`)

- [ ] 4–6 NPCs with positions on map
- [ ] NPC faces player when nearby
- [ ] Space / tap to trigger dialogue when adjacent
- [ ] Canvas-drawn dialogue box (speaker name + text lines)
- [ ] Dismiss dialogue on Space / tap
- [ ] Unique flavor dialogue per NPC

---

## Milestone 3 — Art Pass (`tlv-rpg-v3.html`)

- [ ] Present 3 visual style options to user → await approval
- [ ] Apply agreed color palette to all tiles
- [ ] Player walk animation (2-frame cycle)
- [ ] Distinct NPC sprites per character type
- [ ] Bauhaus buildings, Jaffa stone walls, palm trees, beach sand
- [ ] Day sky gradient background
- [ ] Door tiles on buildings

---

## Milestone 4 — Interiors & Inventory (`tlv-rpg-v4.html`)

- [ ] Door tile triggers room transition (fade effect)
- [ ] Café interior room
- [ ] Jaffa clock tower interior room
- [ ] Collectable item on map (e.g. sea glass)
- [ ] Inventory HUD strip (max 4 items)
- [ ] NPC dialogue reacts to held item

---

## Milestone 5 — Time & Mood (`tlv-rpg-v5.html`)

- [ ] In-game clock (1 real sec = 1 game min)
- [ ] Sky gradient shifts across day/night cycle
- [ ] Night overlay tint
- [ ] NPCs shift position/dialogue by time of day
- [ ] HUD: current time + day counter
- [ ] Optional Tone.js ambient audio + mute toggle

---

## Decisions Log

| # | Question | Answer |
|---|---|---|
| 1 | Player character | Anonymous traveler |
| 2 | Dialogue language | English only (for now) |
| 3 | Visual style | TBD — present options at Milestone 3 |

---

## Post-Milestone Backlog (future features)

- Branching dialogue
- Quests (fetch/talk chains)
- More districts (Florentin, Neve Tzedek, Rothschild)
- Shareable save via URL hash
- Sound effects (footsteps, door chime, seagulls)
- Street events (musician on Friday, busy beach on weekends)
- Custom sprites / buildings from user-supplied assets
