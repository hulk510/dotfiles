-- ===================================================================
-- Neovim Configuration
-- 軽量で使いやすくかっこいいファイルエディター
-- ===================================================================

-- Leaderキーを設定（他の設定より先に）
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 基本設定を読み込み
require("config.options")
require("config.keymaps")
require("config.autocmds")

-- lazy.nvimを初期化してプラグインを読み込み
require("config.lazy")
