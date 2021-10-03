NeoLib = NeoLib or {}

--[[
    @author brv
    @date 03/10/2021
    @description Load addons with ease
]]

-- Counter for all files loaded
local loadedFiles = 0
-- Preloaded file table
local preloadedFiles = {}
-- Folders name
local shared_dir = nil
local client_dir = nil
local server_dir = nil

print("[~] New Neo Lib instance created")

-- Colors for printing
local baseColor = Color(255, 255, 255)
local clientColor = Color(214, 137, 73)
local serverColor = Color(88, 189, 230)
local sharedColor = Color(161, 99, 212)
local completeColor = Color(84, 185, 143)

-- Print beautiful messages
local function PrintC(message, prefix)
    if prefix then prefix = "["..prefix.."] " else prefix = "" end
    if string.match(prefix, "SERVER") then
        MsgC(baseColor, "[NeoLib] ", serverColor, prefix, baseColor, message.."\n")
    elseif string.match(prefix, "CLIENT") then
        MsgC(baseColor, "[NeoLib] ", clientColor, prefix, baseColor, message.."\n")
    elseif string.match(prefix, "SHARED") then
        MsgC(baseColor, "[NeoLib] ", sharedColor, prefix, baseColor, message.."\n")
    elseif string.match(prefix, "COMPLETE") then
        MsgC(baseColor, "[NeoLib] ", completeColor, prefix, baseColor, message.."\n")
    else
        MsgC(baseColor, "[NeoLib] "..prefix..message.."\n")
    end
end

-- Return number of lua files in given directory
local function GetDirectorySize(directory)
    local size = 0
    local files, dirs = file.Find(directory.."*", "LUA")
    for _, file in ipairs(files) do
        if string.match(file, ".lua") then
            size = size + 1
        end
    end
    for _, dir in ipairs(dirs) do
        size = GetDirectorySize(directory..dir.."/")
    end
    return size
end

-- Preloader (to load important things such as configs and stuff before launching core stuff)
function NeoLib.Preload(directory, file, log)

end

-- Load a file from a given directory and file
function NeoLib.LoadFile(directory, file, log)
    loadedFiles = loadedFiles + 1
    local author
    if log then  
        if string.match(directory, "sh") then author = "shared"
        elseif string.match(directory, "cl") then author = "client"
        else author = "server" end
        PrintC("Loaded "..file, string.upper(author))
    end

    -- /!\ 
    -- region - This portion of code is maybe faulty
    if SERVER then
        AddCSLuaFile(directory..file)
    end
    if SERVER and author and author == "client" then return end
    include(directory..file)
    -- endregion
    
end

-- Load all files from a given directory
function NeoLib.LoadAllFiles(directory)
    local files, dirs = file.Find(directory.."*", "LUA")
    -- Loop trough all files in the current dir
    for _, file in ipairs(files) do
        if string.match(file, ".lua") and !preloadedFiles[file] then
            NeoLib.LoadFile(directory, file, true)
        end
    end
    -- Recursivity
    for _, dir in ipairs(dirs) do
        NeoLib.LoadAllFiles(directory..dir.."/")
    end
end

-- Preload Function
function NeoLib.PreloadFile(name, preload)
    if not preload then return end
    for _, content in pairs(preload) do
        -- Place addon name if forgotten in the addon loader script
        local folder = content[1]
        if !string.match(folder, string.lower(name)) then folder = string.lower(name)..folder end
        local file = content[2]
        preloadedFiles[file] = true
        NeoLib.LoadFile(folder, file, true)
    end
end

function NeoLib.Initialize(addon_name, addon_version, preload, custom)
    -- Init vars
    loadedFiles = 0
    preloadedFiles = {}
    preload = preload or {}

    -- Dirs Name
    local shared_dir = string.lower(addon_name)
    local client_dir = string.lower(addon_name).."/cl/"
    local server_dir = string.lower(addon_name).."/sv/"

    -- Only display messages if directories exsist
    -- OLD : if CLIENT and GetDirectorySize(string.lower(addon_name).."/sh/") == 0 and GetDirectorySize(string.lower(addon_name).."/cl/") == 0 then return end
    if CLIENT and not file.Exists(client_dir) and not file.Exists(shared_dir) then return end


    local banner = "=============== "..addon_name.." | "..addon_version.." ==============="
    -- Start of banner
    PrintC(banner)
    -- Preload
    NeoLib.Preload(addon_name, addon_version, preload)
    -- Shared
    NeoLib.LoadAllFiles(string.lower(addon_name).."/sh/")
    -- Server
    if SERVER then
        NeoLib.LoadAllFiles(string.lower(addon_name).."/sv/")
    end
    -- Client
    NeoLib.LoadAllFiles(string.lower(addon_name).."/cl/")
    --end of banner
    PrintC("Loaded "..loadedFiles.." files !", "COMPLETE")
    PrintC(string.rep("=", #banner).."\n")
    if NeoLib.Config.CountAddon then
        LoadedAddonsCount = LoadedAddonsCount + 1;
    end
end