super = { "cmd", "alt", "ctrl" }

require "microwindow"
require "winman"
require "shiftit"
require "applaunch"
require "mocha"

-- Toggle full screen
hs.hotkey.bind(super, "t", function()
    if hs.window.focusedWindow() then
        hs.window.frontmostWindow():toggleZoom()
    end
end)

-- reloading
hs.hotkey.bind(super, "r", function()
    hs.reload()
end)
