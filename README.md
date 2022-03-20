# 🔧 Azuki Library

This library is a pretty and clean way to load lua files for GMod server (also support client).
So you don't have to put "include" and "AddCSLuaFile" everywhere!

Server view :

![alib-dedicated](https://user-images.githubusercontent.com/52861120/159180117-416672bd-ac09-4850-8d86-7da26ee3c600.png)

Client view :

![alib-ingame](https://user-images.githubusercontent.com/52861120/159180115-8f62085c-d819-4e5c-bb94-9f5e9ead5792.png)

## ✅ Features

- Clean loading sequence
- Preload certain files (eg config files)
- Load addon with beautiful message for both client and server
- Make you addon folder look more professionnal
- Every file is properly loaded

## 🗒️ Use this lib

- First, place the loader code into `autorun/` name it as you like
  - Like so `autorun/addon_loader.lua`
  - Content is [here](https://github.com/AzukiLife/azuki_lib/blob/master/addon_loader.lua) (You should edit the default fields to match your addon)
- Create `addon_name/sv/`, `addon_name/sh/` and `addon_name/cl/` (you can rid of any of them if needed!)
- Finally, you should have something like this :

![Example](https://i.imgur.com/otc58l8.gif)

### Notes

Every file should have a different name. You should prefix all the file with a smaller version of the addon's name. Example : `AzukiCore -> aco_config.lua`

## 📦 Modules (work in progress)

Modules works exaclty the same as your addon is working. Its like a sub-addon you don't want to separate from your main addon.
You can imagine something like DLCs (additionnal content for your addon) that a player can install, all yours modules are base on the main addon, but the main addon can work without them.

You can easily create a module:

- Add `module/module_name` directory (You can add as many as you want)
- Create `module/module_name/sv/`, `module/module_name/sh/` and `module/module_name/cl/` (you can rid of any of them if needed!)
- ⚠️ **WARNING** do not put your module in `addon/module_name/...`! Or your files will not be loaded
- The core functionning is not determined yet

## TODO

- [ ] Modules manager system
- [ ] Detect presence of misplaced files
- [ ] Callback for a specific file loaded / and or a hook call
- [ ] Entity loader
- [ ] Make so files in addons managed by the loader can have the same name (from different addon) -> [Wiki](https://wiki.facepunch.com/gmod/Global.include)
