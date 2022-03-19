local addon_name = "addon_name" -- eg ULX
local addon_version = "addon_version" -- eg 1.0

if AzuLib then 
    --[[
        If your addon need to load certain files first, add them like this in preload table.
        You can load anything from client to server, file will load in the order you give them.
        Note: File loads one time only, don't worry
    ]] 
    local preload = {
        -- {target, file}
        {"sh", "config.lua"} -- First parameter only accept "sh", "sv" and "cl"
    }

    AzuLib.Initialize(addon_name, addon_version, preload)
else
    print("[!] Cannot load "..addon_name.." (Azuki Lib is missing)")    
end