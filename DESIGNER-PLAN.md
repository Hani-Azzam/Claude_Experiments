# TLV RPG — Game Designer Tool Plan

_This document is the source of truth for building the designer tool.
Hand it to a new Claude session as the primary brief._

---

## What is this?

A standalone `tlv-designer.html` file — single HTML, no install, no npm.
Opens in a desktop browser. Lets non-coders on the team visually edit the
game world and export ready-to-paste JS data blocks.

The tool edits **data only** — it does not modify the game HTML file itself.
It generates JS constant blocks that a developer pastes into the game.

---

## Repository

`hani-azzam/claude_experiments` — branch `main`

The current production game is `tlv-rpg-v5.html`.
All game constants the tool must be compatible with are documented in this file.

---

## Game World Reference

### Canvas / World Size
- World: **80 columns × 60 rows** of tiles
- Tile size: **16px** (world units)
- Total world: 1280 × 960 px

### Tile Type IDs
```
T_GRASS  = 0   (olive green, walkable)
T_ROAD   = 1   (dark grey, walkable)
T_PAV    = 2   (cream pavement, walkable)
T_SAND   = 3   (warm sand, walkable)
T_WATER  = 4   (blue, SOLID — blocks movement)
T_BLDG   = 5   (building interior, SOLID)
T_WALL   = 6   (border wall, SOLID)
T_BRIDGE = 7   (wooden bridge over water, walkable)
T_DOOR   = 8   (golden door tile, triggers room entry)
```

### Base Map Layout (hardcoded, not editable by tool)
The base map is procedurally generated. These are fixed:
- Row 0 and row 59: T_WALL border
- Rows 21–23: T_SAND (beach, north of water)
- Rows 24–31: T_WATER (sea strip crossing the middle)
- Rows 32–33: T_SAND (beach, south of water)
- Rows 34–59: T_PAV (Jaffa district paving)
- Rows 1–20: T_GRASS (Tel Aviv north)
- Horizontal roads: rows 2, 20, 35 (span full width)
- Vertical roads: cols 1, 21, 43, 65 (span full height, skip water/sand)
- Bridges at water crossing: cols [1,2], [21,22], [43,44], [64,65] (rows 21–33)

The tool does NOT let users repaint these base tiles. It only lets users
place entities ON TOP of the base map.

---

## Data Structures the Tool Edits

These are the JS constants in the game that the tool generates on export.

### 1. BUILDINGS
```js
const BUILDINGS = [
  {
    x: 5,           // tile column (top-left corner)
    y: 4,           // tile row (top-left corner)
    w: 5,           // width in tiles
    h: 7,           // height in tiles
    label: 'Apt. Block',   // display name
    type: 'bauhaus',       // art style: 'bauhaus'|'cafe'|'market'|'arch'|'stone'
    door: {dc:2, dr:6},    // door offset from building top-left (always present)
    interior: 'cafe',      // optional: key into INTERIORS (omit if no interior)
  },
  // ...
];
```

Building types and their visual style:
- `bauhaus` — cream walls, terracotta roofline, navy windows
- `cafe` — cream walls, orange awning, gold sun logo
- `market` — terracotta walls, striped awning, gold border
- `arch` — sandy stone, dark archway opening
- `stone` — rough stone texture, small windows

### 2. INTERIORS
```js
const INTERIORS = {
  cafe: {                       // key matches building.interior
    name: 'Cafe Yasmin',        // display name shown as room banner
    roomW: 14,                  // room width in tiles
    roomH: 10,                  // room height in tiles
    bgColor: '#d4a860',         // floor color A (checkerboard)
    floorColor: '#c89050',      // floor color B (checkerboard)
    wallColor: '#e8c880',       // border wall color
    furniture: [
      {type:'counter', x:1, y:1, w:12, h:2, color:'#8b5a2a'},
      {type:'table',   x:2, y:5, w:3,  h:2, color:'#a07040'},
      // type: 'counter'|'table'|'stall'
    ],
    items: [
      {x:5, y:3, id:'coffee', label:'Cup of Coffee', color:'#4a2800',
       desc:'Strong and dark. Very Tel Aviv.'}
    ],
    npcs: [
      {tx:1, ty:3, name:'Barista',
       lines:["What can I get you?","The bourekas are fresh this morning."]}
    ],
    exitTile: {x:7, y:9},  // where player appears when leaving — must be open floor
  },
  // ...
};
```

