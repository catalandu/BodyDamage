fx_version 'adamant'

game 'gta5'

-- Leaked By: Leaking Hub | J. Snow | leakinghub.com

server_scripts {
  '@async/async.lua',
  '@mysql-async/lib/MySQL.lua',
  'server/main.lua'
}

client_scripts {
  'client/main.lua'
}

ui_page 'html/ui.html'
files {
  'html/ui.html',
  'html/ui.css', 
  'html/ui.js',
  'html/farming.png',
}

client_script 'config.lua'