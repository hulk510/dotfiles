-- ===================================================================
-- 初心者に優しい機能
-- ===================================================================

return {
  -- trouble.nvim: エラー・警告を見やすく一覧表示
  {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    opts = {},
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
      { "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions / references / ... (Trouble)" },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
    },
  },

  -- nvim-colorizer: 色コードを実際の色で表示
  {
    "norcalli/nvim-colorizer.lua",
    event = "BufReadPre",
    config = function()
      require("colorizer").setup({
        "*", -- すべてのファイルタイプで有効
      }, {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        names = true, -- "red", "blue"などの色名
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        css = true, -- Enable all CSS features
        css_fn = true, -- Enable all CSS *functions*
      })
    end,
  },

  -- nvim-ufo: コード折りたたみを見やすく
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    event = "BufReadPost",
    opts = {
      provider_selector = function()
        return { "treesitter", "indent" }
      end,
    },
    config = function(_, opts)
      require("ufo").setup(opts)
      vim.o.foldcolumn = "1"
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      -- キーマップ
      vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "Open all folds" })
      vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "Close all folds" })
    end,
  },

  -- better-escape.nvim: jjでノーマルモードに戻る
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    opts = {
      mapping = { "jj", "jk" }, -- jj または jk でノーマルモードに
      timeout = 200,
      clear_empty_lines = false,
      keys = "<Esc>",
    },
  },

  -- vim-matchup: %で対応する括弧にジャンプ（拡張版）
  {
    "andymass/vim-matchup",
    event = "BufReadPost",
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },

  -- dressing.nvim: vim.ui.select と vim.ui.input を綺麗に
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = {
      input = {
        enabled = true,
        default_prompt = "Input:",
        border = "rounded",
      },
      select = {
        enabled = true,
        backend = { "telescope", "builtin" },
        builtin = {
          border = "rounded",
        },
      },
    },
  },

  -- nvim-notify: 通知を綺麗に表示（snacksと統合）
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    opts = {
      timeout = 3000,
      background_colour = "#000000",
      render = "compact",
      stages = "fade",
      top_down = false,
    },
    config = function(_, opts)
      local notify = require("notify")
      notify.setup(opts)
      vim.notify = notify
    end,
  },

  -- mini.move: 選択したテキストを上下左右に移動
  {
    "echasnovski/mini.move",
    event = "VeryLazy",
    opts = {
      mappings = {
        -- ビジュアルモードで Alt+hjkl で移動
        left = "<M-h>",
        right = "<M-l>",
        down = "<M-j>",
        up = "<M-k>",

        -- 通常モードで行を移動
        line_left = "<M-h>",
        line_right = "<M-l>",
        line_down = "<M-j>",
        line_up = "<M-k>",
      },
    },
  },
}
