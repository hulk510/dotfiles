-- ===================================================================
-- 初心者向けガイド・ヘルパー
-- ===================================================================

return {
  -- hardtime.nvim: 悪い癖を直す（hjklの連打を防ぐ）
  {
    "m4xshen/hardtime.nvim",
    event = "VeryLazy",
    opts = {
      max_count = 4,  -- 4回までは許容
      disabled_keys = {
        ["<Up>"] = {},  -- 矢印キーは制限しない（初心者用）
        ["<Down>"] = {},
        ["<Left>"] = {},
        ["<Right>"] = {},
      },
      disabled_filetypes = {
        "neo-tree",
        "lazy",
        "mason",
        "oil",
        "dashboard",
        "TelescopePrompt",
        "help",
      },
      hint = true,  -- ヒントを表示
      notification = true,
      allow_different_key = true,
    },
  },

  -- precognition.nvim: 使えるモーション（w, b, e など）をヒント表示
  {
    "tris203/precognition.nvim",
    event = "VeryLazy",
    opts = {
      startVisible = false,  -- デフォルトは非表示（<leader>tpで切り替え）
      showBlankVirtLine = true,
      hints = {
        Caret = { text = "^", prio = 2 },
        Dollar = { text = "$", prio = 1 },
        MatchingPair = { text = "%", prio = 5 },
        Zero = { text = "0", prio = 1 },
        w = { text = "w", prio = 10 },
        b = { text = "b", prio = 9 },
        e = { text = "e", prio = 8 },
        W = { text = "W", prio = 7 },
        B = { text = "B", prio = 6 },
        E = { text = "E", prio = 5 },
      },
      gutterHints = {
        G = { text = "G", prio = 10 },
        gg = { text = "gg", prio = 9 },
        PrevParagraph = { text = "{", prio = 8 },
        NextParagraph = { text = "}", prio = 8 },
      },
    },
    config = function(_, opts)
      require("precognition").setup(opts)
      -- トグルキーマップを追加
      vim.keymap.set("n", "<leader>tp", function()
        require("precognition").toggle()
      end, { desc = "Toggle Precognition (motion hints)" })
    end,
  },

  -- helpview.nvim: ヘルプドキュメントを見やすく
  {
    "OXY2DEV/helpview.nvim",
    ft = "help",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },
}
