# Neo Lib 

This library is a pretty and clean way to load lua files for GMod server (also support client).
So you don't have to put "include" and "AddCSLuaFile" everywhere!

![Pretty loader exemple](https://octodex.github.com/images/yaktocat.png)

## How I implement it ?

- You have to create a loader in `autorun/` folder
    - Like so `autorun/loader.lua`
- After that, move everything in `youraddonname/`
    - Also, create `youraddonname/sv/`, `youraddonname/sh/`, `youraddonname/cl/` (Keep it that way, even if there is no file in cl, sh or sv)
- Place server scripts in `youraddonname/sv/` and so on for others (client, shared)
- For each client file, you have to add this line at the top: ```if SERVER then return end```
- And in every server file you have to add: ```if CLIENT then return end```
- Finally, you should have something like this : ![Example](https://i.imgur.com/otc58l8.gif)

## Keep in mind

This addon is mainly for my personnal server. If you only need loader option only keep this `lib/sh/loader_util.lua`, you can get rid of anything else.
Also edit `autorun/loader.lua` and remove every include you don't need!