### 3. OUTDOOR_NPCS (with time schedule)
```js
const OUTDOOR_NPCS = [
  {
    name: 'Moshe',
    schedule: [
      {start:6,  end:12, tx:10, ty:12, lines:["Morning line 1","Morning line 2","Morning line 3"]},
      {start:12, end:18, tx:10, ty:8,  lines:["Afternoon line 1","...","..."]},
      {start:18, end:22, tx:14, ty:22, lines:["Evening line 1","...","..."]},
      // NPCs are absent outside their schedule windows (night)
      // start/end = game hours (0–23)
    ],
  },
  // ...
];
```

### 4. ZONES
```js
const ZONES = [
  {name:'Dizengoff Square', x1:4,  y1:2,  x2:20, y2:19},
  // x1/y1 = top-left tile, x2/y2 = bottom-right tile (inclusive)
  // When player enters a zone for the first time, a banner shows the name
];
```

### 5. WORLD_ITEMS (outdoor collectables)
```js
const WORLD_ITEMS = [
  {tx:30, ty:23, id:'shell', label:'Sea Shell', color:'#f0c8a0',
   desc:'A small spiral shell from the Mediterranean shore.'},
  // tx/ty = tile position, id = unique string, color = dot color
];
```

### 6. PALMS and LAMPS (decorative props)
```js
const PALMS = [{x:3,y:5}, {x:20,y:5}, ...];  // tile positions
const LAMPS = [{x:7,y:3}, {x:7,y:18}, ...];  // tile positions
```

---

## Tool — Phase 1 Spec (Build This First)

### UI Layout

```
┌─────────────────────────────────────────────────────────┐
│  TLV Game Designer          [💾 Save] [📂 Load] [Export] │
├──────────┬──────────────────────────────────────────────┤
│          │                                              │
│  PANEL   │              MAP CANVAS                      │
│          │           (80×60 tiles, ~960px wide)         │
│  Tabs:   │                                              │
│  [Map]   │  Click to place/select entity                │
│  [Build] │  Hover shows tile coords                     │
│  [NPCs]  │  Right-click to delete                       │
│  [Items] │                                              │
│  [Zones] │                                              │
│  [Props] │                                              │
│          │                                              │
│  ──────  │                                              │
│  Edit    │                                              │
│  form    │                                              │
│  for     │                                              │
│  selected│                                              │
│  entity  │                                              │
└──────────┴──────────────────────────────────────────────┘
```

### Left Panel Tabs

**Map tab** (read-only base map info)
- Shows a legend of tile colors
- Shows current cursor tile coordinates

**Buildings tab**
- "Add Building" button → click on map to place (drag to set size)
- Select a building on map → edit form appears:
  - Label (text input)
  - Type (dropdown: bauhaus / cafe / market / arch / stone)
  - Width / Height (number inputs, min 3×4)
  - Has interior? (checkbox) → if yes, show interior editor:
    - Room width/height
    - Floor colors (color pickers)
    - Furniture list (add/remove rows: type, x, y, w, h, color)
    - Items list (add/remove: x, y, id, label, color, desc)
    - Interior NPCs list (add/remove: x, y, name, 3 dialogue lines)
    - Exit tile position
  - Delete button

**NPCs tab**
- List of all outdoor NPCs
- "Add NPC" button
- Click NPC on map OR in list to select → edit form:
  - Name
  - Schedule slots (add up to 4 time windows):
    - Start hour / End hour
    - Tile position (x, y) — click on map to pick
    - 3 dialogue lines (text inputs)
  - Delete button

**Items tab**
- List of outdoor collectables
- "Add Item" → click map to place
- Edit form: id, label, color, description
- Delete button

**Zones tab**
- List of zones
- "Add Zone" → drag rectangle on map
- Edit form: name
- Zones shown as colored semi-transparent overlays on map
- Delete button

**Props tab**
- Two lists: Palms and Lamps
- Toggle paint mode: click tiles to add/remove props
- Clear all of each type button

### Map Canvas

