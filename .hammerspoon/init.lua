hs.window.animationDuration = 0

function reloadConfig(files)
    hs.reload()
end
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()

local bindKey  = hs.hotkey.bind
local cmd      = hs.fnutils.partial(bindKey, {"cmd"})
local cmdShift = hs.fnutils.partial(bindKey, {"cmd", "shift"})
local cmdCtrl  = hs.fnutils.partial(bindKey, {"cmd", "ctrl"})

cmdShift('r', reloadConfig)

function focusedWindow() return hs.window.focusedWindow() or hs.window.desktop() end
function focusTo(direction) hs.window['focusWindow' .. direction](focusedWindow()) end

cmd('k',  function () focusTo('North') end)
cmd('up', function () focusTo('North') end)

cmd('j',    function () focusTo('South') end)
cmd('down', function () focusTo('South') end)

cmd('h',    function () focusTo('West') end)
cmd('left', function () focusTo('West') end)

cmd('l',     function () focusTo('East') end)
cmd('right', function () focusTo('East') end)

cmdShift('up', function () focusedWindow():maximize() end)

cmdShift('down', function () focusedWindow():minimize() end)

cmdShift('left',  function () focusedWindow():moveToUnit(hs.layout.left50) end)
cmdShift('right', function () focusedWindow():moveToUnit(hs.layout.right50) end)

cmdCtrl('left',  function () focusedWindow():moveOneScreenWest() end)
cmdCtrl('right', function () focusedWindow():moveOneScreenEast() end)

cmd('return', function ()
  hs.applescript.applescript([[
    tell application "iTerm2"
      create window with default profile
    end tell
  ]])
end)

