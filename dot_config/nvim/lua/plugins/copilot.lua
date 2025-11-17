-- ===================================================================
-- GitHub Copilot
-- インライン補完のみ（Agent modeはVSCodeで）
-- ===================================================================

return {
  "github/copilot.vim",
  event = "InsertEnter",
  config = function()
    -- Copilotの設定
    vim.g.copilot_no_tab_map = true
    vim.g.copilot_assume_mapped = true
    vim.g.copilot_filetypes = {
      ["*"] = true,
      gitcommit = false,
      markdown = false,
    }

    -- キーマップ
    -- Tab は nvim-cmp で使うので、Ctrl+J で受け入れ
    vim.keymap.set("i", "<C-J>", 'copilot#Accept("\\<CR>")', {
      expr = true,
      replace_keycodes = false,
      desc = "Copilot: Accept suggestion",
    })

    -- 次/前の候補
    vim.keymap.set("i", "<C-]>", "<Plug>(copilot-next)", { desc = "Copilot: Next suggestion" })
    vim.keymap.set("i", "<C-[>", "<Plug>(copilot-previous)", { desc = "Copilot: Previous suggestion" })

    -- Copilot制御
    vim.keymap.set("n", "<leader>cp", "<cmd>Copilot disable<cr>", { desc = "Copilot: Disable" })
    vim.keymap.set("n", "<leader>ce", "<cmd>Copilot enable<cr>", { desc = "Copilot: Enable" })
    vim.keymap.set("n", "<leader>ci", "<cmd>Copilot status<cr>", { desc = "Copilot: Status" })
  end,
}
