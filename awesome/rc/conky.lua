-------------------
--  THIS IS WIP  --
-------------------

local conky = {}

conky.conky = nil
conky.get_conky = function(default)
    if conky.conky and conky.conky.valid then
        return conky.conky
    end

    conky.conky = awful.client.iterate(function(c) return c.class == "Conky" end)()
    return conky.conky or default
end

conky.raise_conky = function()
    conky.get_conky({}).ontop = true
end

conky.lower_conky = function()
    conky.get_conky({}).ontop = false
end

local t = timer({ timeout = 0.01 })
t:connect_signal("timeout", function()
    t:stop()
    conky.lower_conky()
end)
conky.lower_conky_delayed = function()
    t:again()
end

conky.toggle_conky = function()
    local conky = conky.get_conky({})
    conky.ontop = not conky.ontop
end
