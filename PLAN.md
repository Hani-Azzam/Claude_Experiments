# Tel Aviv & Jaffa RPG — Prototype Plan

## Vision

A relaxed, exploratory 8-bit RPG set in Tel Aviv and Jaffa. The player walks through a small, handcrafted slice of the city, talks to locals, and soaks in the atmosphere. Inspired by the freedom of Stick RPG and the warmth of Stardew Valley. No combat — just people, places, and vibes.

**Tone:** Slow, warm, curious. Like arriving at Ben Gurion for the first time and wandering off-script.

---

## Milestones

Each milestone produces a testable, self-contained HTML file: `tlv-rpg-v[N].html`

---

### Milestone 1 — World & Movement (`tlv-rpg-v1.html`)

**Goal:** A scrolling map you can walk around. Nothing else.

- 640×480 landscape canvas
- Tilemap: grass, sand, pavement, road — drawn with `fillRect` using a flat 2D array
- Player character: simple 8-bit sprite (16×16 rect-based, top-down ¾ view)
- 4-direction WASD + arrow key movement with collision against walls/buildings
- Camera follows player, world larger than viewport (e.g. 64×48 tiles at 16px = 1024×768 world)
- Touch D-pad in bottom-left corner
- A handful of building footprints (colored blocks with labels): Shuk HaCarmel, Beach, Old Jaffa Port, Dizengoff Square, a café
- Basic HUD: location name appears when player enters a named zone

**Test:** Can walk the full map, bump into buildings, camera scrolls, touch works.

---

### Milestone 2 — NPCs & Dialogue (`tlv-rpg-v2.html`)

**Goal:** Talk to people.

- 4–6 named NPCs standing around the map (fisherman at Jaffa port, market vendor at Shuk, tourist on beach, etc.)
- NPCs face the player direction when nearby
- Press Space (or tap) when adjacent → opens dialogue box drawn on canvas
- Dialogue box: speaker name + 2–3 lines of text, canvas-drawn border
- Each NPC has 1 unique line of dialogue (in character, light humor)
- Press Space again to dismiss
- No branching yet — just flavor text

**Test:** Find each NPC, trigger all dialogues, dismiss cleanly.

---

### Milestone 3 — Art Pass & World Detail (`tlv-rpg-v3.html`)

**Goal:** The world feels like Tel Aviv/Jaffa, not a placeholder.

- Agree on visual style with user before building (present 2–3 options)
- Proper tile variety: white Bauhaus buildings, Jaffa stone walls, palm trees, beach sand, Mediterranean blue
- Player sprite with walk animation (2-frame cycle using rects/arcs — no image files)
- NPC sprites distinct per character type
- Ambient color palette applied consistently
- Building interiors hinted at (door tile on buildings, no interior yet)
- Day sky gradient as background

**Test:** Screenshot the whole map — does it feel like the city?

---

### Milestone 4 — Interiors & Inventory (`tlv-rpg-v4.html`)

**Goal:** Enter buildings; pick up one item.

- Step on a door tile → fade transition → simple interior room (same canvas)
- At least 2 interiors: a café (order coffee?) and the old clock tower in Jaffa
- One collectable item on the map (e.g. a falafel wrapper, a sea glass)
- Inventory: small icon strip in HUD, max 4 items
- Item description on hover/focus
- NPCs can react to held items ("Oh, you found the sea glass!")

**Test:** Enter/exit both interiors, collect item, verify NPC reacts.

---

### Milestone 5 — Time, Mood & Ambient Loop (`tlv-rpg-v5.html`)

**Goal:** The world breathes.

- In-game clock: 1 real second = 1 game minute; day/night cycle affects sky gradient
- NPCs shift position/dialogue based on time (vendor leaves at sunset, fisherman arrives at dawn)
- Optional ambient audio via Tone.js: gentle synth drone, toggleable mute button
- HUD shows current time + day
- Subtle screen overlay tint for night (dark blue wash)

**Test:** Let the clock run through a full day cycle; watch NPCs move.

---

## Post-Milestone Feature Space

Once all milestones are solid, these are natural next additions (not planned yet — add when the user asks):

- **Branching dialogue** — choices that change NPC responses over time
- **Quests** — simple fetch/talk chains ("bring coffee to the fisherman")
- **More districts** — Florentin, Neve Tzedek, Rothschild Boulevard
- **Saving** — export/import state via a shareable URL hash
- **Sound effects** — footsteps, door chime, seagulls
- **More NPCs** — a rotating cast that changes with the day
- **Mini-events** — street musician appears on Friday afternoon, beach crowded on weekends

---

## Technical Notes

- **Single HTML file per version** — all JS, CSS, tile data, and NPC data inline
- Tilemap stored as a 2D array of tile-type integers, rendered with `fillRect`
- NPC and zone data as plain JS object arrays at the top of the script
- Camera: `ctx.translate(-camX, -camY)` before drawing world, reset after for HUD
- Dialogue and transitions drawn on top in screen-space (after camera reset)
- All magic numbers as named `const` — tile size, world size, walk speed, etc.

---

## Open Questions (resolve before Milestone 3)

1. **Visual style** — present 3 options at the start of M3 for user approval
2. **Language** — dialogue in English only, or Hebrew/Arabic words sprinkled in?
3. **Player character** — anonymous avatar, or a named character with a backstory?
