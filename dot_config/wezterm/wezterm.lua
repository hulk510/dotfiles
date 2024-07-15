-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices
config.font = wezterm.font 'Fira Code'
config.font_size = 16.0

-- For example, changing the color scheme:
config.color_scheme = 'tokyonight'

-- 一つのタブだったらtab_barを表示しない。
config.hide_tab_bar_if_only_one_tab = true
-- 背景の透過度
 config.window_background_opacity = 0.9
-- config.background = {
--  {
--    opacity = 0.5
--  }
-- }
-- and finally, return the configuration to wezterm
return config
