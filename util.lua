function util_firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end

function util_getNumPlayersWithStatus(status)
    local numPlayers = 0
    for _, user in pairs(GAME.clients) do
        if user.status == status then
            numPlayers = numPlayers + 1
        end
    end
    
    return numPlayers
end