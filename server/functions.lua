FrameworkObj = nil

if Config.Framework == 'esx' and GetResourceState('es_extended') == 'started' then
    FrameworkObj = exports['es_extended']:getSharedObject()

    AddEventHandler('esx:playerLoaded', function(playerId)
        SendClientVitrinesData(playerId)
    end)
elseif Config.Framework == 'qb-core' and GetResourceState('qb-core') == 'started' then
    FrameworkObj = exports['qb-core']:GetCoreObject()

    AddEventHandler('QBCore:Server:PlayerLoaded', function(Player)
        SendClientVitrinesData(Player.PlayerData.source)
    end)
end

---Notification for client
---@param playerId number
---@param msg string
---@param type string?
_Notification = function(playerId, msg, type)
    lib.notify(playerId, {
        title = locale('jewellery_store'),
        description = msg,
        type = type
    })
end

---Get player's job name
---@param playerId number
---@return string
_GetPlayerJobName = function(playerId)
    if Config.Framework == 'esx' then
        return FrameworkObj.GetPlayerFromId(playerId).getJob().name
        return FrameworkObj.Functions.GetPlayer(playerId).PlayerData.job.name
    end

    return 'unemployeed'
end

---Cehcks if the player has enough of the specified item
---@param playerId number
---@param itemName string
---@param requiredAmount number
---@return boolean
_HasEnoughItem = function(playerId, itemName, requiredAmount)
    if Config.Framework == 'esx' then
        return FrameworkObj.GetPlayerFromId(playerId).getInventoryItem(itemName).count >= requiredAmount
        return exports['qb-inventory']:GetItemCount(source, itemName) >= requiredAmount
    end

    return false
end

---Remove inventory item
---@param playerId number
---@param itemName string
---@param amount number
_RemoveInventoryItem = function(playerId, itemName, amount)
    if Config.Framework == 'esx' then
        FrameworkObj.GetPlayerFromId(playerId).removeInventoryItem(itemName, amount)
        exports['qb-inventory']:RemoveItem(playerId, itemName, 1, false, 'bryan_jewellery_heist:server:removeItem')
    end
end

---Give inventory item
---@param playerId number
---@param itemName string
---@param amount number
_GiveInventoryItem = function(playerId, itemName, amount)
    if Config.Framework == 'esx' then
        FrameworkObj.GetPlayerFromId(playerId).addInventoryItem(itemName, amount)
        exports['qb-inventory']:AddItem(playerId, itemName, 1, false, false, 'bryan_jewellery_heist:server:addItem')
    end
end