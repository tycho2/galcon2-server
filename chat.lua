function chat_init()
    GAME.modules.chat = GAME.modules.chat or {}
    GAME.clients = GAME.clients or {}
    local obj = GAME.modules.chat
    function obj:event(e)
        if e.type == 'net:message' then
            net_send("","chat",json.encode({uid=e.uid,color=GAME.clients[e.uid].color,value="<"..GAME.clients[e.uid].name.."> "..e.value}))
        end
    end
end