# 🔧 Neo Lib 

This library is a pretty and clean way to load lua files for GMod server (also support client).
So you don't have to put "include" and "AddCSLuaFile" everywhere!

Server view :

![Server View](https://i.imgur.com/Zsd1wKz.png)

Client view :

![Client View](https://i.imgur.com/CbORL6a.png)


## Features

- Clean loading sequense
- Preload certain files (eg config files)
- Load addon with beautiful message for both client and server
- Make you addon folder look more professionnal
- Every file is properly loaded
- Module system

## Use this lib

- First, place the loader code into `autorun/` name it as you like 
    - Like so `autorun/addon_loader.lua`
    - Content : 
```lua
local addon_name = "addon_name" -- eg ULX
local addon_version = "addon_version" -- eg 1.0

if NeoLib then 
    --[[
        If your system need to load certain files first, add them like this in preload table.
        You can load anything from client to server, file will load properly
    ]] 
    local preload = {
        -- {folder, file}
        {"name/sh/", "config.lua"} -- Also accept "/sh/" for folder name but not "sh" or "sh/"
    }
    --[[
        If your addon handle modules, you can include the path to the module
        Modules have to be located under (lua/) modules/<name>
        /!\ Module manager will load server, shared and client files in their respective directory (sv, sh, cl)
    ]]
    local module = {
        -- {name, version, description}
        { "name", "1.0", "Description" }, --example 1
        { "name_2", "dev-0.6", "Another Description"} -- example 2
    }
    NeoLib.Initialize(addon_name, addon_version, preload)
else
    print("[!] Cannot load "..addon_name.." (Missing Neo Lib)")    
end
```
- Create `addon_name/sv/`, `addon_name/sh/` and `addon_name/cl/` (you can rid of any of them if needed!)
- Finally, you should have something like this : 

![Example](https://i.imgur.com/otc58l8.gif)

## Modules (TODO)

Modules works exaclty the same as your addon is working. Its like a sub-addon you don't want to separate from your main addon.
You can imagine something like DLCs (additionnal content for your addon) that a player can install, all yours modules are base on the main addon, but the main addon can work without them.

You can easily create a module:
- Add `module/module_name` directory (You can add as many as you want)
- Create `module/module_name/sv/`, `module/module_name/sh/` and `module/module_name/cl/` (you can rid of any of them if needed!)
- ⚠️ **WARNING** do not put your module in `addon/module_name/...`! Or your files will not be loaded

## TODO

- [ ] Rework File Management System
- [ ] New function to preload a file (see main)


