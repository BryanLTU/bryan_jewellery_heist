# BryaN Jewellery Heist
Simple jewellery store heist for ESX and QBCore Frameworks. This script is based of [don-jewellery](https://github.com/DonHulieo/don-jewellery) script.

## Dependencies
| Script | Download |
|---|---|
| ESX / QB Core | |
| ox_lib | https://github.com/overextended/ox_lib |
| ox_target | https://github.com/overextended/ox_target |
| ps-ui | https://github.com/Project-Sloth/ps-ui |

## Configuration

1. Framework selection
- "esx" - ESX
- "qb-core" - QB Core
```lua
Config.Framework = 'esx'
```

2. Timers:
- Robbery Time - How long do the robbers have till the Jewellery Store closes (does not let them rob them any more)
- Cooldown - Cooldown starts after __Robbery Time__. This timer makes Jewellery Store unable to be robbed again, till the timer finishes.
```lua
Config.RobberyTime = 10 -- Minutes
Config.Cooldown = 30 -- Minutes
```

3. Required Police
- Required Police - A minimum count which represents how many players should be with required job title
- Police Jobs - Avalaible police job list
```lua
Config.RequiredPolice = 0
Config.PoliceJobs = {
    'police'
}
```

4. Disptach
- "ps" - [ps-disptach](https://github.com/Project-Sloth/ps-dispatch)
- "qb" - [qb-policejob](https://github.com/qbcore-framework/qb-policejob)
- "cd" - [cd_disptach](https://codesign.pro/package/4206357)
```lua
Config.Dispatch = 'ps'
```

5. Locations
- doors - left and right door ids of the Jewellery Store (Should be changed depending on the doorlock system that is used)
- thermite - all options regarding thermite positioning
  - coords - coordinates in which the thermite will be planted
  - animation - position in whcih the animation should be player and the direction
  - effect - particle effect that will be player on the thermite object
```lua
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
    }
}
```

6. Alerts
Here it can be configured what is the chance to trigger certain alerts. If the chance is set to ``false`` then the alert will not be triggered. In this example there are 3 places in which alerts can be triggered.
- startThermite - will report suspicious activity to dispatch
- successThermite - doors have been unlocked (vitrines are robbable)
```lua
Config.Alerts = {
    startThermite = 50,
    successThermite = 100
}
```

7. Thermite
- item - Which inventory item should be used for the thermite plant
- time, gridsize, incorrrectBlocks - These are options for the ps-ui script's Thermite hack.
```lua
Config.Thermite = {
    item = 'thermal_charge',
    time = 60,
    gridsize = 5,
    incorrectBlocks = 10
}
```

8. Rewards
List of possible items to get when vitrine is broken.
- item:
  - chance: number - between 0-100 a chance to retrieve that item. If it's 0, it would be impossible to get it.
  - item: string - item name
  - amount: number/table - if it's a number, then that's the consisten amount the player will get. If it's a table it should have min and max values, and each time it will give an amount between those values.
```lua
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
```

## Support
BryaN's Scripts [Discord](https://discord.gg/vdrc7jqNbd)
