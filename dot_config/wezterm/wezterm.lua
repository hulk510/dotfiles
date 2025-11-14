local wezterm = require 'wezterm'
local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- フォント設定（Nerd Font対応）
config.font = wezterm.font 'Hack Nerd Font Mono'
config.font_size = 16.0

-- カラースキーム
config.color_scheme = 'tokyonight'

-- タブバー設定
config.hide_tab_bar_if_only_one_tab = true

-- 背景透過度
config.window_background_opacity = 0.9

return config
