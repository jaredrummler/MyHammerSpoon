-- Window management

local super = super or { "ctrl", "alt", "cmd" }

local hotkeys = winmanHotkeys or {
    showDesktop = "-", -- Show a stripe of the desktop
    cascadeAllWindows = ",", -- Cascade all windows
    cascadeAppWindows = ".", -- Cascade windows for the current application
    snapToGrid = "/", -- Snap windows to the grid
    maximizeWindow = ";", -- Expand current window to take up whole grid
}

local cascadeSpacing = 40 -- the visible margin for each window
-- set to 0 to disable cascading

local grid = require "hs.grid"

-- Helper functions

-- Cascade windows
function cascade(windows)
    if #windows <= 1 or cascadeSpacing == 0 then
        return
    end
    local frame = largestFrame(windows)

    local nOfSpaces = #windows - 1

    for i, win in ipairs(windows) do
        local offset = (i - 1) * cascadeSpacing
        local rect = {
            x = frame.x + offset,
            y = frame.y + offset,
            w = frame.w - (nOfSpaces * cascadeSpacing),
            h = frame.h - (nOfSpaces * cascadeSpacing),
        }
        win:setFrame(rect)
    end
    local frame = largestFrame(windows)
end

function cascadeOverlappingWindows(secondPass)
    if cascadeSpacing == 0 then return end
    local allWindows = hs.window.allWindows()
    local cascadedWindows = {}
    local needsSecondPass = false
    for i, win in ipairs(allWindows) do
        local title = win:application():title()
        if title == "Terminal" or title == "MacVim" then
            needsSecondPass = true
        end
        if not cascadedWindows[win:id()] then
            local currentCascading = cascadeWindowsOverlapping(win)
            for x, cascadedWin in ipairs(currentCascading) do
                cascadedWindows[cascadedWin:id()] = true
            end
        end
    end
    -- Some windows take longer to resize and won't be overlapping when this
    -- is first called, so we call it again after one second. Right now I'm
    -- just doing it for MacVim and Terminal.app, but you can add others in
    -- the check up there.
    if needsSecondPass and not secondPass then
        hs.timer.doAfter(1, function() cascadeOverlappingWindows(true) end)
    end
end

function cascadeWindowsOverlapping(winA)
    if cascadeSpacing == 0 then return end
    local windows = hs.window.allWindows()
    local overlappingWindows = { winA }
    local frameA = winA:frame()
    for i, winB in ipairs(windows) do
        local frameB = winB:frame()
        if winA:id() ~= winB:id() and overlaps(frameA, frameB) and
                areCascaded(frameA, frameB) then
            table.insert(overlappingWindows, winB)
        end
    end
    cascade(overlappingWindows)
    return overlappingWindows
end

-- Check for overlapping
function xOverlaps(frameA, frameB)
    local frameAMaxX = maxX(frameA)
    local frameBMaxX = maxX(frameB)
    if frameA.x >= frameB.x and frameA.x <= frameBMaxX then
        return true
    end
    if frameAMaxX >= frameB.x and frameAMaxX <= frameBMaxX then
        return true
    end
    return false
end

function yOverlaps(frameA, frameB)
    local frameAMaxY = maxY(frameA)
    local frameBMaxY = maxY(frameB)
    if frameA.y >= frameB.y and frameA.y <= frameBMaxY then
        return true
    end
    if frameAMaxY >= frameB.y and frameAMaxY <= frameBMaxY then
        return true
    end
    return false
end

function overlaps(frameA, frameB)
    return xOverlaps(frameA, frameB) and yOverlaps(frameA, frameB)
end

function areCascaded(frameA, frameB)
    return math.abs(frameA.w - frameB.w) % cascadeSpacing == 0 and
            math.abs(frameA.h - frameB.h) % cascadeSpacing == 0 and
            math.abs(frameA.x - frameB.x) % cascadeSpacing == 0 and
            math.abs(frameA.y - frameB.y) % cascadeSpacing == 0
end

function maxX(frame)
    return frame.x + frame.w
end

