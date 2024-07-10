local Vitrines

lib.locale()

local function isHoldingAValidWeapon()
    local ped = PlayerPedId()
    local pedWeapon = GetSelectedPedWeapon(ped)

    if not Config.WhitelistWeapons or #Config.WhitelistWeapons == 0 then
        return true
    end

    for _, weaponModel in ipairs(Config.WhitelistWeapons) do
        if pedWeapon == GetHashKey(weaponModel) then
            return true
        end
    end

    return false
end

local function isWearingHandshoes()
    local playerPed = PlayerPedId()
    local armIndex = GetPedDrawableVariation(playerPed, 3)
    local model = GetEntityModel(playerPed)

    if model == `mp_m_freemode_01` and Config.NoGloves.Male[armIndex] ~= nil and Config.NoGloves.Male[armIndex] then
        return false
    elseif Config.NoGloves.Female[armIndex] ~= nil and Config.NoGloves.Female[armIndex] then
        return false
    end

    return true
end

---Apply offset to coordinates
---@param coords vector3|vector4
---@param offset vector3
---@param rotation number
---@return vector3
local applyOffset = function(coords, offset, rotation)
    local rad = math.rad(rotation)
    local cos = math.cos(rad)
    local sin = math.sin(rad)

    local newCoords = vector3(
        coords.x + offset.x * cos - offset.y * sin,
        coords.y + offset.x * sin + offset.y * cos,
        coords.z + offset.z
    )

    return newCoords
end

local plantTherminte = function()
    local playerPed = PlayerPedId()
    local pos, rot = Config.Locations.thermite.amination, GetEntityRotation(playerPed)
    local bagScene = NetworkCreateSynchronisedScene(pos.x, pos.y, pos.z, rot.x, rot.y, rot.z, 2, false, false, 1065353216, 0, 1.3)

    local bagModel, animDict = 'hei_p_m_bag_var22_arm_s', 'anim@heists@ornate_bank@thermal_charge'
    lib.requestModel(bagModel)
    lib.requestAnimDict(animDict)

    local bagObject = CreateObject(bagModel, pos.x, pos.y, pos.z, true, true, false)

    SetEntityCollision(bagObject, false, true)
    NetworkAddPedToSynchronisedScene(playerPed, bagScene, animDict, 'thermal_charge', 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bagObject, bagScene, animDict, 'bag_thermal_charge', 4.0, -8.0, 1)
    NetworkStartSynchronisedScene(bagScene)

    Citizen.Wait(1500)

    local thermalChargeModel = 'hei_prop_heist_thermite'
    lib.requestModel(thermalChargeModel)

    local thermalChargeObject = CreateObject(thermalChargeModel, pos.x, pos.y, pos.z + 0.2, true, true, true)

    SetEntityCollision(thermalChargeObject, false, true)
    AttachEntityToEntity(thermalChargeObject, playerPed, GetPedBoneIndex(playerPed, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 200.0, true, true, false, false, 1, true)

    Citizen.Wait(4000)

    TriggerServerEvent('bryan_jewellery_heist:server:removeThermiteItem')
    DetachEntity(thermalChargeObject, false, false)
    FreezeEntityPosition(thermalChargeObject, true)

    Citizen.Wait(100)

    DeleteObject(bagObject)
    ClearPedTasks(playerPed)

    local ptfxName = 'scr_ornate_heist'
    lib.requestNamedPtfxAsset(ptfxName)
    UseParticleFxAsset(ptfxName)

    local thermalChargeCoords = GetEntityCoords(thermalChargeObject)
    local ptfx = StartParticleFxLoopedAtCoord('scr_heist_ornate_thermal_burn', thermalChargeCoords.x, thermalChargeCoords.y + 1.0, thermalChargeCoords.z, 0.0, 0.0, 0.0, 0x3F800000, false, false, false, false)

    Citizen.Wait(3000)

    StopParticleFxLooped(ptfx, false)
    DeleteObject(thermalChargeObject)

    if math.random(0, 100) <= Config.Alerts.successThermite then
        _Dispatch('explosion')
    end

    TriggerServerEvent('bryan_jewellery_heist:server:toggleDoors', false)
    TriggerServerEvent('bryan_jewellery_heist:server:setStoreHit', true)
end

local smashVitrine = function(data)
    local playerPed = PlayerPedId()
    local playerCoords = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 0.6, 0.0)

    if not isHoldingAValidWeapon() then
        _Notification(locale('notification_invalid_weapon'), 'error')
        return
    end

    if math.random(0, 100) <= 80 and not isWearingHandshoes() then
        TriggerServerEvent('evidence:server:CreateFingerDrop', playerCoords)
    elseif math.random(1, 100) <= 5 and isWearingHandshoes() then
        TriggerServerEvent('evidence:server:CreateFingerDrop', playerCoords)
        _Notification(locale('notification_left_fingerprint'), 'info')
    end

    TriggerServerEvent('bryan_jewellery_heist:server:setVitrineBusy', data.vitrine.id, true)

    local startTime = GetGameTimer()
    local elapsedTime = GetGameTimer() - startTime
    TaskGoStraightToCoord(playerPed, data.vitrine.coords.x, data.vitrine.coords.y, data.vitrine.coords.z, 1.0, -1, data.vitrine.coords.w, 0.0)

    while #(GetEntityCoords(playerPed) - vector3(data.vitrine.coords.x, data.vitrine.coords.y, data.vitrine.coords.z)) > 0.1 and elapsedTime < 5 * 1000 do
        elapsedTime = GetGameTimer() - startTime
        Citizen.Wait(0)
    end
    TaskLookAtCoord(playerPed, data.vitrine.coords.x, data.vitrine.coords.y, data.vitrine.coords.z, 1, 0, 0)

    Citizen.Wait(500)

    TriggerServerEvent('bryan_jewellery_heist:server:setVitrineState', data.vitrine.id, true)
    TriggerServerEvent('InteractSound_SV:PlayOnSource', 'breaking_vitrine_glass', 0.25)
    lib.requestNamedPtfxAsset('scr_jewelheist')
    UseParticleFxAsset('scr_jewelheist')
    StartParticleFxLoopedAtCoord('scr_jewel_cab_smash', playerCoords.x, playerCoords.y, playerCoords.z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)

    local animDict = 'missheist_jewel'

    if _Progress(locale('smash_progress'), 5000, {
        dict = animDict,
        clip = 'smash_case',
        blendIn = 8.0,
        blendOut = 8.0,
        duration = 5000,
        flag = 31
    }) then
        lib.requestAnimDict(animDict)
        TaskPlayAnim(playerPed, animDict, 'exit', 3.0, 3.0, -1, 2, 0, false, false, false)
        _Dispatch('robbery', data.vitrine.id)

        TriggerServerEvent('bryan_jewellery_heist:server:vitrineReward', data.vitrine.id)
        TriggerServerEvent('bryan_jewellery_heist:server:setVitrineBusy', data.vitrine.id, false)
    end
