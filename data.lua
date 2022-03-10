function data_init()
    GAME.data = json.decode(g2.data)
    if type(GAME.data) ~= "table" then GAME.data = {} end
end