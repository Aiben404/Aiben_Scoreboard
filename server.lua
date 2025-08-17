local FW = nil
local FWType = nil

local function DetectFramework()
    if Config.Framework ~= "auto" then return Config.Framework end
    if GetResourceState("es_extended") == "started" then return "esx" end
    if GetResourceState("qb-core") == "started" then return "qb-core" end
    if GetResourceState("qbx-core") == "started" or GetResourceState("qbox") == "started" then return "qbox" end
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
    print(("[Aiben_Scoreboard] Framework detected: %s"):format(FWType or "unknown"))
end

CreateThread(function() InitFramework() end)

local function okokDuty(source)
    if not Config.OkokBossMenu.enabled then return nil end
    if not Config.OkokBossMenu.resource or GetResourceState(Config.OkokBossMenu.resource) ~= "started" then
        return nil
    end
    local ok, result = pcall(function()
        local fn = exports[Config.OkokBossMenu.resource][Config.OkokBossMenu.export]
        if type(fn) == "function" then
            return fn(source)
        end
        return nil
    end)
    if ok then return result end
    return nil
end

local function frameworkDuty(player)
    if not player then return false end
    if FWType == "qb-core" or FWType == "qbox" then
        local job = player.PlayerData and player.PlayerData.job
        if job and job.onduty ~= nil then
            return job.onduty == true
        end
        return false
    elseif FWType == "esx" then
        if player.get and player.get("onDuty") ~= nil then
            return player.get("onDuty") == true
        end
        local job = player.getJob and player.getJob() or (player.job or {})
        if job and job.name then
            for _, j in ipairs(Config.ESXAssumeOnDutyJobs) do
                if j == job.name then return true end
            end
        end
        return false
    end
    return false
end

local function getPlayerGroup(player, src)
    if FWType == "qb-core" or FWType == "qbox" then
        if player and player.PlayerData and player.PlayerData.group then
            return tostring(player.PlayerData.group)
        end
        if IsPlayerAceAllowed(src, "group.admin") then return "admin" end
    elseif FWType == "esx" then
        if player and player.getGroup then
            return tostring(player.getGroup())
        end
        if IsPlayerAceAllowed(src, "group.admin") then return "admin" end
    end
    return "user"
end

local function getPlayerJobAndGrade(player)
    if FWType == "qb-core" or FWType == "qbox" then
        local job = player and player.PlayerData and player.PlayerData.job
        if job then
            return job.name or "unemployed", (job.grade and (job.grade.name or job.grade.level)) or ""
        end
    elseif FWType == "esx" then
        local job = player and (player.getJob and player.getJob() or player.job)
        if job then
            return job.name or "unemployed", (job.grade_label or (job.grade and job.grade.name)) or tostring(job.grade or "")
        end
    end
    return "unemployed", ""
end

local function fetchFrameworkPlayer(src)
    if FWType == "qb-core" or FWType == "qbox" then
        return FW and FW.Functions and FW.Functions.GetPlayer and FW.Functions.GetPlayer(src) or nil
    elseif FWType == "esx" then
        return FW and FW.GetPlayerFromId and FW.GetPlayerFromId(src) or nil
    end
    return nil
end

local function buildPayload()
    local players = {}
    local countsByService = {}
    local onDutyTotal = 0

    for _, svc in ipairs(Config.Services) do
        countsByService[svc.job] = { label = svc.label, color = svc.color, icon = svc.icon, total = 0, duty = 0 }
    end

    local all = GetPlayers()
    for _, id in ipairs(all) do
        local src = tonumber(id)
        local name = GetPlayerName(src) or ("Player "..id)
        local ping = GetPlayerPing(src) or 0
        local p = fetchFrameworkPlayer(src)

        local jobName, grade = getPlayerJobAndGrade(p)
        local duty
        local okok = okokDuty(src)
        if okok ~= nil then duty = okok else duty = frameworkDuty(p) end

        if countsByService[jobName] then
            countsByService[jobName].total = countsByService[jobName].total + 1
            if duty then countsByService[jobName].duty = countsByService[jobName].duty + 1 end
        end
        if duty then onDutyTotal = onDutyTotal + 1 end

        local group = getPlayerGroup(p, src)
        local adminData = Config.Admins[group]

        players[#players+1] = {
            id = src,
            name = name,
            job = jobName,
            grade = tostring(grade or ""),
            ping = ping,
            duty = duty and true or false,
            admin = adminData and { label = adminData.label, color = adminData.color, icon = adminData.icon } or nil,
            group = group
        }
    end

    local servicesArray = {}
    for _, svc in ipairs(Config.Services) do
        local row = countsByService[svc.job] or { label = svc.label, color = svc.color, icon = svc.icon, total = 0, duty = 0 }
        servicesArray[#servicesArray+1] = { job = svc.job, label = row.label, icon = row.icon, color = row.color, total = row.total, duty = row.duty }
    end

    return {
        totals = {
            online = #all,
            duty = onDutyTotal
        },
        services = servicesArray,
        players = players,
        ts = os.time()
    }
end

RegisterNetEvent("aiben_scoreboard:requestData", function()
    local payload = buildPayload()
    TriggerClientEvent("aiben_scoreboard:sendData", source, payload)
end)
