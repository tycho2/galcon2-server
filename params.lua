function params_set(k,v)
    GAME.params[k] = v
    net_send("",k,v)
end
function params_init()
    GAME.modules.params = GAME.modules.params or {}
    GAME.params = GAME.params or {}
    GAME.params.state = GAME.params.state or "lobby"
    GAME.params.html = GAME.params.html or ""
    params_modes()
    local obj = GAME.modules.params
    function obj:event(e)
        if e.type == 'net:join' then
            net_send(e.uid,"state",GAME.params.state)
            net_send(e.uid,"html",GAME.params.html)
            net_send(e.uid,"tabs",GAME.params.tabs)
        end
    end
end

function params_modes()
    GAME.params.modes = {"classic"}
    GAME.params.currentMode = GAME.params.modes[1]
end