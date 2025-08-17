# Aiben Scoreboard

A modern, feature-rich scoreboard for FiveM servers with support for ESX, QBCore, and Qbox frameworks. Features a beautiful okok-style UI with both fullscreen and compact display modes.

![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)
![Framework](https://img.shields.io/badge/framework-ESX%20%7C%20QBCore%20%7C%20Qbox-green.svg)
![License](https://img.shields.io/badge/license-MIT-yellow.svg)

## ✨ Features

- **Multi-Framework Support**: Fully compatible with ESX, QBCore, and Qbox
- **Dual UI Modes**: Fullscreen layout or compact card-style display
- **Real-time Updates**: Live player count, duty status, and ping information
- **Service Integration**: Built-in support for okokBossMenu duty system
- **Admin Highlighting**: Customizable admin role display with colors and icons
- **Search Functionality**: Filter players by name in real-time
- **Responsive Design**: Modern UI with okok-style theming
- **Easy Configuration**: Simple drag-and-drop installation
- **Multi-language Support**: Built-in translation system

## 📸 Screenshots

### Fullscreen Mode
![Fullscreen Scoreboard](https://r2.fivemanage.com/fDUKi7rgEhC1caoH2Yksm/Screenshot2025-08-17081742.png)

### Compact Mode
![Compact Scoreboard](https://r2.fivemanage.com/fDUKi7rgEhC1caoH2Yksm/Screenshot2025-08-17081748.png)

## 🚀 Installation

### 1. Download & Install
1. Download the resource files
2. Place the `Scoreboard` folder in your server's `resources` directory
3. Add `ensure Scoreboard` to your `server.cfg`

### 2. Framework Detection
The resource automatically detects your framework:
- **ESX**: Detects `es_extended`
- **QBCore**: Detects `qb-core`
- **Qbox**: Detects `qbox-core`

### 3. Keybind Setup
- Default key: `HOME`
- Players can change this via GTA keybinds (FiveM key mapping)
- Command: `aiben_scoreboard`

## ⚙️ Configuration

### Basic Settings
```lua
Config.Framework = "auto"           -- "auto" | "qb-core" | "qbox" | "esx"
Config.DefaultKey = "HOME"          -- Default keybind
Config.DefaultUI = "fullscreen"     -- "fullscreen" | "compact"
Config.RefreshInterval = 3000       -- Update interval (ms)
```

### Theme Customization
```lua
Config.Theme = {
    bg = "rgba(15,15,20,0.92)",     -- Background color
    panel = "rgba(22,22,30,0.98)",  -- Panel background
    accent = "#00E5FF",             -- Primary accent (neon cyan)
    accent2 = "#8A2BE2",            -- Secondary accent (neon purple)
    text = "#FFFFFF",               -- Text color
    muted = "#9aa0a6",              -- Muted text color
    success = "#21c55d",            -- Success color
    danger = "#ef4444",             -- Danger color
    warning = "#f59e0b",            -- Warning color
    shadow = "0 10px 30px rgba(0,0,0,0.45)"  -- Shadow effect
}
```

### Services Configuration
```lua
Config.Services = {
    { job = "police",    label = "Police",   icon = "🛡️", color = "#00B4D8" },
    { job = "ambulance", label = "EMS",      icon = "🚑",  color = "#EF476F" },
    { job = "mechanic",  label = "Mechanic", icon = "🔧",  color = "#F77F00" }
}
```

### Admin Roles
```lua
Config.Admins = {
    ["god"]   = { label = "Owner",      color = "#FF006E", icon = "👑" },
    ["admin"] = { label = "Admin",      color = "#8338EC", icon = "🛡️" },
    ["mod"]   = { label = "Moderator",  color = "#3A86FF", icon = "🔨" }
}
```

### okokBossMenu Integration
```lua
Config.OkokBossMenu = {
    enabled = true,
    resource = "okokBossMenu",      -- Your okokBossMenu resource name
    export  = "IsPlayerOnDuty"      -- Export function name
}
```

## 🎮 Usage

### Player Controls
- **Open Scoreboard**: Press `HOME` key (default)
- **Switch UI Mode**: Click "Compact" or "Fullscreen" button
- **Search Players**: Type in the search box to filter players
- **Close Scoreboard**: Click the "✕" button or press `HOME` again

### UI Modes

#### Fullscreen Mode
- Complete player list with all details
- Service statistics
- Search functionality
- Admin role highlighting
- Real-time duty status

#### Compact Mode
- Minimal card display
- Player count and duty statistics
- Service overview
- Quick access to fullscreen mode

## 🌐 Localization

The resource supports multiple languages. Edit `locales.lua` to add new translations:

```lua
Locales["fr"] = {
    title = "Tableau de Bord du Serveur",
    total_players = "Joueurs en Ligne",
    on_duty = "En Service",
    -- ... add more translations
}
```

Set your preferred language in `config.lua`:
```lua
Config.Locale = "en"  -- Change to your language code
```

## 🔧 Dependencies

### Required
- ESX, QBCore, or Qbox framework

### Optional
- `okokBossMenu` - For enhanced duty system integration

## 📁 File Structure

```
Scoreboard/
├── fxmanifest.lua          # Resource manifest
├── config.lua              # Configuration file
├── client.lua              # Client-side logic
├── server.lua              # Server-side logic
├── locales.lua             # Translation strings
├── README.md               # This file
└── html/
    ├── index.html          # UI structure
    ├── style.css           # Styling
    └── script.js           # UI logic
```

## 🐛 Troubleshooting

### Common Issues

1. **Scoreboard not opening**
   - Check if the resource is started: `ensure Scoreboard`
   - Verify keybind in GTA settings
   - Check console for errors

2. **Framework not detected**
   - Ensure your framework resource is started before Scoreboard
   - Check `Config.Framework` setting

3. **Duty status not showing**
   - Verify okokBossMenu integration settings
   - Check ESX duty system configuration

4. **UI not displaying correctly**
   - Clear browser cache
   - Restart the resource

### Debug Mode
Enable debug logging by checking the server console for detailed information.

## 🤝 Support

For support and questions:
- Check the troubleshooting section above
- Review the configuration options
- Ensure all dependencies are properly installed

## 📝 Changelog

### Version 1.0.0
- Initial release
- Multi-framework support
- Dual UI modes (fullscreen/compact)
- Real-time player information
- Admin role highlighting
- Service integration
- Search functionality
- Multi-language support

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Credits

- **Author**: Aiben
- **Framework Support**: ESX, QBCore, Qbox
- **UI Design**: okok-style theming
- **Icons**: Unicode emoji support

---

**Made with ❤️ for the FiveM community**



