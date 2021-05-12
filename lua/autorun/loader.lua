NeoLib = NeoLib or {}

if NeoLib.Config.CountAddon then
    loadedAddonsCount = 0
end

include("lib/sh/loader_util.lua")
AddCSLuaFile("lib/sh/loader_util.lua")