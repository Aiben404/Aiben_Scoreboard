fx_version 'cerulean'
game 'gta5'

author 'Aiben'
description 'Aiben Scoreboard scoreboard for ESX/QBCore/Qbox'
version '1.0.0'

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/style.css',
    'html/script.js'
}

shared_script 'config.lua'
shared_script 'locales.lua'
client_script 'client.lua'
server_script 'server.lua'
