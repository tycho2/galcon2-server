if g2.headless == nil then
    require("mod_client") -- HACK: not a clean import, but it works
end

function net_send(uid,mtype,mvalue) -- HACK - to make headed clients work
    if g2.headless == nil and (uid == "" or uid == g2.uid) then
        GAME.modules.client:event({type="net:"..mtype,value=mvalue})
    end
    g2.net_send(uid,mtype,mvalue)
end