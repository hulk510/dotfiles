local M = {}
local builtin = require('telescope.builtin')

M.setup = function()
  -- vim.keymap.set('n', '<leader>ff', builtin.find_files, { silent = true })
  --  vim.keymap.set('n', '<leader>fg', builtin.live_grep, { silent = true })
  vim.keymap.set('n', '<leader>fb', builtin.buffers, { silent = true })
  vim.keymap.set('n', '<leader>fh', builtin.help_tags, { silent = true })
  vim.keymap.set("n", "<Leader><Leader>", "<CMD>lua require'plugins.telescope'.project_files()<CR>",
    { noremap = true, silent = true })
  vim.keymap.set("n", "<Leader>g", "<CMD>lua require'plugins.telescope'.project_grep()<CR>",
    { noremap = true, silent = true })
end

return M
