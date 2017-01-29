hs.window.animationDuration = 0

function reloadConfig(files)
    hs.reload()
end
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()

local bindKey  = hs.hotkey.bind
local cmd      = hs.fnutils.partial(bindKey, {"cmd"})
local cmdShift = hs.fnutils.partial(bindKey, {"cmd", "shift"})

cmdShift('r', reloadConfig)

function focusTo(direction)
  hs.window['focusWindow' .. direction](hs.window.focusedWindow() or hs.window.desktop())
end

cmd('k',  function () focusTo('North') end)
cmd('up', function () focusTo('North') end)

cmd('j',    function () focusTo('South') end)
cmd('down', function () focusTo('South') end)

cmd('h',    function () focusTo('West') end)
cmd('left', function () focusTo('West') end)

cmd('l',     function () focusTo('East') end)
cmd('right', function () focusTo('East') end)

cmdShift('up', function () hs.window.focusedWindow():maximize() end)

