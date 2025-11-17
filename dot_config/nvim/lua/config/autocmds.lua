-- ===================================================================
-- 自動コマンド
-- ===================================================================

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- ===================================================================
-- ハイライト
-- ===================================================================
-- ヤンク時にハイライト
autocmd("TextYankPost", {
  group = augroup("highlight_yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})

-- ===================================================================
-- ファイルタイプ設定
-- ===================================================================
-- 特定のファイルタイプでのインデント設定
autocmd("FileType", {
  pattern = { "go", "python" },
  group = augroup("custom_indent", { clear = true }),
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
  end,
})

-- ===================================================================
-- ウィンドウ・バッファ
-- ===================================================================
-- ファイルを開いた時に最後のカーソル位置に戻る
autocmd("BufReadPost", {
  group = augroup("last_cursor_position", { clear = true }),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- ターミナルで挿入モードで開始
autocmd("TermOpen", {
  group = augroup("custom_term", { clear = true }),
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.cmd("startinsert")
  end,
})

-- フォーカスを失った時に自動保存
autocmd({ "FocusLost", "BufLeave" }, {
  group = augroup("auto_save", { clear = true }),
  pattern = "*",
  callback = function()
    if vim.bo.modified and not vim.bo.readonly and vim.fn.expand("%") ~= "" and vim.bo.buftype == "" then
      vim.cmd("silent! write")
    end
  end,
})
