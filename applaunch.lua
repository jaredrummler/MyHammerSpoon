local mashApps = { "cmd", "alt" }
local apps = {
    { key = "a", app = "Android Studio" },
    { key = "c", app = "Google Chrome" },
    { key = "s", app = "Slack" },
    { key = "t", app = "iTerm" },
    { key = "f", app = "Finder" },
    { key = "i", app = "IntelliJ IDEA Ultimate" },
    { key = "p", app = "Spotify" }
}

local ext = {
    cache = {}
}

function forceLaunchOrFocus(appName)
    -- first focus with hammerspoon
    hs.application.launchOrFocus(appName)

    -- clear timer if exists
    if ext.cache.launchTimer then ext.cache.launchTimer:stop() end

    -- wait 500ms for window to appear and try hard to show the window
    ext.cache.launchTimer = hs.timer.doAfter(0.5, function()
        local frontmostApp = hs.application.frontmostApplication()
        local frontmostWindows = hs.fnutils.filter(frontmostApp:allWindows(), function(win) return win:isStandard() end)

        -- break if this app is not frontmost (when/why?)
        if frontmostApp:title() ~= appName then
            print('Expected app in front: ' .. appName .. ' got: ' .. frontmostApp:title())
            return
        end

        if #frontmostWindows == 0 then
            -- check if there's app name in window menu (Calendar, Messages, etc...)
            if frontmostApp:findMenuItem({ 'Window', appName }) then
                -- select it, usually moves to space with this window
                frontmostApp:selectMenuItem({ 'Window', appName })
            else
                -- otherwise send cmd-n to create new window
                hs.eventtap.keyStroke({ 'cmd' }, 'n')
            end
        end
    end)
end

hs.fnutils.each(apps, function(object)
    hs.hotkey.bind(mashApps, object.key, function() forceLaunchOrFocus(object.app) end)
end)
