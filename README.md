# 🔧 Azuki Lib

This library is a pretty and clean way to load lua files for GMod server (also support client).
So you don't have to put "include" and "AddCSLuaFile" everywhere!

Server view :

![Server View](https://i.imgur.com/Zsd1wKz.png)

Client view :

![Client View](https://i.imgur.com/CbORL6a.png)

## Features

- Clean loading sequence
- Preload certain files (eg config files)
- Load addon with beautiful message for both client and server
- Make you addon folder look more professionnal
- Every file is properly loaded

## Use this lib

- First, place the loader code into `autorun/` name it as you like
  - Like so `autorun/addon_loader.lua`
  - Content is [here](https://github.com/AzukiLife/azuki_lib/blob/master/addon_loader.lua) (You should edit the default fields to match your addon)
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

- [ ] Preload array working with path, not only file name
- [x] New function to preload a file (see main)
- [x] Move addon_loader code to a file in the repo
- [ ] Make so files in addons managed by the loader can have the same name (from different addon)
- [ ] Modules manager system
