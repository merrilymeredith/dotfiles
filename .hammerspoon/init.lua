hs.fs.chdir(os.getenv("HOME"))
hs.window.animationDuration = 0

-- aliases and partial bindings to make life easier
local bindKey  = hs.hotkey.bind
local cmd      = hs.fnutils.partial(bindKey, {"cmd"})
local cmdShift = hs.fnutils.partial(bindKey, {"cmd", "shift"})
local cmdCtrl  = hs.fnutils.partial(bindKey, {"cmd", "ctrl"})

function focusedWindow()
  return hs.window.focusedWindow() or hs.window.desktop()
end

function focusTo(direction)
  local fn = hs.getObjectMetatable('hs.window')['focusWindow' .. direction]
  return function ()
    fn(focusedWindow(), nil, nil, true)
  end
end

function findOrLaunch(a)
  return hs.application.find(a) or hs.application.open(a, 3)
end

-- and the key bindings
cmdShift('r', hs.reload)

cmd('k',  focusTo('North'))
cmd('up', focusTo('North'))

cmd('j',    focusTo('South'))
cmd('down', focusTo('South'))

cmd('h',    focusTo('West'))
cmd('left', focusTo('West'))

cmd('l',     focusTo('East'))
cmd('right', focusTo('East'))

cmdShift('up', function () focusedWindow():maximize() end)

cmdShift('down', function () focusedWindow():minimize() end)

cmdShift('left',  function () focusedWindow():moveToUnit(hs.layout.left50) end)
cmdShift('right', function () focusedWindow():moveToUnit(hs.layout.right50) end)

cmdCtrl('left',  function () focusedWindow():moveOneScreenWest() end)
cmdCtrl('right', function () focusedWindow():moveOneScreenEast() end)

cmd('return', function ()
  local a = findOrLaunch('iTerm2')
  a:selectMenuItem({"Shell", "New Window"})
  a:activate()
end)

cmdShift('return', function ()
  os.execute(os.getenv('SHELL')..' -l -i -c "goneovim &>/dev/null &"')
end)
