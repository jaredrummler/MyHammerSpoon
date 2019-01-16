
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
    { key = ']', unit = { x = 0.00, y = 0.50, w = 1.00, h = 0.50 } }, -- bottom 50 width
    { key = '1', unit = { x = 0.00, y = 0.00, w = 1.00, h = 1.00 } }, -- center - width = 1.00
    { key = '2', unit = { x = 0.02, y = 0.02, w = 0.96, h = 0.96 } }, -- center - width = 0.96
    { key = '3', unit = { x = 0.04, y = 0.04, w = 0.92, h = 0.92 } }, -- center - width = 0.92
    { key = '4', unit = { x = 0.06, y = 0.06, w = 0.88, h = 0.88 } }, -- center - width = 0.88
    { key = '5', unit = { x = 0.08, y = 0.08, w = 0.84, h = 0.84 } }, -- center - width = 0.84
    { key = '6', unit = { x = 0.10, y = 0.10, w = 0.80, h = 0.80 } }, -- center - width = 0.80
    { key = '7', unit = { x = 0.12, y = 0.12, w = 0.76, h = 0.76 } }, -- center - width = 0.76
    { key = '8', unit = { x = 0.14, y = 0.14, w = 0.72, h = 0.72 } }, -- center - width = 0.72
    { key = '9', unit = { x = 0.16, y = 0.16, w = 0.68, h = 0.68 } }, -- center - width = 0.68
    { key = '0', unit = { x = 0.18, y = 0.18, w = 0.64, h = 0.64 } }, -- center - width = 0.64
}

local mash = { 'ctrl', 'alt', 'cmd' }

for i, unit in ipairs(units) do
    hs.hotkey.bind(mash, unit.key, function() hs.window.focusedWindow():move(unit.unit, nil, true) end)
end
