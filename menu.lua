function menu_init()
    GAME.modules.menu = GAME.modules.menu or {}
    local obj = GAME.modules.menu
    function obj:init()
        g2.html = [[
            <table>
            <tr><td><h1>Galcon 2 Server</h1>
            <tr><td><p>by Tycho2</p>
            <tr><td><p>&nbsp;</p>
            <tr><td><input type='text' name='port' value='$PORT' />
            <tr><td><p>&nbsp;</p>
            <tr><td><input type='button' value='Start Server' onclick='host' />"
            </table>
            ]]
        data_init()
        g2.form.port = GAME.data.port or "23099"
        g2.state = "menu"
    end
    function obj:loop(t) end
    function obj:event(e)
        if e.type == 'onclick' and e.value == 'host' then
            GAME.data.port = g2.form.port
            g2.data = json.encode(GAME.data)
            g2.net_host(GAME.data.port)
            GAME.engine:next(GAME.modules.lobby)
            if g2.headless == nil then
                g2.net_join("",GAME.data.port)
            end
        end
    end
end