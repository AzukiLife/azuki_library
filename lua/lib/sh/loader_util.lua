NeoLib = NeoLib or {}

--[[
    @author brv
    @date 08/05/2021
    @description Load addons and shit from this lib
]]

-- Counter for all files loaded
local loadedFiles = 0
-- Preloaded file table
local preloadedFiles = {}

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
local function getDirSize(directory)
    local size = 0
    local files = file.Find(directory.."*", "LUA")
    for _, file in ipairs(files) do
        if string.match(file, ".lua") then
            size = size + 1
        end
    end
    for _, dir in ipairs(dirs) do
        size = getDirSize(directory..dir.."/")
    end
    return size
end

-- Preloader (to load important things such as configs and stuff before launching core stuff)
function NeoLib.Preload(directory, file, log)
    preloadedFiles[file] = true
    NeoLib.LoadFile(directory, file, log)
end

-- Load a file from a given directory and file
function NeoLib.LoadFile(directory, file, log)
    loadedFiles = loadedFiles + 1
    if log then
        local author
        if string.match(directory, "sh") then author = "shared"
        elseif string.match(directory, "cl") then author = "client"
        else author = "server" end
        PrintC("Loaded "..file, string.upper(author))
    end
    if SERVER then
        AddCSLuaFile(directory..file)
    end
    include(directory..file)
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

function NeoLib.Initialize(name, version, preload)
    -- Init vars
    loadedFiles = 0
    preloadedFiles = {}
    preload = preload or {}
    -- Only print in client's console if client or shared folders have files in.
    if CLIENT and getDirSize(string.lower(name).."/sh/") == 0 and getDirSize(string.lower(name).."/cl/") == 0 then return end
    local banner = "=============== "..name.." | "..version.." ==============="
    -- Start of banner
    PrintC(banner)

    -- Preload
    for _, content in pairs(preload) do
        -- Automaticlly take care of not including server side script
        if CLIENT and !string.match(content[1], "/sv/") then
            NeoLib.Preload(content[1], content[2], true)
        elseif SERVER then
            NeoLib.Preload(content[1], content[2], true)
        end
    end

    -- Shared
    NeoLib.LoadAllFiles(string.lower(name).."/sh/")

    -- Server
    if SERVER then
        NeoLib.LoadAllFiles(string.lower(name).."/sv/")
    end

    -- Client
    NeoLib.LoadAllFiles(string.lower(name).."/cl/")

    --end of banner
    PrintC("Loaded "..loadedFiles.." files !", "COMPLETE")
    PrintC(string.rep("=", #banner).."\n")
end