local addon_name = "addon_name" -- eg ULX
local addon_version = "addon_version" -- eg 1.0

hook.Add("AuzkiLibrary:Ready", "__"..addon_name..addon_version.."AZLIB-Load", function()
    if AuzkiLibrary then 
        --[[
            If your addon need to load certain files first, add them like this in preload table.
            You can load anything from client to server, file will load in the order you give them.
            Note: File loads one time only, don't worry
        ]] 
        local preload = {
            -- {target, file}
            {"sh", "config.lua"} -- First parameter only accept "sh", "sv" and "cl"
        }
        AuzkiLibrary.Initialize(addon_name, addon_version, preload)
    else
        print("[!] Fatal Error: Problemes occured while loading Auzki Library")    
    end
end)
