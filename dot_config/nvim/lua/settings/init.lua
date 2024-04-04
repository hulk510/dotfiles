-- 行番号の表示
vim.opt.number = true

-- leader key
-- Spaceキーをリーダーキーにする（デフォルトはバックスラッシュ）
vim.g.mapleader = ' '

-- 動かない
vim.opt.helplang = 'ja'

-- 未保存でも他のファイルを開けるように
vim.opt.hidden = true

-- タブ挿入時の空白数
-- MEMO: これってprettierとかでtabsize決めてる時はどうなるのか？
vim.opt.tabstop = 2

-- 行挿入時の空白数
vim.opt.shiftwidth = 2

-- タブ挿入時に半角スペースにする
vim.opt.expandtab = true

-- インデントを揃える（新しい行の挿入時）
vim.opt.autoindent = true
vim.opt.list = true
vim.opt.listchars = { tab = '▸\\-', trail = '·', extends = '>', precedes = '<', nbsp = '·' }

-- マウスのコピー等をどのモードでも動かせるように
vim.opt.mouse = 'a'

-- clipboardにコピペできるようにする
vim.opt.clipboard:append("unnamedplus")

vim.opt.relativenumber = true
vim.opt.signcolumn = 'yes' 
vim.opt.cursorline = true

