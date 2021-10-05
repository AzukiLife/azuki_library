local addon_name = "addon_name" -- eg ULX
local addon_version = "addon_version" -- eg 1.0
local retries = 0
local LIMIT = 10

-- Prevent the file from loading before the lib
while not NeoLib and retries<=LIMIT do
    timer.Simple(0.5, function()
        retries = retries + 1
    end)
end

if NeoLib then 
    --[[
        If your addon need to load certain files first, add them like this in preload table.
        You can load anything from client to server, file will load in the order you give them.
        Note: File loads one time only, don't worry
    ]] 
    local preload = {
        -- {folder, file}
        {"addon_name/sh/", "config.lua"} -- Also accept "/sh/" for folder name but not "sh" or "sh/"
    }

    NeoLib.Initialize(addon_name, addon_version, preload)
else
    print("[!] Cannot load "..addon_name.." after "..retries_count.." retries")    
end