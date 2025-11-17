-- ===================================================================
-- Telescope: ファジーファインダー
-- ファイル、テキスト検索など超便利!
-- ===================================================================

return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
    "nvim-tree/nvim-web-devicons",
  },
  cmd = "Telescope",
  keys = {
    -- ファイル検索
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
    { "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "Find word under cursor" },

    -- バッファ・ヘルプ
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find buffers" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
    { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },

    -- Git
    { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Git commits" },
    { "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "Git status" },

    -- LSP (後でLSP設定時に使う)
    { "<leader>ld", "<cmd>Telescope lsp_definitions<cr>", desc = "LSP definitions" },
    { "<leader>lr", "<cmd>Telescope lsp_references<cr>", desc = "LSP references" },
    { "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document symbols" },
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        prompt_prefix = " 🔍 ",
        selection_caret = " ➜ ",
        path_display = { "truncate" },
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        mappings = {
          i = {
            ["<C-n>"] = actions.cycle_history_next,
            ["<C-p>"] = actions.cycle_history_prev,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-c>"] = actions.close,
            ["<CR>"] = actions.select_default,
            ["<C-x>"] = actions.select_horizontal,
            ["<C-v>"] = actions.select_vertical,
            ["<C-u>"] = actions.preview_scrolling_up,
            ["<C-d>"] = actions.preview_scrolling_down,
          },
          n = {
            ["q"] = actions.close,
            ["<CR>"] = actions.select_default,
            ["<C-x>"] = actions.select_horizontal,
            ["<C-v>"] = actions.select_vertical,
          },
        },
      },
      pickers = {
        find_files = {
          find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
    })

    -- fzf拡張を読み込み
    telescope.load_extension("fzf")
  end,
}
