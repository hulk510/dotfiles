-- ===================================================================
-- nvim-cmp: 補完設定
-- VSCode並みの補完体験
-- ===================================================================

return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    -- 補完ソース
    "hrsh7th/cmp-nvim-lsp",     -- LSP（func補完など）
    "hrsh7th/cmp-buffer",       -- バッファ
    "hrsh7th/cmp-path",         -- ファイルパス
    "hrsh7th/cmp-cmdline",      -- コマンドライン

    -- アイコン
    "onsails/lspkind.nvim",
  },
  config = function()
    local cmp = require("cmp")
    local lspkind = require("lspkind")

    cmp.setup({

      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },

      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),

        -- Tab/S-Tabで補完候補を移動
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end, { "i", "s" }),
      }),

      sources = cmp.config.sources({
        { name = "nvim_lsp", priority = 1000 },  -- LSP補完（func等）
        { name = "buffer", priority = 500 },      -- バッファから
        { name = "path", priority = 250 },        -- パス補完
      }),

      formatting = {
        format = lspkind.cmp_format({
          mode = "symbol_text",
          maxwidth = 50,
          ellipsis_char = "...",
          before = function(entry, vim_item)
            return vim_item
          end,
        }),
      },

      experimental = {
        ghost_text = true,  -- 補完候補をゴーストテキストで表示
      },
    })

    -- `/` での検索補完
    cmp.setup.cmdline("/", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })

    -- `:` でのコマンドライン補完（説明付き）
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        {
          name = "cmdline",
          option = {
            ignore_cmds = { "Man", "!" }  -- これらは補完しない
          }
        },
      }),
      formatting = {
        format = lspkind.cmp_format({
          mode = "symbol_text",
          maxwidth = 50,
          menu = {
            cmdline = "[CMD]",
            path = "[PATH]",
          },
        }),
      },
    })
  end,
}
