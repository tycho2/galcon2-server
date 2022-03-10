function clients_queue()
    local colors = {
        0x0000ff,0xff0000,
        0xffff00,0x00ffff,
        0xffffff,0xff8800,
        0x99ff99,0xff9999,
        0xbb00ff,0xff88ff,
        0x9999ff,0x00ff00,
    }
    local q = nil
    for k,e in pairs(GAME.clients) do
        if e.status == "away" or e.status == "queue" then
            e.color = 0x555555
        end
        if e.status == "queue" then q = e end
        for i,v in pairs(colors) do
            if v == e.color then colors[i] = nil end
        end
    end
    if q == nil then return end
    for i,v in pairs(colors) do
        if v ~= nil then
            q.color = v
            q.status = "play"
            net_send("","message",q.name .. " is /play")
            return
        end
    end
end
function clients_init()
    GAME.modules.clients = GAME.modules.clients or {}
    GAME.clients = GAME.clients or {}
    local obj = GAME.modules.clients
    function obj:event(e)
        if e.type == 'net:join' then
            GAME.clients[e.uid] = {uid=e.uid,name=e.name,status="queue"}
            clients_queue()
            net_send("","message",e.name .. " joined")
            g2.net_send("","sound","sfx-join");
        end
        if e.type == 'net:leave' then
            GAME.clients[e.uid] = nil
            net_send("","message",e.name .. " left")
            g2.net_send("","sound","sfx-leave");
            clients_queue()
        end
        if e.type == 'net:message' and e.value == '/play' then
            if GAME.clients[e.uid].status == "away" then
                GAME.clients[e.uid].status = "queue"
                clients_queue()
            end
        end
        if e.type == 'net:message' and e.value == '/away' then
            if GAME.clients[e.uid].status == "play" then
                GAME.clients[e.uid].status = "away"
                clients_queue()
                net_send("","message",e.name .. " is /away")
            end
        end
        if e.type == 'net:message' and e.value == '/who' then
            local msg = ""
            for _,c in pairs(GAME.clients) do
                msg = msg .. c.name .. ", "
            end
            net_send(e.uid,"message","/who: "..msg)
        end
    end
end