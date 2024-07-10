fx_version 'cerulean'
game 'gta5'

author 'BryaN'
version 'v0.0.0'

lua54 'yes'

shared_scripts {
    '@ox_lib/init.lua',
    'shared/*.lua',
    'config.lua'
}

client_scripts {
    'client/*.lua'
}

server_scripts {
    'server/*.lua'
}

files {
    'locales/*.json'
}

dependencies {
    'ps-ui',
    'ox_lib'
}