- Render the base map using the same tile colors as the game
- Draw all placed entities on top (buildings as colored rects, NPCs as dots, items as circles, zones as transparent overlays)
- Scrollable (the map is 1280×960px, may not fit screen)
- Zoom: 50% / 100% / 150% buttons
- Cursor shows tile coordinates (col, row) in a small HUD
- Click behavior depends on active left-panel tab
- Selected entity highlighted with gold border

### Export Panel

When user clicks Export, show a modal with:
1. A generated JS code block containing all the constants:
   - `const BUILDINGS = [...];`
   - `const INTERIORS = {...};`
   - `const OUTDOOR_NPCS = [...];`
   - `const ZONES = [...];`
   - `const WORLD_ITEMS = [...];`
   - `const PALMS = [...];`
   - `const LAMPS = [...];`
2. A "Copy to Clipboard" button
3. Instructions: "Paste this block into tlv-rpg-v5.html replacing the matching constants"

### Save / Load

- Save: `JSON.stringify` all data → `localStorage['tlv_designer_save']`
- Load: parse from localStorage, repopulate tool state
- Also: "Export JSON" and "Import JSON" file buttons for sharing between machines
- On page load: auto-load from localStorage if a save exists

---

## Phase 2 Spec (future — do not build yet)

- **Branching dialogue**: Visual node editor. Nodes: `{id, text, choices:[{label, nextId, condition?}]}`. Conditions: `hasItem(id)`, `questComplete(id)`, `timeOfDay(start,end)`.
- **Quests**: `{id, name, steps:[{type:'talk'|'collect'|'deliver', target, item?}], reward}`. NPCs get a `quest` field referencing a quest id.
- **Mini-events**: `{id, tile:{x,y}, timeWindow:{start,end}, type:'musician'|'vendor'|'crowd', dialogue:[...]}`.
- **Shops**: Interior NPCs get a `shop` field: `{items:[{id, label, price, color}]}`.
- **Audio metadata**: Buildings and events get a `sound` field referencing a sound id string.

---

## Phase 3 Spec (future)

- More districts (extend the map beyond current 80×60)
- Menu/UI config (game title, start screen text, zone names)
- Shareable URL (base64-encode a stripped-down save and put in URL hash)

---

## Technical Requirements

- **Single HTML file** — all JS, CSS inline. No build step, no npm, no CDN.
- Desktop-first (the map needs space). Minimum viewport: 1200px wide.
- Vanilla JS only.
- Map canvas uses `<canvas>` 2D API.
- All state in a single plain JS object `D` (designer state).
- Auto-save to localStorage on every change.
- The tool does NOT need to run the game — it only generates data.
- Export output must be copy-paste compatible with `tlv-rpg-v5.html`.

---

## Color Palette (for the tool's own UI)

The tool UI should feel like a dark professional editor, not the game itself:
- Background: `#1a1a2e`
- Panel: `#16213e`
- Border: `#0f3460`
- Accent: `#e94560` (for selected states, buttons)
- Text: `#eee`
- Canvas border: `#f5d060` (the game's gold)
- Selected entity highlight: `rgba(245,208,96,0.5)`

---

## Files in this repo

| File | Description |
|------|-------------|
| `tlv-rpg-v1.html` | M1: World & movement |
| `tlv-rpg-v2.html` | M2: NPCs & dialogue |
| `tlv-rpg-v3.html` | M3: Art pass |
| `tlv-rpg-v4.html` | M4: Interiors & inventory |
| `tlv-rpg-v5.html` | M5: Time & day/night ← current game |
| `tlv-palette-experiment.html` | 3 alternative palette options (for review) |
| `PLAN.md` | 5-milestone game roadmap |
| `TASKS.md` | Task tracker |
| `DESIGNER-PLAN.md` | This file |

---

## Current Game State Summary

The game as of v5 has:
- 80×60 tile world, 6 named zones
- 9 buildings (4 with interiors: Cafe Yasmin, Shuk HaCarmel, Old Jaffa House, Port Cafe)
- 3 outdoor NPCs with time schedules (Moshe, David, Noa)
- 4 indoor NPCs (Barista, Shira, Ibrahim, Yael)
- 5 collectables (sea shell outdoor + coffee/halva/sea glass/postcard in rooms)
- Day/night cycle (1 real second = 1 game minute)
- Inventory HUD strip

---

_Last updated: 2026-06-08_
