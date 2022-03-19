AzuLib = AzuLib or {}

--[[
    @author brv
    @date 03/10/2021
]]

-- Counter for all files loaded
local loadedFiles = 0
-- Preloaded file table
local preloadedFiles = {}

print("[*] Neo Lib is now ready to load addons")

-- Colors for printing
local baseColor = Color(255, 255, 255)
local clientColor = Color(214, 137, 73)
local serverColor = Color(88, 189, 230)
local sharedColor = Color(161, 99, 212)
local completeColor = Color(84, 185, 143)

-- Print beautiful messages
local function PrintC(message, prefix)
    if prefix then prefix = "("..prefix..") " else prefix = "" end
    if string.match(prefix, "SERVER") then
        MsgC(baseColor, "[AzuLib] ", serverColor, prefix, baseColor, message.."\n")
    elseif string.match(prefix, "CLIENT") then
        MsgC(baseColor, "[AzuLib] ", clientColor, prefix, baseColor, message.."\n")
    elseif string.match(prefix, "SHARED") then
        MsgC(baseColor, "[AzuLib] ", sharedColor, prefix, baseColor, message.."\n")
    elseif string.match(prefix, "COMPLETE") then
        MsgC(baseColor, "[AzuLib] ", completeColor, prefix, baseColor, message.."\n")
    else
        MsgC(baseColor, "[AzuLib] "..prefix..message.."\n")
    end
end

-- Load a file from a given directory and file
function AzuLib.LoadFile(directory, file, log)
    loadedFiles = loadedFiles + 1
    local author
    if log then  
        if string.match(directory, "sh") then author = "shared"
        elseif string.match(directory, "cl") then author = "client"
        else author = "server" end
        PrintC("Loaded "..file, string.upper(author))
    end
    if SERVER then
        AddCSLuaFile(directory..file)
    end
    if SERVER and author and author == "client" then return end
    include(directory..file)   
end

-- Load all files from a given directory
function AzuLib.LoadDirectory(directory)
    local files, dirs = file.Find(directory.."*", "LUA")
    -- Loop trough all files in the current dir
    for _, file in ipairs(files) do
        if string.match(file, ".lua") and !preloadedFiles[file] then
            AzuLib.LoadFile(directory, file, true)
        end
    end
    for _, dir in ipairs(dirs) do
        AzuLib.LoadDirectory(directory..dir.."/")
    end
end

-- Preload Function
function AzuLib.PreloadFile(addon_name, preload)
    if not preload then return end -- Preload = nil
    for _, content in pairs(preload) do
        local target = content[1]
        local file = content[2]
        if target != "sh" or target != "sv" or target != "cl" then
            print("[!] Failed to preload "..file.." because target '"..target.."' is invalid")
            return 
        end
        target = addon_name..target
        preloadedFiles[file] = true
        AzuLib.LoadFile(target, file, true)
    end
end

function AzuLib.Initialize(addon_name, addon_version, preload)
    -- Init vars
    loadedFiles = 0
    preloadedFiles = {}
    preload = preload or {}

    -- Dirs Name
    local shared_dir = string.lower(addon_name).."/sh/"
    local client_dir = string.lower(addon_name).."/cl/"
    local server_dir = string.lower(addon_name).."/sv/"

    -- Prevent blank messages
    if CLIENT and not file.Exists(client_dir.."*", "LUA") and not file.Exists(shared_dir.."*", "LUA") then return end
    local banner = "=============== "..addon_name.." - "..addon_version.." ==============="
    PrintC(banner)
    -- Preload
    AzuLib.PreloadFile(addon_name, preload)
    -- Server
    if SERVER then
        AzuLib.LoadDirectory(server_dir)
    end
    -- Shared
    AzuLib.LoadDirectory(shared_dir)
    -- Client
    AzuLib.LoadDirectory(client_dir)
    PrintC("Loaded "..loadedFiles.." lua files", "COMPLETE")
    PrintC(string.rep("=", #banner).."\n")
end

function AzuLib.ThrowError(addon_name, message)
    if addon_name and message then
        print("")
        print("")
        print("")
    else
        return 
    end
end