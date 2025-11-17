-- ===================================================================
-- 編集効率化プラグイン
-- Treesitter, Flash, Surround, Autopairs, Comment, TODO
-- ===================================================================

return {
  -- ===================================================================
  -- Treesitter: シンタックスハイライト & テキストオブジェクト
  -- ===================================================================
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "lua",
          "vim",
          "vimdoc",
          "query",
          "javascript",
          "typescript",
          "tsx",
          "go",
          "python",
          "rust",
          "html",
          "css",
          "json",
          "yaml",
          "markdown",
          "markdown_inline",
          "bash",
          "diff",  -- Telescope git差分表示用
        },
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = false,
            node_decremental = "<bs>",
          },
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]f"] = "@function.outer",
              ["]c"] = "@class.outer",
            },
            goto_previous_start = {
              ["[f"] = "@function.outer",
              ["[c"] = "@class.outer",
            },
          },
        },
      })
    end,
  },

  -- ===================================================================
  -- Flash: 画面内高速ジャンプ
  -- ===================================================================
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      modes = {
        char = {
          enabled = false,  -- f/F/t/T は通常動作
        },
      },
    },
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash: Jump",
      },
      {
        "S",
        mode = { "n", "x", "o" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash: Treesitter",
      },
    },
  },

  -- ===================================================================
  -- nvim-surround: 囲み文字操作
  -- ===================================================================
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end,
  },

  -- ===================================================================
  -- mini.ai: テキストオブジェクト拡張
  -- ===================================================================
  {
    "echasnovski/mini.ai",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("mini.ai").setup({
        n_lines = 500,
      })
    end,
  },

  -- ===================================================================
  -- nvim-autopairs: 自動括弧補完
  -- ===================================================================
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      local autopairs = require("nvim-autopairs")
      autopairs.setup({
        check_ts = true,  -- Treesitterと連携
        fast_wrap = {},
      })

      -- cmpと連携
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },

  -- ===================================================================
  -- Comment.nvim: コメントトグル
  -- ===================================================================
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    opts = {},
  },

  -- ===================================================================
  -- todo-comments: TODOハイライト
  -- ===================================================================
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      signs = true,
      keywords = {
        FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
      },
    },
    keys = {
      {
        "]t",
        function()
          require("todo-comments").jump_next()
        end,
        desc = "Next TODO",
      },
      {
        "[t",
        function()
          require("todo-comments").jump_prev()
        end,
        desc = "Previous TODO",
      },
      {
        "<leader>ft",
        "<cmd>TodoTelescope<cr>",
        desc = "Find TODOs",
      },
    },
  },
}
