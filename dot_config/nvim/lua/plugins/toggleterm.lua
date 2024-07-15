local M = {}

M.setup = function()
  require("toggleterm").setup {
    direction = 'float'
  }
end

return M
