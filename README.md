# NeoLib 

This library is a pretty and clean way to load lua files for GMod server (also support client).
So you don't have to put "include" and "AddCSLuaFile" everywhere!

Server view :

![Server View](https://i.imgur.com/Zsd1wKz.png)

Client view :

![Client View](https://i.imgur.com/CbORL6a.png)

## Installation

- You have to create a loader file in `autorun/` folder
    - Like so `autorun/loader.lua`
- Loader content :
```lua
local addon_name = "name"
local addon_version = "ver"

if NeoLib then 
    --[[
        If your system need to load certain files first, add them like this in preload table.
        You can comment local preload... and also remove the third arguement of Initialize call
    ]] 
    local preload = {
        -- {folder, file}
        {"name/sh/", "config.lua"}
    }
    NeoLib.Initialize(addon_name, addon_version, preload)
else
    print("Failed loading "..addon_name.." (Missing NeoLib)")    
end
```
- After that, move everything in `youraddonname/`
    - Also, create `youraddonname/sv/`, `youraddonname/sh/`, `youraddonname/cl/` (If you need all of them)
- Place server scripts in `youraddonname/sv/` and so on for others (client, shared)
- For each client file, you have to add this line at the top: 
```lua
if SERVER then return end
```
- And in every server file you have to add: 
```lua
if CLIENT then return end
```
- Finally, you should have something like this : 

![Example](https://i.imgur.com/otc58l8.gif)

## Keep in mind

This addon is mainly for my personnal server. If you only need loader option only keep this `lib/sh/loader_util.lua`, you can get rid of anything else.
Also edit `autorun/loader.lua` and remove every include you don't need!

## Planned Features

- [ ] Load folders of your choice (like `modules`) with a specified destination (server, client or shared)
- [ ] Count how many addons were loaded
- [ ] Do not include clients file in server but count them anyway

