return {
  {
    "williamboman/mason.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
      "b0o/schemastore.nvim",
      "nvim-telescope/telescope.nvim",
      "folke/trouble.nvim",
    },
    config = function()
      local mason = require("mason")
      local mason_tool_installer = require("mason-tool-installer")
      local lspconfig = require("lspconfig")
      local cmp_nvim_lsp = require("cmp_nvim_lsp")
      local schemastore = require("schemastore")

      local capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())

      mason.setup({
        ui = {
          border = "rounded",
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
          }
        }
      })

      mason_tool_installer.setup({
        ensure_installed = {
          "terraform-ls",
          "json-lsp",
          "bash-language-server",
          "vim-language-server",
          "pyright",

          "prettier",
          "stylua",
          "tflint",
          "tfsec",
        }
      })

      lspconfig.terraformls.setup({
        capabilities = capabilities,
        filetypes = { "terraform", "terraform-vars" },
        root_dir = lspconfig.util.root_pattern(".terraform", ".git"),
        single_file_support = true,
      })

      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT',
            },
            diagnostics = {
              globals = { 'vim' },
            },
            workspace = {
              checkThirdParty = false,
              library = vim.api.nvim_get_runtime_file("", true)
            },
            completion = { callSnippet = "Replace" }
          }
        }
      })

      lspconfig.jsonls.setup({
        capabilities = capabilities,
        settings = {
          json = {
            schemas = schemastore.json.schemas(),
            validate = { enable = true }
          }
        }
      })

      lspconfig.bashls.setup({
        capabilities = capabilities,
      })

      lspconfig.vimls.setup({
        capabilities = capabilities,
      })

      lspconfig.pyright.setup({
        capabilities = capabilities,
      })

      pcall(function()
        lspconfig.solidity_ls_nomicfoundation.setup({
          capabilities = capabilities,
        })
      end)

      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        update_in_insert = false,
        underline = true,
        severity_sort = true,
        float = {
          focusable = false,
          style = "minimal",
          border = "rounded",
          source = "if_many",
          header = "",
          prefix = "",
        }
      })

      local signs = {
        Error = "󰊨",
        Warn = "󰝦",
        Hint = "󰈧",
        Info = "󰉉"
      }

      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end
    end,
    keys = {
      -- LSP Actions
      { "<leader>la", vim.lsp.buf.code_action,                                                       desc = "Code actions" },
      { "<leader>lA", vim.lsp.buf.range_code_action,                                                 mode = "v",                           desc = "Range code actions" },
      { "<leader>lf", vim.lsp.buf.format,                                                            desc = "Format code" },
      { "<leader>lr", vim.lsp.buf.rename,                                                            desc = "Rename symbol" },
      { "<leader>ls", vim.lsp.buf.signature_help,                                                    desc = "Signature help" },

      -- Telescope Integration
      { "<leader>lR", "<cmd>Telescope lsp_references<cr>",                                           desc = "Show references (Telescope)" },
      { "<leader>lw", "<cmd>Telescope diagnostics<cr>",                                              desc = "Show diagnostics (Telescope)" },
      { "<leader>lt", [[<Esc><Cmd>lua require('telescope').extensions.refactoring.refactors()<CR>]], desc = "Refactoring options" },

      -- Insert Mode Bindings
      { "<C-h>",      vim.lsp.buf.signature_help,                                                    mode = "i",                           desc = "Signature help" },
    }
  }
}
-- return {
--   {
--     "williamboman/mason.nvim",
--     event = { "BufReadPre", "BufNewFile" },
--     dependencies = {
--       "williamboman/mason-lspconfig.nvim",
--       "WhoIsSethDaniel/mason-tool-installer.nvim",
--       "neovim/nvim-lspconfig",
--       "hrsh7th/cmp-nvim-lsp",
--       "b0o/schemastore.nvim",
--       "nvim-telescope/telescope.nvim",
--       "folke/trouble.nvim",
--     },
--     config = function()
--       -- Import required modules
--       local mason = require("mason")
--       local mason_lspconfig = require("mason-lspconfig")
--       local mason_tool_installer = require("mason-tool-installer")
--       local lspconfig = require("lspconfig")
--       local cmp_nvim_lsp = require("cmp_nvim_lsp")
--       local schemastore = require("schemastore")
--
--       -- Setup capabilities once
--       local capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())
--
--       -- Basic mason setup with consistent UI
--       mason.setup({
--         ui = {
--           border = "rounded",
--           icons = {
--             package_installed = "✓",
--             package_pending = "➜",
--             package_uninstalled = "✗"
--           }
--         }
--       })
--
--       -- Define LSP servers configuration
--       local servers = {
--         -- Servers with custom settings
--         -- lua_ls = {
--         --   settings = {
--         --     Lua = {
--         --       runtime = {
--         --         version = 'LuaJIT',
--         --       },
--         --       diagnostics = {
--         --         globals = { 'vim' }, -- Add vim as a recognized global variable
--         --       },
--         --       workspace = {
--         --         checkThirdParty = false,
--         --         library = vim.api.nvim_get_runtime_file("", true)
--         --       },
--         --       completion = { callSnippet = "Replace" }
--         --     }
--         --   }
--         -- },
--         -- terraformls = {
--         --   cmd = { vim.fn.expand("~/.local/share/nvim/mason/bin/terraform-ls"), "serve" },
--         --   filetypes = { "terraform", "tf", "terraform-vars", "terraform-stack", "terraform-deploy" },
--         --   root_dir = lspconfig.util.root_pattern(".terraform", ".git") or vim.fs.dirname
--         -- },
--           terraformls = {
--     filetypes = { "terraform", "terraform-vars" },
--     root_dir = lspconfig.util.root_pattern(".terraform", ".git"),
--     single_file_support = true,
--   },
--         jsonls = {
--           settings = {
--             json = {
--               schemas = schemastore.json.schemas(),
--               validate = { enable = true }
--             }
--           }
--         },
--         -- Servers with default settings
--         bashls = {},
--         vimls = {},
--         pyright = {},
--         solidity_ls_nomicfoundation = {},
--       }
--
--       -- Ensure servers are installed and configured
--       mason_lspconfig.setup({
--         ensure_installed = vim.tbl_keys(servers),
--         automatic_installation = true,
--         automatic_enable = true,
--       })
--
--       -- Setup all servers with their configurations
--       for server_name, server_settings in pairs(servers) do
--         lspconfig[server_name].setup(vim.tbl_deep_extend("force", server_settings, { capabilities = capabilities }))
--       end
--
--       -- Install additional tools
--       mason_tool_installer.setup({
--         ensure_installed = {
--           "prettier",
--           "stylua",
--           "terraform-ls",
--           "tflint",
--           "tfsec",
--         }
--       })
--
--       -- Configure diagnostics
--       vim.diagnostic.config({
--         virtual_text = true,
--         signs = true,
--         update_in_insert = false,
--         underline = true,
--         severity_sort = true,
--         float = {
--           focusable = false,
--           style = "minimal",
--           border = "rounded",
--           source = "if_many",
--           header = "",
--           prefix = "",
--         }
--       })
--
--       -- Set diagnostic icons
--       local signs = {
--         Error = "󰊨",
--         Warn = "󰝦",
--         Hint = "󰈧",
--         Info = "󰉉"
--       }
--
--       for type, icon in pairs(signs) do
--         local hl = "DiagnosticSign" .. type
--         vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
--       end
--     end,
--     keys = {
--       -- LSP Actions
--       { "<leader>la", vim.lsp.buf.code_action,                                                       desc = "Code actions" },
--       { "<leader>lA", vim.lsp.buf.range_code_action,                                                 mode = "v",                           desc = "Range code actions" },
--       { "<leader>lf", vim.lsp.buf.format,                                                            desc = "Format code" },
--       { "<leader>lr", vim.lsp.buf.rename,                                                            desc = "Rename symbol" },
--       { "<leader>ls", vim.lsp.buf.signature_help,                                                    desc = "Signature help" },
--
--       -- Telescope Integration
--       { "<leader>lR", "<cmd>Telescope lsp_references<cr>",                                           desc = "Show references (Telescope)" },
--       { "<leader>lw", "<cmd>Telescope diagnostics<cr>",                                              desc = "Show diagnostics (Telescope)" },
--       { "<leader>lt", [[<Esc><Cmd>lua require('telescope').extensions.refactoring.refactors()<CR>]], desc = "Refactoring options" },
--
--       -- Insert Mode Bindings
--       { "<C-h>",      vim.lsp.buf.signature_help,                                                    mode = "i",                           desc = "Signature help" },
--     }
--   }
-- }
