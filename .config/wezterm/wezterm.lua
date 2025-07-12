local wezterm = require 'wezterm'
local c = wezterm.config_builder()

local is_windows = wezterm.target_triple:match("windows")

c.font = wezterm.font_with_fallback {
  'DejaVu Sans Mono',
  'Cascadia Code',
  'Consolas',
  'Menlo',
}
c.font_size = 10.0
c.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }
c.freetype_load_target = "Light"

c.animation_fps = 1
c.cursor_blink_ease_in = 'Constant'
c.cursor_blink_ease_out = 'Constant'

c.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

c.window_padding = { left = 7, right = 7, top = 7, bottom = 7 }
c.initial_cols, c.initial_rows = 120, 35

if is_windows then
  -- c.default_prog = { 'pwsh.exe' }
  -- So WSL always breaks window focus on start, both windows terminal and wezterm
  c.default_prog = { 'wsl.exe', '--cd', '~' }

  c.launch_menu = {
    { label = 'pwsh',     args = { 'pwsh.exe' } },
    { label = 'cmd',      args = { 'cmd.exe' } },
    { label = "wsl nvim", args = { "wsl.exe", "--cd", "~", "nvim" } },
  }

  -- on Intel Iris Xe graphics, there's artifacting unless you use `prefer_egl`
  -- or `front_end = "WebGpu"`.  WebGpu renders fonts too heavy though.
  -- Also, I think prefer_egl is the -intended- default?
  c.prefer_egl = true
end

local ok, wezterm_local = pcall(require, "wezterm_local")
if ok then
  wezterm_local.apply(c)
end

return c
