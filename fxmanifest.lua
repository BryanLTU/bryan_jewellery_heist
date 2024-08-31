fx_version 'cerulean'
game 'gta5'

author 'BryaN'
version '1.0.3'

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