---@type ESX | QBCore
FrameworkObj = nil

if Config.Framework == 'esx' and GetResourceState('es_extended') == 'started' then
    ---@type ESX
    FrameworkObj = exports['es_extended']:getSharedObject()

    AddEventHandler('esx:playerLoaded', function(playerId)
        SendClientVitrinesData(playerId)
    end)
elseif Config.Framework == 'qb-core' and GetResourceState('qb-core') == 'started' then
    ---@type QBCore
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

---Check if player's object exists (prevents multi char errors)
---@param playerId number
---@return boolean
_IsPlayerActive = function(playerId)
    if Config.Framework == 'esx' then
        return FrameworkObj.GetPlayerFromId(playerId) ~= nil
    elseif Config.Framework == 'qb-core' then
        return FrameworkObj.Functions.GetPlayer(playerId) ~= nil
    end

    return false
end

---Get player's job name
---@param playerId number
---@return string
_GetPlayerJobName = function(playerId)
    if Config.Framework == 'esx' then
        return FrameworkObj.GetPlayerFromId(playerId).getJob().name
    elseif Config.Framework == 'qb-core' then
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
    elseif Config.Framework == 'qb-core' then
        return FrameworkObj.Functions.GetPlayer(playerId).Functions.GetItemByName(itemName).amount >= requiredAmount
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
    elseif Config.Framework == 'qb-core' then
        FrameworkObj.Functions.GetPlayer(playerId).Functions.RemoveItem(itemName, amount)
    end
end

---Give inventory item
---@param playerId number
---@param itemName string
---@param amount number
_GiveInventoryItem = function(playerId, itemName, amount)
    if Config.Framework == 'esx' then
        FrameworkObj.GetPlayerFromId(playerId).addInventoryItem(itemName, amount)
    elseif Config.Framework == 'qb-core' then
        FrameworkObj.Functions.GetPlayer(playerId).Functions.AddItem(itemName, amount)
    end
end