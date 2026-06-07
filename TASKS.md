# Tel Aviv & Jaffa RPG — Task Tracker

_Updated as milestones are built and tested._

---

## Status Legend
- `[ ]` Not started
- `[~]` In progress
- `[x]` Done
- `[!]` Blocked / needs decision

---

## Milestone 1 — World & Movement (`tlv-rpg-v1.html`) ✅

- [x] 640×480 landscape canvas setup with mobile viewport
- [x] Tilemap: 2D array, tile types (grass, sand, pavement, road, wall, water, door)
- [x] Tile renderer using `fillRect` + sprite sheet overlay
- [x] Player sprite from Gemini sprite sheet (embedded base64)
- [x] 4-direction movement (WASD + arrow keys), diagonal movement normalized
- [x] Collision detection against wall/building/water tiles
- [x] Camera follows player (80×60 tile world, 1280×960px)
- [x] Touch D-pad (bottom-left)
- [x] 9 buildings placed: Shuk HaCarmel, Café Yasmin, Jaffa Arch, Port Café, apt blocks
- [x] 6 named zones: Dizengoff Square, Shuk, Rothschild, Beach, Old Jaffa, Jaffa Port
- [x] Zone detection + animated location name HUD
- [x] Mini-map (top-right) with player dot + viewport indicator
- [x] Palm trees and lamp posts as props

---

## Milestone 2 — NPCs & Dialogue (`tlv-rpg-v2.html`) ✅

- [x] 6 named NPCs placed across all districts (Moshe, Shira, David, Noa, Ibrahim, Yael)
- [x] NPC highlighted + [SPACE] prompt appears when player is in range
- [x] Space / TALK button triggers dialogue
- [x] Canvas-drawn dialogue box with speaker name tab + wrapped text
- [x] Each NPC has 3 lines that cycle on repeat visits
- [x] Movement blocked while dialogue open
- [x] NPC dots shown on mini-map
- [x] TALK button for mobile (bottom-right)

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
