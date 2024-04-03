local M = {}

M.setup = function()
  local builtin = require('telescope.builtin')
  vim.keymap.set('n', '<leader>ff', builtin.find_files, { silent = true })
  vim.keymap.set('n', '<leader>fg', builtin.live_grep, { silent = true })
  vim.keymap.set('n', '<leader>fb', builtin.buffers, { silent = true })
  vim.keymap.set('n', '<leader>fh', builtin.help_tags, { silent = true })
end

return M
