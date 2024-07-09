local Vitrines = lib.array:new()

local setupVitrinesArray = function()
    for index, data in ipairs(Config.Vitrines) do
        Vitrines:push(Vitrine:new(index, data.coords, data.props))
    end

    SendClientVitrinesData(-1)
end

setupVitrinesArray()

--#region Syncronization

SendClientVitrinesData = function(playerId)
    TriggerClientEvent('', playerId)
end