require "microwindow"
require "winman"
require "shiftit"
require "applaunch"
require "mocha"

-- reloading
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "R", function()
    hs.reload()
end)
