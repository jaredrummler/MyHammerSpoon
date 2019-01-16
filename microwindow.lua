local super = super or { "ctrl", "alt", "cmd" }

hs.loadSpoon("MiroWindowsManager")
hs.window.animationDuration = 0.1

spoon.MiroWindowsManager:bindHotkeys({
    up = { super, "up" },
    right = { super, "right" },
    down = { super, "down" },
    left = { super, "left" },
    fullscreen = { super, "f" }
})
