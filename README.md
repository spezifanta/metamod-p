# Stripper2 Plugin for Metamod-P

> [!NOTE]
> This is a fork of [metamod-p](https://github.com/Bots-United/metamod-p) specifically for building the [Stripper 2 plugin](http://hpb-bot.bots-united.com/stripper2.html). There are no patches for metamod itself.

<img width="68" height="172" alt="Botman" src="https://github.com/user-attachments/assets/8ca41c6b-553e-44e5-a436-02c18abb1349" />

A Metamod plugin that allows you to strip (remove) or add entities from Half-Life, Counter-Strike or any other GoldSrc maps without modifying the original BSP map files.

## Features

- **Strip entities**: Remove specific entities from maps by classname, with optional origin filtering
- **Add entities**: Add new entities to maps with full keyvalue support
- **Precache support**: Precache models, sounds, and sprites for added entities
- **Percentage-based filtering**: Control probability of stripping/adding entities
- **Group spawning**: Create randomized entity groups with weighted selection

## Installation

1. Compile the plugin using `make opt` for optimized build
2. Copy `stripper2.dll` (Windows) or `stripper2.so` (Linux) to your `addons/metamod/dlls/` directory
3. Add `linux stripper2.so` or `win32 stripper2.dll` to your `addons/metamod/plugins.ini`

## Configuration

Stripper2 uses two types of configuration files:

### Generic Configuration: `stripper2.cfg`
Place this file in your mod directory (e.g., `valve/stripper2.cfg`). Contains only strip commands:

```
// Strip all MP5 entities
weapon_mp5

// Strip 50% of 9mm ammo entities  
ammo_9mmclip 50.0

// Strip specific entity at exact location
weapon_crossbow (1024.0 512.0 256.0)
```

### Map-Specific Configuration: `maps/[mapname]_str.cfg`
Advanced configuration with strip, add, and precache sections:

```
[strip]
weapon_mp5
ammo_9mmclip 50.0
weapon_crossbow (1024.0 512.0 256.0)

[add]
// Single entity
{
classname/weapon_shotgun
origin/100 200 50
angles/0 90 0
}

// Group with weighted selection
{
  {
  classname/weapon_mp5
  origin/300 400 100
  } 30.0
  {
  classname/weapon_shotgun
  origin/300 400 100
  } 70.0
} 80.0

PRECACHE_MODEL(models/w_mp5.mdl)
PRECACHE_SOUND(weapons/hks1.wav)
```

## Console Variables

- `stripper2_log <0|1>` - Enable/disable debug logging (default: 0)

## Syntax Reference

### Strip Section
```
classname [percentage] [(x y z)]
```
- `classname`: Entity classname to remove
- `percentage`: Probability of removal (0-100, default: 100)
- `(x y z)`: Optional exact origin coordinates (tolerance: ±2 units)

### Add Section
Entities are defined in curly braces with `key/value` pairs:
```
{
classname/entity_name
key1/value1
key2/value2
bbox_min/-16 -16 -36
bbox_max/16 16 36
}
```

Groups allow random selection from multiple entities:
```
{
  { entity1 } weight1
  { entity2 } weight2
} group_spawn_percentage
```

### Precache Commands
```
PRECACHE_MODEL(path/to/model.mdl)
PRECACHE_SOUND(path/to/sound.wav)
PRECACHE_SPRITE(path/to/sprite.spr)
```

## Examples

### Remove most player spawn points to create tighter matches
```
[strip]
info_player_deathmatch 80.0
```

### Add weapon spawns with ammo
```
[add]
{
classname/weapon_mp5
origin/1024 512 256
angles/0 90 0
}
{
classname/ammo_9mmclip
origin/1024 600 256
}

PRECACHE_MODEL(models/w_mp5.mdl)
```

### Random weapon selection for deathmatch
```
[add]
{
  {
  classname/weapon_mp5
  origin/500 300 100
  } 40.0
  {
  classname/weapon_shotgun  
  origin/500 300 100
  } 40.0
  {
  classname/weapon_crossbow
  origin/500 300 100
  } 20.0
}
```

## Technical Notes

- Configuration files are processed when `worldspawn` entity is created
- Added entities spawn during `ServerActivate`
- Entity origins use standard Source coordinates
- Angle format: `pitch yaw roll` (typically `0 yaw 0`)
- Bounding boxes can be set with `bbox_min`/`bbox_max` keyvalues

## Troubleshooting

- Enable `stripper2_log 1` for detailed debug output
- Check console for "[STRIPPER2]" messages
- Verify configuration file paths and syntax
- Unknown keyvalues generate warnings but don't break functionality

## Building

Requirements:
- GCC/MinGW compiler
- Half-Life SDK
- Metamod-P headers

Build commands:
```bash
make opt          # Optimized build
make              # Debug build  
make linux_opt    # Linux optimized
make win32_opt    # Windows optimized
```

## Version

Current version: 1.0.2 (2025-07-13)

Based on botman's original Stripper2 plugin. Patched by Alex Kuhrt to make it run on the latest Metamod-P release.

The [original source](http://hpb-bot.bots-united.com/releases/stripper2_plugin_src_1_0.zip) was downloaded from botmans's homepage.
