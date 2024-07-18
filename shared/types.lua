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

---@class QBItem
---@field name string
---@field amount number

---@class QBPlayerData
---@field job QBJob

---@class QBPlayerFunctions
---@field AddItem fun(item: string, amount: number, slot: number?, info: any?)
---@field RemoveItem fun(item: string, amount: number, slot: number?)
---@field GetItemByName fun(item: string): QBItem

---@class QBPlayer
---@field PlayerData QBPlayerData
---@field Functions QBPlayerFunctions

---@class QBFunctions
---@field GetPlayer fun(source: number): QBPlayer

---@class QBCore
---@field Functions QBFunctions