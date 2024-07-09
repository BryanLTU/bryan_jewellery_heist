---@class Vitrine : OxClass
---@field id number
---@field coords vector3
---@field props table
---@field isOpen boolean
Vitrine = lib.class('Vitrine')

---@param coords vector3
---@param props table
function Vitrine:contructor(id, coords, props)
    self.coords = coords
    self.props = props
    self.isOpen = false
end

function Vitrine:open()
    -- TriggerClientEvent
    self.isOpen = true
end

function Vitrine:reset()
    -- TriggerClientEvent
    self.isOpen = false
end