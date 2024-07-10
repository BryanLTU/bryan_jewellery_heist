FrameworkObj = nil

if Config.Framework == 'esx' and GetResourceState('es_extended') == 'started' then
    FrameworkObj = exports['es_extended']:getSharedObject()

    AddEventHandler('esx:playerLoaded', function(playerId)
        SendClientVitrinesData(playerId)
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
    end
end

---Cehcks if the player has enough of the specified item
---@param playerId number
---@param itemName string
---@param requiredAmount number
---@return boolean
_HasEnoughItem = function(playerId, itemName, requiredAmount)
    if Config.Framework == 'esx' then
        return FrameworkObj.GetPlayerFromId(playerId).getInventoryItem(itemName).count >= requiredAmount
    end
end

---Remove inventory item
---@param playerId number
---@param itemName string
---@param amount number
_RemoveInventoryItem = function(playerId, itemName, amount)
    if Config.Framework == 'esx' then
        FrameworkObj.GetPlayerFromId(playerId).removeInventoryItem(itemName, amount)
    end
end

---Give inventory item
---@param playerId number
---@param itemName string
---@param amount number
_GiveInventoryItem = function(playerId, itemName, amount)
    if Config.Framework == 'esx' then
        FrameworkObj.GetPlayerFromId(playerId).addInventoryItem(itemName, amount)
    end
end