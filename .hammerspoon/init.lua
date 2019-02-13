hs.window.animationDuration = 0

-- set up reload on modify
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", hs.reload):start()

-- aliases and partial bindings to make life easier
local bindKey  = hs.hotkey.bind
local cmd      = hs.fnutils.partial(bindKey, {"cmd"})
local cmdShift = hs.fnutils.partial(bindKey, {"cmd", "shift"})
local cmdCtrl  = hs.fnutils.partial(bindKey, {"cmd", "ctrl"})

function focusedWindow() return hs.window.focusedWindow() or hs.window.desktop() end
function focusTo(direction) hs.window['focusWindow' .. direction](focusedWindow()) end

-- and the key bindings
cmdShift('r', hs.reload)

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
    tell application "iTerm"
      set newterm to index of (create window with default profile)
      tell application "System Events" to tell process "iTerm2"
        perform action "AXRaise" of window newterm
      end tell
    end tell
  ]])
end)

cmdShift('return', function ()
  os.execute(os.getenv('SHELL')..' -l -i -c "exec mvim"')
end)

-- cache window frames before moving?
-- save cache?
-- focus by direction is a little strict

