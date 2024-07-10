--ESX

---@class ESXJob
---@field name string

---@class ESXItem
---@field name string
---@field count number

---@class xPlayer
---@field getJob fun(): ESXJob
---@field getInventoryItem fun(itemName: string): ESXItem
---@field removeInventoryItem fun(itemName: string, amount: number)
---@field addInventoryItem fun(itemName: string, amount: number)

---@class ESX
---@field GetPlayerFromId fun(playerId: number): xPlayer

-- QBCore

---@class QBJob
---@field name string

---@class QBPlayerData
---@field job QBJob

---@class QBPlayer
---@field PlayerData QBPlayerData

---@class QBFunctions
---@field GetPlayer fun(source: number): QBPlayer

---@class QBCore
---@field Functions QBFunctions