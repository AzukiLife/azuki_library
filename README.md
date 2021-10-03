# 🔧 Neo Lib 

This library is a pretty and clean way to load lua files for GMod server (also support client).
So you don't have to put "include" and "AddCSLuaFile" everywhere!

Server view :

![Server View](https://i.imgur.com/Zsd1wKz.png)

Client view :

![Client View](https://i.imgur.com/CbORL6a.png)


## Features

Little list of features (more to come)
- Optimized code
- Preload certain files (eg. config files)
- Load addon with beautiful message for both client and shared
- Make you addon folder look more professionnal
- Every file is properly loaded
- No display for client if there is no shared/client file

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
        You can load anything from client to server, file will load properly
    ]] 
    local preload = {
        -- {folder, file}
        {"name/sh/", "config.lua"} -- Also accept "/sh/" for folder name but not "sh" or "sh/"
    }

    NeoLib.Initialize(addon_name, addon_version, preload)
    -- If no preload, you can get rid of the last argument or set it as nil
else
    print("Failed loading "..addon_name.." (Missing NeoLib)")    
end
```
- After that, move everything in `youraddonname/`
    - Also, create `youraddonname/sv/`, `youraddonname/sh/`, `youraddonname/cl/` (If you need all of them)
- Place server scripts in `youraddonname/sv/` and so on for others (client, shared)
- Finally, you should have something like this : 

![Example](https://i.imgur.com/otc58l8.gif)

## Keep in mind

This addon is mainly for my personnal server. If you only need loader option only keep this `lib/sh/loader_util.lua`, you can get rid of anything else.
Also edit `autorun/loader.lua` and remove every include you don't need !

## TODO

- [x] Do not include clients file in server but count them anyway
- [ ] Load folders of your choice (like `modules`) with a specified destination (server, client or shared)
- [ ] New function to preload a file (see main)

