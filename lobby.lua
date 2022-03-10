function lobby_init()
    GAME.modules.lobby = GAME.modules.lobby or {}
    local obj = GAME.modules.lobby
    function obj:init()
        g2.state = "lobby"
        params_set("state","lobby")
        params_set("tabs","<table class='box' width=160><tr><td><h2>My Server</h2></table>")
        params_set("html","<p>Lobby ... enter /start to play!</p>")
    end
    function obj:loop(t) end
    function obj:event(e)
        if e.type == 'net:message' and e.value == '/start' then
            GAME.engine:next(GAME.modules.galcon)
        end
    end
end