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

-- フォーカスを失った時に自動保存（デフォルトオフ）
-- <leader>ta でトグル可能
vim.g.auto_save_enabled = false  -- デフォルトはオフ

autocmd("FocusLost", {
  group = augroup("auto_save", { clear = true }),
  pattern = "*",
  callback = function()
    if not vim.g.auto_save_enabled then
      return  -- 自動保存が無効なら何もしない
    end
    if vim.bo.modified and not vim.bo.readonly and vim.fn.expand("%") ~= "" and vim.bo.buftype == "" then
      vim.cmd("silent! write")
      vim.notify("Auto-saved", vim.log.levels.INFO)
    end
  end,
})

-- ===================================================================
-- 透過設定 & ネオンBorder
-- ===================================================================
-- カラースキーム読み込み後に透過とネオンカラーを適用
autocmd("ColorScheme", {
  group = augroup("transparent_background", { clear = true }),
  callback = function()
    -- 背景透過
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
    vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
    vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })

    -- Telescope背景透過
    vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
    vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "none", fg = "#89b4fa" }) -- ネオンブルー
    vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = "none" })
    vim.api.nvim_set_hl(0, "TelescopePromptBorder", { bg = "none", fg = "#cba6f7" }) -- ネオンパープル
    vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = "none" })
    vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { bg = "none", fg = "#89b4fa" })
    vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = "none" })
    vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { bg = "none", fg = "#89b4fa" })

    -- Which-key背景透過
    vim.api.nvim_set_hl(0, "WhichKeyFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "WhichKeyBorder", { bg = "none", fg = "#f38ba8" }) -- ネオンピンク

    -- CMP背景透過
    vim.api.nvim_set_hl(0, "CmpNormal", { bg = "none" })
    vim.api.nvim_set_hl(0, "CmpBorder", { bg = "none", fg = "#94e2d5" }) -- ネオンシアン
    vim.api.nvim_set_hl(0, "Pmenu", { bg = "none" })
    vim.api.nvim_set_hl(0, "PmenuBorder", { bg = "none", fg = "#94e2d5" })

    -- Neo-tree背景透過
    vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "none" })
    vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { bg = "none" })

    -- Notifyなど他のフローティングウィンドウ
    vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none", fg = "#f9e2af" }) -- ネオンイエロー
  end,
})

-- VimEnter時にも適用（確実に反映）
autocmd("VimEnter", {
  group = augroup("transparent_on_enter", { clear = true }),
  callback = function()
    vim.cmd("doautocmd ColorScheme")
  end,
})
