Config = {}

-- esx, qb-core
Config.Framework = 'esx'

Config.RobberyTime = 10 -- Minutes
Config.Cooldown = 30 -- Minutes

Config.AutoLock = true

Config.RequiredPolice = 0
Config.PoliceJobs = {
    'police'
}

--TODO ps, qb, cd
Config.Dispatch = 'ps'

--TODO cd, qb, ox
Config.DoorLock = 'ox'

Config.Locations = {
    name = 'Vangelico\'s Jewellers',
    coords = vec3(-630.5, -237.13, 38.08),
    doors = {
        752, 753
    },
    thermite = {
        coords = vec4(-596.02, -283.7, 50.4, 300.0),
        amination = vec4(-596.02, -283.7, 50.4, 304.5),
        effect = vec3(-596.02, -283.7, 50.19)
    },
    hack = {

    }
}

-- Chance to trigger specific alerts
Config.Alerts = {
    startThermite = 50,
    successThermite = 100,
    failThermite = false
}

Config.Thermite = {
    item = 'thermal_charge',
    time = 60,
    gridsize = 5,
    incorrectBlocks = 10
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
    'weapon_assaultrifle',
    'weapon_carbinerifle',
    'weapon_pumpshotgun',
    'weapon_sawnoffshotgun',
    'weapon_compactrifle',
    'weapon_autoshotgun',
    'weapon_crowbar',
    'weapon_pistol',
    'weapon_pistol_mk2',
    'weapon_combatpistol',
    'weapon_appistol',
    'weapon_pistol50',
    'weapon_microsmg'
}

Config.Vitrines = {
    {
        coords = vec4(-626.83, -235.35, 38.05, 35.0),
        props = {
            pre = 'des_jewel_cab3_start',
            post = 'des_jewel_cab3_end'
        }
    },
    {
        coords = vec4(-625.81, -234.7, 38.05, 35.0),
        props = {
            pre = 'des_jewel_cab4_start',
            post = 'des_jewel_cab4_end'
        }
    },
    {
        coords = vec4(-626.95, -233.14, 38.05, 215.0),
        props = {
            pre = 'des_jewel_cab_start',
            post = 'des_jewel_cab_end'
        }
    },
    {
        coords = vec4(-628.0, -233.86, 38.05, 215.0),
        props = {
            pre = 'des_jewel_cab_start',
            post = 'des_jewel_cab_end'
        }
    },
    {
        coords = vec4(-625.7, -237.8, 38.05, 215.0),
        props = {
            pre = 'des_jewel_cab3_start',
            post = 'des_jewel_cab3_end'
        }
    },
    {
        coords = vec4(-626.7, -238.58, 38.05, 215.0),
        props = {
            pre = 'des_jewel_cab2_start',
            post = 'des_jewel_cab2_end'
        }
    },
    {
        coords = vec4(-624.55, -231.06, 38.05, 305.0),
        props = {
            pre = 'des_jewel_cab4_start',
            post = 'des_jewel_cab4_end'
        }
    },
    {
        coords = vec4(-623.13, -232.94, 38.05, 305.0),
        props = {
            pre = 'des_jewel_cab_start',
            post = 'des_jewel_cab_end'
        }
    },
    {
        coords = vec4(-620.29, -234.44, 38.05, 215.0),
        props = {
            pre = 'des_jewel_cab_start',
            post = 'des_jewel_cab_end'
        }
    },
    {
        coords = vec4(-619.15, -233.66, 38.05, 215.0),
        props = {
            pre = 'des_jewel_cab3_start',
            post = 'des_jewel_cab3_end'
        }
    },
    {
        coords = vec4(-620.19, -233.44, 38.05, 35.0),
        props = {
            pre = 'des_jewel_cab4_start',
            post = 'des_jewel_cab4_end'
        }
    },
    {
        coords = vec4(-617.63, -230.58, 38.05, 305.0),
        props = {
            pre = 'des_jewel_cab2_start',
            post = 'des_jewel_cab2_end'
        }
    },
    {
        coords = vec4(-618.33, -229.55, 38.05, 305.0),
        props = {
            pre = 'des_jewel_cab3_start',
            post = 'des_jewel_cab3_end'
        }
    },
    {
        coords = vec4(-619.7, -230.33, 38.05, 125.0),
        props = {
            pre = 'des_jewel_cab_start',
            post = 'des_jewel_cab_end'
        }
    },
    {
        coords = vec4(-620.95, -228.6, 38.05, 125.0),
        props = {
            pre = 'des_jewel_cab3_start',
            post = 'des_jewel_cab3_end'
        }
    },
    {
        coords = vec4(-619.79, -227.6, 38.05, 305.0),
        props = {
            pre = 'des_jewel_cab2_start',
            post = 'des_jewel_cab2_end'
        }
    },
    {
        coords = vec4(-620.42, -226.6, 38.05, 305.0),
        props = {
            pre = 'des_jewel_cab_start',
            post = 'des_jewel_cab_end'
        }
    },
    {
        coords = vec4(-623.94, -227.18, 38.05, 35.0),
        props = {
            pre = 'des_jewel_cab4_start',
            post = 'des_jewel_cab4_end'
        }
    },
    {
        coords = vec4(-624.91, -227.87, 38.05, 35.0),
        props = {
            pre = 'des_jewel_cab3_start',
            post = 'des_jewel_cab3_end'
        }
    },
    {
        coords = vec4(-623.94, -228.05, 38.05, 215.0),
        props = {
            pre = 'des_jewel_cab2_start',
            post = 'des_jewel_cab2_end'
        }
    }
}

Config.NoGloves = {
    Male = {
        [0] = true, [1] = true, [2] = true, [3] = true, [4] = true, [5] = true, [6] = true, [7] = true, [8] = true, [9] = true, [10] = true, [11] = true, [12] = true, [13] = true, [14] = true, [15] = true, [18] = true, [26] = true, [52] = true, [53] = true, [54] = true, [55] = true, [56] = true, [57] = true, [58] = true, [59] = true, [60] = true, [61] = true, [62] = true, [112] = true, [113] = true, [114] = true, [118] = true, [125] = true, [132] = true
    },
    Female = {
        [0] = true, [1] = true, [2] = true, [3] = true, [4] = true, [5] = true, [6] = true, [7] = true, [8] = true, [9] = true, [10] = true, [11] = true, [12] = true, [13] = true, [14] = true, [15] = true, [19] = true, [59] = true, [60] = true, [61] = true, [62] = true, [63] = true, [64] = true, [65] = true, [66] = true, [67] = true, [68] = true, [69] = true, [70] = true, [71] = true, [129] = true, [130] = true, [131] = true, [135] = true, [142] = true, [149] = true, [153] = true, [157] = true, [161] = true, [165] = true
    }
}