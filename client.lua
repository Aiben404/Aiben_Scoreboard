local FW = nil
local FWType = nil
local scoreboardOpen = false
local uiMode = nil
local locale = nil

local function DetectFramework()
    if Config.Framework ~= "auto" then
        return Config.Framework
    end
    if GetResourceState("es_extended") == "started" then
        return "esx"
    end
    if GetResourceState("qb-core") == "started" then
        return "qb-core"
    end
    if GetResourceState("qbx-core") == "started" or GetResourceState("qbox") == "started" then
        return "qbox"
    end
    return "qb-core"
end

local function InitFramework()
    FWType = DetectFramework()
    if FWType == "esx" then
        FW = exports["es_extended"]:getSharedObject()
    elseif FWType == "qb-core" then
        FW = exports["qb-core"]:GetCoreObject()
    elseif FWType == "qbox" then
        FW = exports["qbx-core"] and exports["qbx-core"]:GetCoreObject() or exports["qb-core"]:GetCoreObject()
    end
end

CreateThread(function()
    InitFramework()
    uiMode = Config.DefaultUI
    locale = Locales[Config.Locale] or Locales["en"]

    RegisterCommand("aiben_scoreboard", function()
        if scoreboardOpen then
            CloseScoreboard()
        else
            OpenScoreboard()
        end
    end, false)

    RegisterKeyMapping("aiben_scoreboard", "Open Aiben Scoreboard", "keyboard", Config.DefaultKey)
end)

function OpenScoreboard()
    scoreboardOpen = true
    SetNuiFocus(true, true)
    SendNUIMessage({ action = "open", ui = uiMode, theme = Config.Theme, locale = locale })
    RequestRefresh()
    CreateThread(function()
        while scoreboardOpen do
            Wait(Config.RefreshInterval)
            RequestRefresh()
        end
    end)
end

function CloseScoreboard()
    scoreboardOpen = false
    SetNuiFocus(false, false)
    SendNUIMessage({ action = "close" })
end

function RequestRefresh()
    TriggerServerEvent("aiben_scoreboard:requestData")
end

RegisterNetEvent("aiben_scoreboard:sendData", function(payload)
    SendNUIMessage({
        action = "update",
        data = payload
    })
end)

RegisterNUICallback("toggleUIMode", function(data, cb)
    uiMode = (uiMode == "fullscreen") and "compact" or "fullscreen"
    SendNUIMessage({ action = "setUIMode", ui = uiMode })
    cb(true)
end)

RegisterNUICallback("close", function(_, cb)
    CloseScoreboard()
    cb(true)
end)

CreateThread(function()
    while true do
        Wait(0)
        if scoreboardOpen and IsControlJustPressed(0, 200) then
            CloseScoreboard()
        end
    end
end)
