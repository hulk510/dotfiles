-- ===================================================================
-- conform.nvim: 高速で柔軟なフォーマッター
-- 言語ごとに最適なフォーマッターを自動実行
-- ===================================================================

return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>lf",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = { "n", "v" },
      desc = "Format buffer",
    },
  },
  opts = {
    -- 言語ごとのフォーマッター設定
    formatters_by_ft = {
      -- Lua
      lua = { "stylua" },

      -- Python
      python = { "isort", "black" },

      -- JavaScript/TypeScript (biome優先、なければprettier)
      javascript = { "biome", "prettier", stop_after_first = true },
      typescript = { "biome", "prettier", stop_after_first = true },
      javascriptreact = { "biome", "prettier", stop_after_first = true },
      typescriptreact = { "biome", "prettier", stop_after_first = true },

      -- Web
      html = { "prettier" },
      css = { "prettier" },
      scss = { "prettier" },
      json = { "prettier" },
      jsonc = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },

      -- Go
      go = { "gofumpt", "goimports" },

      -- Rust
      rust = { "rustfmt" },

      -- Shell
      sh = { "shfmt" },
      bash = { "shfmt" },

      -- その他
      toml = { "taplo" },
    },

    -- フォーマッター設定のカスタマイズ
    formatters = {
      shfmt = {
        prepend_args = { "-i", "2" }, -- インデント2スペース
      },
    },

    -- デフォルトオプション
    default_format_opts = {
      lsp_fallback = true, -- フォーマッターがない場合はLSPを使用
    },

    -- 保存時に自動フォーマット（無効化推奨、手動で<leader>lfを使う）
    format_on_save = nil,
    -- もし自動フォーマットを有効にしたい場合は以下のコメントを外す:
    -- format_on_save = {
    --   timeout_ms = 500,
    --   lsp_fallback = true,
    -- },

    -- フォーマットが適用されたときの通知
    notify_on_error = true,
  },
  init = function()
    -- :FormatInfo コマンドを追加
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

    -- gq でもconformを使用
    vim.api.nvim_create_user_command("FormatEnable", function()
      vim.b.disable_autoformat = false
      vim.notify("Format on save enabled", vim.log.levels.INFO)
    end, {
      desc = "Enable format on save",
    })

    vim.api.nvim_create_user_command("FormatDisable", function()
      vim.b.disable_autoformat = true
      vim.notify("Format on save disabled", vim.log.levels.INFO)
    end, {
      desc = "Disable format on save",
    })
  end,
}
