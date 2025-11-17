-- ===================================================================
-- noice.nvim: 超かっこいいUI
-- コマンドライン、メッセージ、通知をモダンに
-- ===================================================================

return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  opts = {
    lsp = {
      -- LSPのドキュメントをnoiceでオーバーライド
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
      -- ホバー、シグネチャヘルプを綺麗に
      hover = {
        enabled = true,
      },
      signature = {
        enabled = true,
        auto_open = {
          enabled = true,
          trigger = true,
          luasnip = false, -- スニペットは使わない
          throttle = 50,
        },
      },
    },
    -- プリセット：かっこいいコマンドライン、ポップアップメニュー
    presets = {
      bottom_search = true, -- 検索を画面下部に
      command_palette = true, -- コマンドパレット風
      long_message_to_split = true, -- 長いメッセージは分割
      inc_rename = false, -- LSP renameは無効（標準のまま）
      lsp_doc_border = true, -- LSPドキュメントにボーダー
    },
    -- コマンドラインの設定
    cmdline = {
      enabled = true,
      view = "cmdline_popup", -- ポップアップ表示
      format = {
        cmdline = { pattern = "^:", icon = "", lang = "vim" },
        search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
        search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
        filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
        lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
        help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
      },
    },
    -- メッセージの設定
    messages = {
      enabled = true,
      view = "notify", -- 右上に通知として表示
      view_error = "notify",
      view_warn = "notify",
      view_history = "messages", -- :messages で履歴表示
      view_search = "virtualtext", -- 検索結果を仮想テキストで
    },
    -- ポップオーバーの設定
    popupmenu = {
      enabled = true,
      backend = "nui", -- "nui" または "cmp"
    },
    -- 通知の設定
    notify = {
      enabled = true,
      view = "notify",
    },
    -- ルーティング: 特定のメッセージを非表示に
    routes = {
      {
        filter = {
          event = "msg_show",
          kind = "",
          find = "written",
        },
        opts = { skip = true }, -- "written" メッセージを非表示
      },
      {
        filter = {
          event = "msg_show",
          kind = "",
          find = "more lines",
        },
        opts = { skip = true }, -- "X more lines" を非表示
      },
      {
        filter = {
          event = "msg_show",
          kind = "",
          find = "fewer lines",
        },
        opts = { skip = true }, -- "X fewer lines" を非表示
      },
    },
    -- ビューの設定
    views = {
      cmdline_popup = {
        position = {
          row = "50%", -- 画面中央
          col = "50%",
        },
        size = {
          width = 60,
          height = "auto",
        },
        border = {
          style = "rounded",
          padding = { 0, 1 },
        },
        win_options = {
          winhighlight = {
            Normal = "Normal",
            FloatBorder = "DiagnosticInfo",
          },
        },
      },
      popupmenu = {
        relative = "editor",
        position = {
          row = "50%",
          col = "50%",
        },
        size = {
          width = 60,
          height = 10,
        },
        border = {
          style = "rounded",
          padding = { 0, 1 },
        },
        win_options = {
          winhighlight = {
            Normal = "Normal",
            FloatBorder = "DiagnosticInfo",
          },
        },
      },
    },
  },
  keys = {
    { "<leader>vn", "<cmd>Noice<cr>", desc = "Noice Messages" },
    { "<leader>vl", "<cmd>Noice last<cr>", desc = "Noice Last Message" },
    { "<leader>vh", "<cmd>Noice history<cr>", desc = "Noice History" },
    { "<leader>vd", "<cmd>Noice dismiss<cr>", desc = "Dismiss All" },
  },
}
