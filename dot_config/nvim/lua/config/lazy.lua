-- ===================================================================
-- lazy.nvim ブートストラップ & 設定
-- ===================================================================

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- lazy.nvimが存在しない場合はクローン
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

-- ===================================================================
-- プラグイン読み込み
-- ===================================================================
require("lazy").setup({
  spec = {
    -- lua/plugins/ 配下の全てのファイルを自動読み込み
    { import = "plugins" },
  },
  defaults = {
    lazy = false,  -- デフォルトは遅延読み込みしない
    version = false,  -- 最新のgit commitを使用
  },
  checker = {
    enabled = true,  -- 自動更新チェック
    notify = false,  -- 通知は無効
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  ui = {
    border = "rounded",  -- ウィンドウボーダー
    icons = {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      require = "🌙",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤 ",
    },
  },
})
