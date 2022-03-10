function register_init()
    GAME.modules.register = GAME.modules.register or {}
    local obj = GAME.modules.register
    obj.t = 0
    obj.players = 0
    obj.maxPlayers = 0
    obj.seperator = " - "
    function obj:loop(t)
        if GAME.module == GAME.modules.menu then return end
        self.t = self.t - t
        if self.t < 0 then
            self.t = 60
            self.mode = util_firstToUpper(GAME.data.currentMode)
            g2_api_call("register",
            json.encode(
                {
                    -- Example: "Classic - 1/2"
                    title = self.mode .. self.seperator .. self.players .. '/' .. self.maxPlayers,
                    port  = GAME.data.port
                }
            ))
        end
    end
end