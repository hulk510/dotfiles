-- ===================================================================
-- which-key: キーバインド表示
-- キーを押すと候補が表示されるので迷わない!
-- ===================================================================

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")

    wk.setup({
      preset = "modern",
      delay = 300,
      icons = {
        group = "",
        separator = "➜",
      },
      win = {
        border = "rounded",
      },
    })

    -- キーバインドグループのラベル
    wk.add({
      { "<leader>f", group = "Find (Telescope)" },
      { "<leader>h", group = "Harpoon & Git hunks" },
      { "<leader>b", group = "Buffer" },
      { "<leader>g", group = "Git" },
      { "<leader>l", group = "LSP" },
      { "<leader>s", group = "Search/Replace" },
      { "<leader>c", group = "Copilot" },
      { "<leader>e", desc = "File Explorer" },
      { "<leader>w", desc = "Save file" },
      { "<leader>q", desc = "Quit" },
      { "<leader>m", desc = "Show messages" },
      { "<leader>n", desc = "Notification history" },
    })
  end,
}
