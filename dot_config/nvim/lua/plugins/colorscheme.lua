-- ===================================================================
-- Catppuccin カラースキーム
-- 紫のパステルカラー、モダンでかっこいい!
-- ===================================================================

return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,  -- 他のプラグインより先に読み込み
  config = function()
    require("catppuccin").setup({
      flavour = "mocha",  -- latte, frappe, macchiato, mocha
      transparent_background = false,
      term_colors = true,
      styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        keywords = { "bold" },
      },
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = false,
        neo_tree = true,
        telescope = {
          enabled = true,
        },
        treesitter = true,
        which_key = true,
        harpoon = true,
        mason = true,
        indent_blankline = {
          enabled = true,
          colored_indent_levels = false,
        },
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
          },
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
          },
        },
      },
    })

    -- カラースキームを適用
    vim.cmd.colorscheme("catppuccin")
  end,
}
