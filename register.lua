function register_init()
    GAME.modules.register = GAME.modules.register or {}
    local obj = GAME.modules.register
    obj.t = 0
    obj.seperator = " - "
    function obj:loop(t)
        if GAME.module == GAME.modules.menu then return end
        self.t = self.t - t
        if self.t < 0 then
            self.t = 60
            self.mode = util_firstToUpper(GAME.params.currentMode)
            self.numActivePlayers = GAME.params.numActivePlayers
            self.maxPlayers = GAME.params.maxPLayers

            g2_api_call("register",
            json.encode(
                {
                    -- Format: "Classic - 1/2"
                    title = self.mode .. self.seperator .. self.numActivePlayers .. '/' .. self.maxPlayers,
                    port  = GAME.data.port
                }
            ))
        end
    end
end