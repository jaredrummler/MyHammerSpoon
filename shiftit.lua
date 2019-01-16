local units = {
    { key = 'q', unit = { x = 0.00, y = 0.00, w = 0.30, h = 0.50 } }, -- up left 30 width
    { key = 'w', unit = { x = 0.00, y = 0.00, w = 0.50, h = 0.50 } }, -- up left 50 width
    { key = 'e', unit = { x = 0.00, y = 0.00, w = 0.70, h = 0.50 } }, -- up left 70 width
    { key = 'a', unit = { x = 0.00, y = 0.00, w = 0.30, h = 1.00 } }, -- full left 30 width
    { key = 's', unit = { x = 0.00, y = 0.00, w = 0.50, h = 1.00 } }, -- full left 50 width
    { key = 'd', unit = { x = 0.00, y = 0.00, w = 0.70, h = 1.00 } }, -- full left 70 width
    { key = 'z', unit = { x = 0.00, y = 0.50, w = 0.30, h = 0.50 } }, -- bottom left 30 width
    { key = 'x', unit = { x = 0.00, y = 0.50, w = 0.50, h = 0.50 } }, -- bottom left 50 width
    { key = 'c', unit = { x = 0.00, y = 0.50, w = 0.70, h = 0.50 } }, -- bottom left 70 width
    { key = 'p', unit = { x = 0.70, y = 0.00, w = 0.30, h = 0.50 } }, -- up right 30 width
    { key = 'o', unit = { x = 0.50, y = 0.00, w = 0.50, h = 0.50 } }, -- up right 50 width
    { key = 'i', unit = { x = 0.30, y = 0.00, w = 0.70, h = 0.50 } }, -- up right 70 width
    { key = 'l', unit = { x = 0.70, y = 0.00, w = 0.30, h = 1.00 } }, -- right 30 width
    { key = 'k', unit = { x = 0.50, y = 0.00, w = 0.50, h = 1.00 } }, -- right 50 width
    { key = 'j', unit = { x = 0.30, y = 0.00, w = 0.70, h = 1.00 } }, -- right 70 width
    { key = 'm', unit = { x = 0.70, y = 0.50, w = 0.30, h = 0.50 } }, -- bottom right 30 width
    { key = 'n', unit = { x = 0.50, y = 0.50, w = 0.50, h = 0.50 } }, -- bottom right 50 width
    { key = 'b', unit = { x = 0.30, y = 0.50, w = 0.70, h = 0.50 } }, -- bottom right 70 width
    { key = '[', unit = { x = 0.00, y = 0.00, w = 1.00, h = 0.50 } }, -- top 50 width
    { key = ']', unit = { x = 0.00, y = 0.50, w = 1.00, h = 0.50 } } -- bottom 50 width
}

local mash = { 'ctrl', 'alt', 'cmd' }

for i, unit in ipairs(units) do
    hs.hotkey.bind(mash, unit.key, function() hs.window.focusedWindow():move(unit.unit, nil, true) end)
end

local size = 1.00
for i = 1, 10 do
    local key
    if i == 10 then
        key = '0'
    else
        key = tostring(i)
    end
    local x = (1.00 - size) / 2
    local unit = { x = x, y = x, w = size, h = size }
    size = size - 0.04
    hs.hotkey.bind(mash, key, function() hs.window.focusedWindow():move(unit, nil, true) end)
end
