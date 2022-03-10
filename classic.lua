function galcon_classic_init()
    local G = GAME.galcon
    math.randomseed(os.time())
    
    g2.game_reset();
   
    local o = g2.new_user("neutral",0x555555)
    o.user_neutral = 1
    o.ships_production_enabled = 0
    G.neutral = o
    
    local users = {}
    G.users = users

    for uid,client in pairs(GAME.clients) do
        if client.status == "play" then
            local p = g2.new_user(client.name,client.color)
            users[#users+1] = p
            p.user_uid = client.uid
            client.live = 0
        end
    end

    local sw = 480
    local sh = 320
    
    for i=1,23 do
        g2.new_planet( o, math.random(0,sw),math.random(0,sh), math.random(15,100), math.random(0,50))
    end
    local a = math.random(0,360)
    
    for i,user in pairs(users) do
        local x,y
        x = sw/2 + (sw/2)*math.cos(a*math.pi/180.0)/2.0
        y = sh/2 + (sh/2)*math.sin(a*math.pi/180.0)/2.0
        g2.new_planet(user, x,y, 100, 100);
        a = a + 360/#users
    end
    
    g2.planets_settle(0,0,sw,sh)
    g2.net_send("","sound","sfx-start");

    local r = g2.search("planet")
end

function count_production()
    local r = {}
    local items = g2.search("planet -neutral")
    for _i,o in ipairs(items) do
        local team = o:owner():team()
        r[team] = (r[team] or 0) + o.ships_production
    end
    return r
end

function most_production()
    local r = count_production()
    local best_o = nil
    local best_v = 0
    for o,v in pairs(r) do
        if v > best_v then
            best_v = v
            best_o = o
        end
    end
    return best_o
end

function galcon_stop(res)
    if res == true then
        local o = most_production()
        net_send("","message",o.title_value.." conquered the galaxy")
    end
    g2.net_send("","sound","sfx-stop");
    GAME.engine:next(GAME.modules.lobby)
end

function galcon_classic_loop()
    local G = GAME.galcon
    local r = count_production()
    local total = 0
    for k,v in pairs(r) do total = total + 1 end
    if #G.users <= 1 and total == 0 then
        galcon_stop(false)
    end
    if #G.users > 1 and total <= 1 then
        galcon_stop(true)
    end
end

function find_user(uid)
    for n,e in pairs(g2.search("user")) do
        if e.user_uid == uid then return e end
    end
end
function galcon_surrender(uid)
    local G = GAME.galcon

    local user = find_user(uid)
    if user == nil then return end
    for n,e in pairs(g2.search("planet owner:"..user)) do
        e:planet_chown(G.neutral)
    end
end

function galcon_init()
    GAME.modules.galcon = GAME.modules.galcon or {}
    GAME.galcon = GAME.galcon or {}
    local obj = GAME.modules.galcon
    function obj:init()
        g2.state = "play"
        params_set("state","play")
        params_set("html",[[<table>
            <tr><td><input type='button' value='Resume' onclick='resume' />
            <tr><td><input type='button' value='Surrender' onclick='/surrender' />
            </table>]])
        galcon_classic_init()
    end
    function obj:loop(t)
        galcon_classic_loop()
    end
    function obj:event(e)
        if e.type == 'net:message' and e.value == '/abort' then
            galcon_stop(false)
        end
        if e.type == 'net:leave' then
            galcon_surrender(e.uid)
        end
        if e.type == 'net:message' and e.value == '/surrender' then
            galcon_surrender(e.uid)
        end
    end
end