local M = {}
local builtin = require('telescope.builtin')

M.setup = function()
  require('telescope').setup {
    defaults = {
      -- おそらくTelescopeを開いている時の操作のMappingを設定する
      -- mappings = {
      --   i = {
      --     -- map actions.which_key to <C-h> (default: <C-/>)
      --     -- actions.which_key shows the mappings for your picker,
      --     -- e.g. git_{create, delete, ...}_branch for the git_branches picker
      --     ["<C-h>"] = "which_key"
      --   }
      -- }
    },
    pickers = {
      -- Default configuration for builtin pickers goes here:
      -- picker_name = {
      --   picker_config_key = value,
      --   ...
      -- }
      -- Now the picker_config_key will be applied every time you call this
      -- builtin picker
    },
    extensions = {
      -- Your extension configuration goes here:
      -- extension_name = {
      --   extension_config_key = value,
      -- }
      -- please take a look at the readme of the extension you want to configure
    }
  }
end

local is_inside_work_tree = {}

-- プロジェクト内のファイルを検索する（プロジェクトがなければ普通にファイルを検索する）
M.project_files = function()
  local opts = {} -- define here if you want to define something

  local cwd = vim.fn.getcwd()
  if is_inside_work_tree[cwd] == nil then
    vim.fn.system("git rev-parse --is-inside-work-tree")
    is_inside_work_tree[cwd] = vim.v.shell_error == 0
  end

  if is_inside_work_tree[cwd] then
    builtin.git_files(opts)
  else
    builtin.find_files(opts)
  end
end

-- プロジェクト内のファイル内容を検索する（プロジェクトがなければ普通に検索する）
M.project_grep = function()
  local opts = {}

  local cwd = vim.fn.getcwd()
  if is_inside_work_tree[cwd] == nil then
    vim.fn.system("git rev-parse --is-inside-work-tree")
    is_inside_work_tree[cwd] = vim.v.shell_error == 0
  end

  local function get_git_root()
    local dot_git_path = vim.fn.finddir(".git", ".;")
    return vim.fn.fnamemodify(dot_git_path, ":h")
  end

  if is_inside_work_tree[cwd] then
    opts = {
      cwd = get_git_root(),
    }
  end

  builtin.live_grep(opts)
end

return M
