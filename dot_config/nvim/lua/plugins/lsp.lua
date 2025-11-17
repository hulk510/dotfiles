-- ===================================================================
-- LSP設定
-- Mason + nvim-lspconfig でVSCode並みのLSP体験
-- ===================================================================

return {
  -- Mason: LSPサーバーの自動インストール
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = {
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },

  -- Mason-lspconfig: MasonとLSPconfigの橋渡し
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      -- 自動でインストールするLSP
      ensure_installed = {
        "lua_ls",        -- Lua
        "gopls",         -- Go
        "pyright",       -- Python
        "rust_analyzer", -- Rust
        "ts_ls",         -- TypeScript/JavaScript
        "html",          -- HTML
        "cssls",         -- CSS
        "jsonls",        -- JSON
        "yamlls",        -- YAML
      },
      automatic_installation = true,
    },
  },

  -- LSPConfig: LSPサーバーの設定
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason.nvim",
      "mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local cmp_nvim_lsp = require("cmp_nvim_lsp")

      -- LSP起動時のキーマップ設定
      local on_attach = function(_, bufnr)
        local opts = { buffer = bufnr, silent = true }

        -- キーマップ
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, { buffer = bufnr, desc = "LSP: Rename" })
        vim.keymap.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, { buffer = bufnr, desc = "LSP: Code action" })
        vim.keymap.set("n", "<leader>lf", function()
          vim.lsp.buf.format({ async = true })
        end, { buffer = bufnr, desc = "LSP: Format" })
        vim.keymap.set("n", "<leader>li", "<cmd>LspInfo<cr>", { buffer = bufnr, desc = "LSP: Info" })
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { buffer = bufnr, desc = "Previous diagnostic" })
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { buffer = bufnr, desc = "Next diagnostic" })
        vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, { buffer = bufnr, desc = "Show diagnostic" })
      end

      -- 補完機能の有効化
      local capabilities = cmp_nvim_lsp.default_capabilities()

      -- 診断表示の設定
      vim.diagnostic.config({
        virtual_text = {
          prefix = "●",
        },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          border = "rounded",
          source = "always",
        },
      })

      -- 診断記号の設定
      local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end

      -- LSPサーバーごとの設定
      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
              workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
              },
              telemetry = {
                enable = false,
              },
            },
          },
        },
        ts_ls = {},
        gopls = {
          settings = {
            gopls = {
              analyses = {
                unusedparams = true,
              },
              staticcheck = true,
            },
          },
        },
        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "basic",
              },
            },
          },
        },
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              checkOnSave = {
                command = "clippy",
              },
            },
          },
        },
      }

      -- LSPサーバーを自動セットアップ
      local mason_lspconfig = require("mason-lspconfig")
      local installed_servers = mason_lspconfig.get_installed_servers()

      for _, server_name in ipairs(installed_servers) do
        local server_config = servers[server_name] or {}
        server_config.on_attach = on_attach
        server_config.capabilities = capabilities
        lspconfig[server_name].setup(server_config)
      end
    end,
  },
}
