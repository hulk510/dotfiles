-- ===================================================================
-- UI関連プラグイン
-- lualine, snacks, indent-blankline, gitsigns
-- ===================================================================

return {
  -- ===================================================================
  -- lualine: ステータスライン
  -- ===================================================================
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "catppuccin",
          component_separators = { left = "|", right = "|" },
          section_separators = { left = "", right = "" },
          globalstatus = true,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { { "filename", path = 1 } },  -- 相対パス表示
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      })
    end,
  },

  -- ===================================================================
  -- snacks.nvim: モダンなUI拡張（スクロール、通知など）
  -- ===================================================================
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      -- スムーズスクロール
      scroll = {
        enabled = true,
        animate = {
          duration = { step = 15, total = 250 },
          easing = "linear",
        },
      },
      -- 通知
      notifier = {
        enabled = true,
        timeout = 3000,
      },
      -- インデントスコープハイライト
      indent = {
        enabled = true,
        animate = {
          enabled = false,
        },
      },
    },
  },

  -- ===================================================================
  -- indent-blankline: インデントガイド
  -- ===================================================================
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      indent = {
        char = "│",
        tab_char = "│",
      },
      scope = {
        enabled = true,
        show_start = true,
        show_end = false,
      },
      exclude = {
        filetypes = {
          "help",
          "lazy",
          "mason",
          "neo-tree",
        },
      },
    },
  },

  -- ===================================================================
  -- gitsigns: Git差分表示
  -- ===================================================================
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]h", gs.next_hunk, { desc = "Next git hunk" })
        map("n", "[h", gs.prev_hunk, { desc = "Previous git hunk" })

        -- Actions
        map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage hunk" })
        map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset hunk" })
        map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })
        map("n", "<leader>hb", function()
          gs.blame_line({ full = true })
        end, { desc = "Blame line" })
      end,
    },
  },

  -- ===================================================================
  -- nvim-web-devicons: アイコン
  -- ===================================================================
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },
}
