-- ===================================================================
-- Dashboard: シンプルな起動画面
-- ===================================================================

return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  opts = function()
    local logo = [[
      ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
      ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
      ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
      ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
      ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
      ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
    ]]

    logo = string.rep("\n", 8) .. logo .. "\n\n"

    local opts = {
      theme = "doom",
      hide = {
        statusline = false,
      },
      config = {
        header = vim.split(logo, "\n"),
        center = {
          {
            action = "Telescope find_files",
            desc = " Find File",
            icon = " ",
            key = "f",
          },
          {
            action = "ene | startinsert",
            desc = " New File",
            icon = " ",
            key = "n",
          },
          {
            action = "Telescope oldfiles",
            desc = " Recent Files",
            icon = " ",
            key = "r",
          },
          {
            action = "Telescope live_grep",
            desc = " Find Text",
            icon = " ",
            key = "g",
          },
          {
            action = "e $MYVIMRC",
            desc = " Config",
            icon = " ",
            key = "c",
          },
          {
            action = "Lazy",
            desc = " Lazy",
            icon = " ",
            key = "l",
          },
          {
            action = "qa",
            desc = " Quit",
            icon = " ",
            key = "q",
          },
        },
        footer = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          return {
            "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms",
          }
        end,
      },
    }

    for _, button in ipairs(opts.config.center) do
      button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
      button.key_format = "  %s"
    end

    -- シンプルなカラー設定（アニメーション無し）
    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyVimStarted",
      callback = function()
        vim.cmd("hi DashboardHeader guifg=#cba6f7 gui=bold") -- パープル
        vim.cmd("hi DashboardCenter guifg=#89b4fa gui=bold") -- ブルー
        vim.cmd("hi DashboardFooter guifg=#94e2d5 gui=italic") -- シアン
        vim.cmd("hi DashboardShortCut guifg=#f38ba8") -- ピンク
        vim.cmd("hi DashboardDesc guifg=#a6e3a1") -- グリーン
        vim.cmd("hi DashboardIcon guifg=#fab387") -- オレンジ
        vim.cmd("hi DashboardKey guifg=#f9e2af") -- イエロー
      end,
    })

    return opts
  end,
  dependencies = { "nvim-tree/nvim-web-devicons" },
}
