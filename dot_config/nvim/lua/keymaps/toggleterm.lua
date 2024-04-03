local M = {}

M.setup = function()
  -- TermEnterイベントでのキーマッピングを設定
  vim.api.nvim_create_autocmd("TermEnter", {
    pattern = "term://*toggleterm#*",
    callback = function()
      vim.keymap.set('t', '<C-t>', '<Cmd>exe v:count1 . "ToggleTerm"<CR>', {silent = true})
    end,
  })

  -- ノーマルモードとインサートモードでのキーマッピング
  vim.keymap.set('n', '<C-t>', '<Cmd>exe v:count1 . "ToggleTerm"<CR>', {silent = true})
  vim.keymap.set('i', '<C-t>', '<Esc><Cmd>exe v:count1 . "ToggleTerm"<CR>', {silent = true})
end

return M
