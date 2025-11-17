-- ===================================================================
-- キーマップ設定
-- ===================================================================

local keymap = vim.keymap.set

-- ===================================================================
-- 基本操作
-- ===================================================================
-- Escでハイライト解除
keymap("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- 保存・終了
keymap("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })
keymap("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })

-- ===================================================================
-- ウィンドウ操作
-- ===================================================================
keymap("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- ウィンドウサイズ変更
keymap("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Increase window height" })
keymap("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Decrease window height" })
keymap("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
keymap("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })

-- ===================================================================
-- バッファ操作
-- ===================================================================
keymap("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
keymap("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next buffer" })
keymap("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })

-- ===================================================================
-- テキスト編集
-- ===================================================================
-- インデント調整（ビジュアルモードで選択を維持）
keymap("v", "<", "<gv", { desc = "Decrease indent" })
keymap("v", ">", ">gv", { desc = "Increase indent" })

-- 行移動
keymap("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
keymap("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- ペースト時にヤンクレジスタを維持
keymap("x", "<leader>p", '"_dP', { desc = "Paste without yanking" })

-- ===================================================================
-- 検索・置換
-- ===================================================================
-- カーソル下の単語を置換
keymap("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace word under cursor" })

-- ===================================================================
-- その他
-- ===================================================================
-- ターミナルモードのEsc
keymap("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- より良いjk移動（折り返し行でも自然に）
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- ===================================================================
-- デバッグ・エラー確認
-- ===================================================================
-- Note: <leader>v* のメッセージ・通知関連は noice.nvim に統合されています
-- <leader>vn: Noice全メッセージ, <leader>vl: 最後のメッセージ, <leader>vh: 履歴, <leader>vd: 全消去

-- ===================================================================
-- トグル機能
-- ===================================================================
-- 自動保存のトグル
keymap("n", "<leader>ta", function()
  if vim.g.auto_save_enabled == nil then
    vim.g.auto_save_enabled = true
  end
  vim.g.auto_save_enabled = not vim.g.auto_save_enabled
  if vim.g.auto_save_enabled then
    vim.notify("Auto-save enabled", vim.log.levels.INFO)
  else
    vim.notify("Auto-save disabled", vim.log.levels.INFO)
  end
end, { desc = "Toggle auto-save" })