end

local setVitrines = function(vitrines)
    Vitrines = lib.array:new()
    for index, data in ipairs(vitrines) do
        Vitrines:push(Vitrine:new(index, data.coords, data.props))
    end

    lib.array.forEach(Vitrines, function(vitrine)
        local id = exports['ox_target']:addBoxZone({
            coords = applyOffset(vitrine.coords, vector3(0.0, 0.5, 0.0), vitrine.coords.w),
            size = vec3(1.0, 0.5, 1.0),
            rotation = vitrine.coords.w,
            drawSprite = true,
            options = {
                {
                    label = locale('smash_vitrine'),
                    icon = 'fa fa-hand',
                    canInteract = function()
                        return not vitrine.isOpen and not vitrine.isBusy
                    end,
                    onSelect = smashVitrine,
                    vitrine = { id = vitrine.id, coords = vitrine.coords }
                }
            }
        })
    end)
end

function GetCamID(k)
    if k <= 6 then
        return 31
    elseif k == 7 or k >= 18 and k <= 20 then
        return 32
    elseif k >= 12 and k <= 17 then
        return 33
    elseif k >= 8 and k <= 11 then
        return 34
    elseif k >= 21 and k <= 26 then
        return 35
    elseif k >= 27 and k <= 32 then
        return 36
    end

    return 0
  end

RegisterNetEvent('bryan_jewellery_heist:client:setVitrines', function(vitrines)
    setVitrines(vitrines)
end)

RegisterNetEvent('bryan_jewellery_heist:client:setVitrineState', function(id, value)
    if type(id) == 'number' then
        local vitrine = lib.array.find(Vitrines, function(v)
            return v.id == id
        end)

        if not vitrine then
            return
        end

        if value then
            vitrine:open()
        else
            vitrine:reset()
        end
    elseif id == 'all' then
        lib.array.forEach(Vitrines, function(vitrine)
            if value then
                vitrine:open()
            else
                vitrine:reset()
            end
        end)
    end
end)

RegisterNetEvent('bryan_jewellery_heist:client:setVitrineBusy', function(id, value)
    if type(id) == 'number' then
        local vitrine = lib.array.find(Vitrines, function(v)
            return v.id == id
        end)

        if not vitrine then return end

        vitrine:setBusy(value)
    elseif id == 'all' then
        lib.array.forEach(Vitrines, function(vitrine)
            vitrine:setBusy(value)
        end)
    end
end)

RegisterNetEvent('bryan_jewellery_heist:client:startThermite', function()
    local isOnCooldown, timeLeft = lib.callback.await('bryan_jewellery_heist:server:isOnCooldown')
    if isOnCooldown then
        _Notification(locale('notification_on_cooldown', timeLeft), 'error')
        return
    end

    if lib.callback.await('bryan_jewellery_heist:server:isStoreHit', false) then
        _Notification(locale('notification_store_is_hit'), 'error')
        return
    end

    if not lib.callback.await('bryan_jewellery_heist:server:isPoliceCountHighEnough', false) then
        _Notification(locale('notification_not_enough_police'), 'error')
        return
    end

    if not lib.callback.await('bryan_jewellery_heist:server:checkThermiteItem', false) then
        _Notification(locale('notification_no_item'))
        return
    end

    if Config.Alerts.startThermite and math.random(0, 100) <= Config.Alerts.startThermite then
        _Dispatch('startThermite')
    end

    exports['ps-ui']:Thermite(function(success)
        if not success then
            _Notification(locale('notification_thermite_fail'), 'error')
            return
        end

        _Notification(locale('notification_thermite_success', locale('jewellery_store')), 'success')
        plantTherminte()
    end, Config.Thermite.time, Config.Thermite.gridsize, Config.Thermite.incorrectBlocks)
end)

Citizen.CreateThread(function()
    setVitrines(lib.callback.await('bryan_jewellery_heist:server:getVitrinesArray', false))
end)

exports['ox_target']:addBoxZone({
    coords = vec3(Config.Locations.thermite.coords.x, Config.Locations.thermite.coords.y, Config.Locations.thermite.coords.z),
    rotation = Config.Locations.thermite.coords.w,
    drawSprite = true,
    options = {
        {
            label = locale('blow_fuse_box'),
            icon = 'fas fa-bug',
            items = Config.Thermite.item,
            event = 'bryan_jewellery_heist:client:startThermite'
        }
    }
})