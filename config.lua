Config = {}

Config.Framework = "auto"
Config.DefaultKey = "HOME"
Config.DefaultUI = "fullscreen"
Config.RefreshInterval = 3000

Config.Theme = {
    bg = "rgba(15,15,20,0.92)",
    panel = "rgba(22,22,30,0.98)",
    accent = "#00E5FF",
    accent2 = "#8A2BE2",
    text = "#FFFFFF",
    muted = "#9aa0a6",
    success = "#21c55d",
    danger = "#ef4444",
    warning = "#f59e0b",
    shadow = "0 10px 30px rgba(0,0,0,0.45)"
}

Config.Services = {
    { job = "police",    label = "Police",   icon = "🛡️", color = "#00B4D8" },
    { job = "ambulance", label = "EMS",      icon = "🚑",  color = "#EF476F" },
    { job = "mechanic",  label = "Mechanic", icon = "🔧",  color = "#F77F00" }
}

Config.Admins = {
    ["god"]   = { label = "Owner",      color = "#FF006E", icon = "👑" },
    ["admin"] = { label = "Admin",      color = "#8338EC", icon = "🛡️" },
    ["mod"]   = { label = "Moderator",  color = "#3A86FF", icon = "🔨" }
}

Config.OkokBossMenu = {
    enabled = true,
    resource = "okokBossMenu",
    export  = "IsPlayerOnDuty"
}

Config.ESXAssumeOnDutyJobs = { "police", "ambulance", "mechanic" }

Config.Locale = "en"
