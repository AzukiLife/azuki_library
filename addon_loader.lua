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