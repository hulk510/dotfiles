-- ===================================================================
-- IME (日本語入力) 自動制御
-- ノーマルモードに戻る時に自動でIMEをオフにする
-- 外部ツール不要（macOS標準機能を使用）
-- ===================================================================

return {
  -- ime-auto.nvim: 外部ツール不要でIMEを自動制御
  {
    "shabaraba/ime-auto.nvim",
    event = "InsertEnter",
    config = function()
      require("ime-auto").setup({
        -- エスケープシーケンスは無効化（jjは使いにくい）
        escape_sequence = "",    -- 無効化
        escape_timeout = 200,
        os = "macos",            -- macOSを明示的に指定
        ime_method = "builtin",  -- OS標準機能を使用（外部ツール不要）
        debug = false,
      })
    end,
  },
}
