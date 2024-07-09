Config = {}

Config.RobberyTime = 10 -- Minutes
Config.Cooldown = 30 -- Minutes

Config.AutoLock = true

Config.RequiredPolice = 0
Config.PoliceJobs = {
    ['police'] = true,
    ['sheriff'] = true
}

Config.AvailableHours = {
    open = 0,
    close = 0
}

--TODO ps, qb, cd
Config.Dispatch = 'ps'

--TODO cd, qb, ox
Config.DoorLoock = 'cd'

Config.Locations = {
    name = 'Vangelico\'s Jewellers',
    coords = vec3(-630.5, -237.13, 38.08),
    doors = {

    },
    thermite = {
        coords = vec4(-596.02, -283.7, 50.4, 300.0)
    },
    hack = {

    }
}

Config.Thermite = {
    item = 'c4_bomb',
    time = 60,
    gridsize = 5,
    incorrectBlocks = 10
}

Config.Hack = {
    item = 'phone',
    blocks = 2,
    time = 20
}

Config.Rewards = {
    {
        chance = 100,
        item = 'jewels',
        amount = { min = 1, max = 2 }
    },
    {
        chance = 5,
        item = 'diamond',
        amount = 1
    }
}

Config.WhitelistWeapons = {
    ['weapon_assaultrifle'] = true,
    ['weapon_carbinerifle'] = true,
    ['weapon_pumpshotgun'] = true,
    ['weapon_sawnoffshotgun'] = true,
    ['weapon_compactrifle'] = true,
    ['weapon_autoshotgun'] = true,
    ['weapon_crowbar'] = true,
    ['weapon_pistol'] = true,
    ['weapon_pistol_mk2'] = true,
    ['weapon_combatpistol'] = true,
    ['weapon_appistol'] = true,
    ['weapon_pistol50'] = true,
    ['weapon_microsmg'] = true
}

Config.Vitrines = {
    {
        coords = vec3(-626.83, -235.35, 38.05),
        props = {
            pre = 'des_jewel_cab3_start',
            post = 'des_jewel_cab3_end'
        }
    }
}