function maxY(win)
    return win.y + win.h
end

function largestFrame(windows)
    local screen = windows[1]:screen():frame()
    local minX = screen.w
    local minY = screen.h
    local maxX = 0
    local maxY = 0
    for i, win in ipairs(windows) do
        local winFrame = win:frame()
        if winFrame.x < minX then
            minX = winFrame.x
        end
        if winFrame.y < minY then
            minY = winFrame.y
        end
    end
    for i, win in ipairs(windows) do
        local winFrame = win:frame()
        local winX = winFrame.x + winFrame.w
        local winY = winFrame.y + winFrame.h
        if winX > maxX then
            maxX = winX
        end
        if winY > maxY then
            maxY = winY
        end
    end
    local width = maxX - minX
    local height = maxY - minY
    return { x = minX, y = minY, w = width, h = height }
end

function getKeys(oldTable)
    local newTable = {}
    for key, value in pairs(oldTable) do
        table.insert(newTable, key)
    end
    return newTable
end

hs.hotkey.bind(super, hotkeys["maximizeWindow"], grid.maximizeWindow)

-- Show and hide a stripe of Desktop
hs.hotkey.bind(super, hotkeys["showDesktop"], function()
    local windows = hs.window.visibleWindows()
    local finished = false
    for i in pairs(windows) do
        local window = windows[i]
        local frame = window:frame()
        local desktop = hs.window.desktop():frame()
        if frame.x + frame.w > desktop.w - 128 and frame ~= desktop then
            frame.w = desktop.w - frame.x - 128
            window:setFrame(frame)
            finished = true
        end
    end
    if finished then return end
    for i in pairs(windows) do
        local window = windows[i]
        local frame = window:frame()
        local desktop = hs.window.desktop():frame()
        if frame.x + frame.w == desktop.w - 128 then
            frame.w = frame.w + 108
            window:setFrame(frame)
        end
    end
end)

-- Snap windows
hs.hotkey.bind(super, hotkeys["snapToGrid"], function()
    local windows = hs.window.visibleWindows()
    for i in pairs(windows) do
        local window = windows[i]
        grid.snap(window)
    end
    -- cascadeOverlappingWindows()
end)

-- Cascade windows
hs.hotkey.bind(super, hotkeys["cascadeAllWindows"], function()
    if cascadeSpacing == 0 then return end
    local windows = hs.window.orderedWindows()
    local screen = windows[1]:screen():frame()
    local nOfSpaces = #windows - 1

    local xMargin = screen.w / 10 -- unused horizontal margin
    local yMargin = 20 -- unused vertical margin

    for i, win in ipairs(windows) do
        local offset = (i - 1) * cascadeSpacing
        local rect = {
            x = xMargin + offset,
            y = screen.y + yMargin + offset,
            w = screen.w - (2 * xMargin) - (nOfSpaces * cascadeSpacing),
            h = screen.h - (2 * yMargin) - (nOfSpaces * cascadeSpacing),
        }
        win:setFrame(rect)
    end
end)

-- Cascade windows for current app
hs.hotkey.bind(super, hotkeys["cascadeAppWindows"], function()
    if cascadeSpacing == 0 then return end
    local windows = hs.window.orderedWindows()
    local focusedApp = hs.window.focusedWindow():application()
    local appWindows = {}
    for i, window in ipairs(windows) do
        if window:application() == focusedApp then
            table.insert(appWindows, window)
        end
    end
    local screen = appWindows[1]:screen():frame()
    local nOfSpaces = #appWindows - 1

    local xMargin = screen.w / 10 -- unused horizontal margin
    local yMargin = 20 -- unused vertical margin

    for i, win in ipairs(appWindows) do
        local offset = (i - 1) * cascadeSpacing
        local rect = {
            x = xMargin + offset,
            y = screen.y + yMargin + offset,
            w = screen.w - (2 * xMargin) - (nOfSpaces * cascadeSpacing),
            h = screen.h - (2 * yMargin) - (nOfSpaces * cascadeSpacing),
        }
        win:setFrame(rect)
    end
end)
