NeoLib = NeoLib or {}
NeoLib.Loader = NeoLib.Loader or {}

--[[
    @author brv
    @date 08/05/2021
    @description Load addons and shit from this lib
]]

-- Counter for all files loaded
local loadedFiles = 0
-- Preloaded file table
local preloadedFiles = {}
-- For banner size and responsivity
local banner = ""

-- Colors for printing
local baseColor = Color(255, 255, 255)
local clientColor = Color(214, 137, 73)
local serverColor = Color(88, 189, 230)
local sharedColor = Color(161, 99, 212)
-- Colors for banner
local nameColor = Color(161, 99, 212)
local versionColor = Color(161, 99, 212)

-- Get Author
local function getAuthor(directory)
    local author
    if string.match(directory, "sh") then author = "shared"
    elseif string.match(directory, "cl") then author = "client"
    else author = "server" end
    return author
end

-- Print beautiful messages
local function PrintC(message, prefix)
    if prefix then
        prefix = "["..prefix.."] "
    else
        prefix = ""
    end
    if SERVER then
        MsgC(baseColor, "[NeoLib] "..prefix..message.."\n")
    else
        MsgC(baseColor, "[NeoLib] "..prefix..message.."\n")
    end
end

-- Preloader (to load important things such as configs and stuff before launching core stuff)
function NeoLib.Loader.Preload(directory, file, log)
    preloadedFiles[file] = true
    NeoLib.Loader.LoadFile(directory, file, log)
end

-- Load a file from a given directory and file
function NeoLib.Loader.LoadFile(directory, file, log)
    loadedFiles = loadedFiles + 1
    if log then
        local author = getAuthor(directory)
        PrintC("Loaded "..file, string.upper(author))
    end
    if SERVER then
        AddCSLuaFile(directory..file)
    end
    include(directory..file)
end

-- Load all files from a given directory
function NeoLib.Loader.LoadAllFiles(directory)
    local files, dirs = file.Find(directory.."*", "LUA")
    -- Loop trough all files in the current dir
    for _, file in ipairs(files) do
        if string.match(file, ".lua") and !preloadedFiles[file] then
            NeoLib.Loader.LoadFile(directory, file, true)
        end
    end
    -- Recursivity
    for _, dir in ipairs(dirs) do
        NeoLib.Loader.LoadAllFiles(directory..dir.."/")
    end
end

function NeoLib.Loader.Initialize(name, version, preload)
    -- Init vars
    loadedFiles = 0
    preloadedFiles = {}
    preload = preload or {}
    banner = "=============== "..name.." | "..version.." ==============="
    name = string.lower(name)
    -- Start of banner
    PrintC(banner)

    -- Preload
    for _, content in pairs(preload) do
        -- Automaticlly take care of not including server side script
        if CLIENT and !string.match(content[1], "/sv/") then
            NeoLib.Loader.Preload(content[1], content[2], true)
        elseif SERVER then
            NeoLib.Loader.Preload(content[1], content[2], true)
        end
    end

    -- Shared
    NeoLib.Loader.LoadAllFiles(string.lower(name).."/sh/")

    -- Server
    if SERVER then
        NeoLib.Loader.LoadAllFiles(string.lower(name).."/sv/")
    end

    -- Client
    NeoLib.Loader.LoadAllFiles(string.lower(name).."/cl/")

    --end of banner
    PrintC("Loaded "..loadedFiles.." files !", "COMPLETE")
    PrintC(string.rep("=", #banner).."\n")
end