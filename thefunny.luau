local pot = {}
function pot:hookremote(remote, callback)
    local oldFireServer = remote.FireServer
    remote.FireServer = function(self, ...)
        return callback(self, ...) or oldFireServer(self, ...)
    end
end
function pot:getplayers(filter)
    local players = game:GetService('Players'):GetPlayers()
    if filter then
        return table.filter(players, filter)
    end
    return players
end
function pot:getmemoryusage()
    return collectgarbage('count')
end
function pot:modifymemory(address, value)
    setreadonly(memory, false)
    memory.write(address, value)
    setreadonly(memory, true)
end
return pot
