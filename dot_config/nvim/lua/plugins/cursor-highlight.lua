-- ===================================================================
-- カーソルハイライト効果
-- カーソル位置を見やすくする
-- ===================================================================

return {
  -- vim-illuminate: カーソル下の単語と同じものを自動ハイライト
  {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      delay = 100,
      large_file_cutoff = 2000,
      large_file_overrides = {
        providers = { "lsp" },
      },
    },
    config = function(_, opts)
      require("illuminate").configure(opts)
    end,
  },

  -- mini.cursorword: カーソル下の単語をハイライト（シンプル版）
  {
    "echasnovski/mini.cursorword",
    event = "VeryLazy",
    enabled = false, -- vim-illuminateと重複するので無効化
    config = function()
      require("mini.cursorword").setup({
        delay = 100,
      })
    end,
  },
}
