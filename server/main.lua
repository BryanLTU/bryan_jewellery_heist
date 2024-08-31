local Vitrines = lib.array:new()
local IsHit, Executor = false, -1
local RobberyTime, Cooldown = 0, 0

lib.locale()

local setupVitrinesArray = function()
    for index, data in ipairs(Config.Vitrines) do
        Vitrines:push(Vitrine:new(index, data.coords, data.props))
    end

    SendClientVitrinesData(-1)
end

local getPoliceCount = function()
    local count = 0

    for _, playerId in ipairs(GetPlayers()) do
        local _playerId = tonumber(playerId)

        if type(_playerId) == 'number' and _IsPlayerActive(_playerId) then
            local playerJobName = _GetPlayerJobName(_playerId)

            for _, jobName in ipairs(Config.PoliceJobs) do
                if playerJobName == jobName then
                    count = count + 1
                    break
                end
            end
        end
    end

    return count
end

local resetVitrines = function()
    lib.array.forEach(Vitrines, function(vitrine)
        vitrine:reset()
    end)

    TriggerClientEvent('bryan_jewellery_heist:client:setVitrineState', -1, 'all', false)
end

local toggleLockdownVitrines = function(value)
    lib.array.forEach(Vitrines, function(vitrine)
        vitrine:setBusy(value)
    end)

    TriggerClientEvent('bryan_jewellery_heist:client:setVitrineBusy', -1, 'all', value)
end

SendClientVitrinesData = function(playerId)
    TriggerClientEvent('bryan_jewellery_heist:client:setVitrines', playerId, Vitrines)
end

lib.callback.register('bryan_jewellery_heist:server:getVitrinesArray', function()
    return Vitrines
end)

lib.callback.register('bryan_jewellery_heist:server:isStoreHit', function()
    return IsHit
end)

lib.callback.register('bryan_jewellery_heist:server:isOnCooldown', function()
    return Cooldown > 0, Cooldown
end)

lib.callback.register('bryan_jewellery_heist:server:isPoliceCountHighEnough', function()
    return getPoliceCount() >= Config.RequiredPolice
end)

lib.callback.register('bryan_jewellery_heist:server:checkThermiteItem', function(source)
    return _HasEnoughItem(source, Config.Thermite.item, 1)
end)

RegisterNetEvent('bryan_jewellery_heist:server:setStoreHit', function(value)
    IsHit = value
    Executor = source
    toggleLockdownVitrines(not value)

    if value then
        RobberyTime = Config.RobberyTime

        if Config.SoundAlarm.enable then
            TriggerClientEvent('bryan_jewellery_heist:client:playSound', -1)
        end
    end
end)

RegisterNetEvent('bryan_jewellery_heist:server:removeThermiteItem', function()
    _RemoveInventoryItem(source, Config.Thermite.item, 1)
end)

RegisterNetEvent('bryan_jewellery_heist:server:toggleDoors', function(value)
    local _source = source

    if Config.DoorLock == 'qb' then
        TriggerClientEvent('qb-doorlock:client:setState', -1, _source, Config.Locations.doors[1], value, _source, false, false)
    elseif Config.DoorLock == 'ox' then
        local door = exports['ox_doorlock']:getDoorFromName(string.format('jewellery_stores %s', Config.Locations.doors[1]))

        if not door then return end

        exports['ox_doorlock']:setDoorState(door.id, value)
    elseif Config.Dispatch == 'cd' then
        TriggerClientEvent('cd_doorlock:SetDoorState_name', -1, value, Config.Locations.doors[1], locale('jewellery_store'))
    end
end)

RegisterNetEvent('bryan_jewellery_heist:server:setVitrineState', function(id, value)
    local vitrine = lib.array.find(Vitrines, function(v)
        return v.id == id
    end)

    if not vitrine then return end

    if value then
        vitrine:open()
    else
        vitrine:reset()
    end

    TriggerClientEvent('bryan_jewellery_heist:client:setVitrineState', -1, id, value)
end)

RegisterNetEvent('bryan_jewellery_heist:server:setVitrineBusy', function(id, value)
    local vitrine = lib.array.find(Vitrines, function(v)
        return v.id == id
    end)

    if not vitrine then return end

    vitrine:setBusy(value)

    TriggerClientEvent('bryan_jewellery_heist:client:setVitrineBusy', -1, id, value)
end)

RegisterNetEvent('bryan_jewellery_heist:server:vitrineReward', function(vitrineId)
    local _source = source
    local vitrine = lib.array.find(Vitrines, function(v)
        return v.id == vitrineId
    end)

    if not vitrine then
        return
    end

    local reward, myChance

    while reward == nil or myChance == nil or myChance > reward.chance do
        reward = Config.Rewards[math.random(1, #Config.Rewards)]
        myChance = math.random(0, 100)
    end

    local amount = type(reward.amount) == 'table' and math.random(reward.amount.min, reward.amount.max) or reward.amount

    _GiveInventoryItem(_source, reward.item, amount)
end)

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName ~= GetCurrentResourceName() then
        return
    end

    setupVitrinesArray()
end)

lib.cron.new('* * * * *', function()
    if Cooldown ~= 0 then
        Cooldown = Cooldown - 1

        if Cooldown == 0 then
            IsHit = false
            resetVitrines()
        end
    end

    if RobberyTime ~= 0 then
        RobberyTime = RobberyTime - 1

        if (RobberyTime == 5 or RobberyTime == 3 or RobberyTime == 1) and Executor ~= -1 and GetPlayerName(Executor) and #(GetEntityCoords(GetPlayerPed(Executor)) - Config.Locations.coords) <= 20.0 then
            _Notification(Executor, locale('notification_time_left', RobberyTime), 'info')
        elseif RobberyTime == 0 then
            Executor = -1
            toggleLockdownVitrines(true)
            Cooldown = Config.Cooldown

            if Config.AutoLock then
                TriggerEvent('bryan_jewellery_heist:server:toggleDoors', true)
                _Notification(Executor, locale('notification_doors_locked'), 'info')
            end
        end
    end
end)