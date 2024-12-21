return {
  {
    "williamboman/mason.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
      "b0o/schemastore.nvim",
      "nvim-telescope/telescope.nvim",
      "folke/trouble.nvim",
    },
    config = function()
      -- Import required modules
      local mason = require("mason")
      local mason_lspconfig = require("mason-lspconfig")
      local mason_tool_installer = require("mason-tool-installer")
      local lspconfig = require("lspconfig")
      local cmp_nvim_lsp = require("cmp_nvim_lsp")
      local schemastore = require("schemastore")

      -- Setup capabilities once
      local capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())

      -- Basic mason setup with consistent UI
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

      -- Define LSP servers configuration
      local servers = {
        -- Servers with custom settings
        lua_ls = {
          settings = {
            Lua = {
              runtime = { version = "LuaJIT" },
              workspace = {
                checkThirdParty = false,
                library = vim.api.nvim_get_runtime_file("", true)
              },
              completion = { callSnippet = "Replace" }
            }
          }
        },
        terraformls = {
          cmd = { vim.fn.expand("~/.local/share/nvim/mason/bin/terraform-ls"), "serve" },
          filetypes = { "terraform", "tf", "terraform-vars" },
          root_dir = lspconfig.util.root_pattern(".terraform", ".git") or vim.fs.dirname
        },
        yamlls = {
          settings = {
            yaml = {
              schemas = {
                ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
                ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] =
                "docker-compose*.yml"
              }
            }
          }
        },
        jsonls = {
          settings = {
            json = {
              schemas = schemastore.json.schemas(),
              validate = { enable = true }
            }
          }
        },
        -- Servers with default settings
        bashls = {},
        vimls = {},
        pyright = {},
        solidity_ls_nomicfoundation = {},
      }

      -- Ensure servers are installed and configured
      mason_lspconfig.setup({
        ensure_installed = vim.tbl_keys(servers),
        automatic_installation = true,
      })

      -- Setup all servers with their configurations
      for server_name, server_settings in pairs(servers) do
        lspconfig[server_name].setup(vim.tbl_deep_extend("force", server_settings, { capabilities = capabilities }))
      end

      -- Install additional tools
      mason_tool_installer.setup({
        ensure_installed = {
          "prettier",
          "stylua",
          "terraform-ls",
          "tflint",
          "tfsec",
        }
      })

      -- Configure diagnostics
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

      -- Set diagnostic icons
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
      -- LSP Navigation
      { "gd",         vim.lsp.buf.definition,                                                        desc = "Go to definition" },
      { "gD",         vim.lsp.buf.declaration,                                                       desc = "Go to declaration" },
      { "gi",         vim.lsp.buf.implementation,                                                    desc = "Go to implementation" },
      { "go",         vim.lsp.buf.type_definition,                                                   desc = "Go to type definition" },
      { "gr",         vim.lsp.buf.references,                                                        desc = "Show references" },
      { "K",          vim.lsp.buf.hover,                                                             desc = "Show hover documentation" },
      { "gl",         vim.diagnostic.open_float,                                                     desc = "Show line diagnostics" },

      -- LSP Actions
      { "<leader>la", vim.lsp.buf.code_action,                                                       desc = "Code actions" },
      { "<leader>lA", vim.lsp.buf.range_code_action,                                                 mode = "v",                              desc = "Range code actions" },
      { "<leader>lf", vim.lsp.buf.format,                                                            desc = "Format code" },
      { "<leader>lr", vim.lsp.buf.rename,                                                            desc = "Rename symbol" },
      { "<leader>ls", vim.lsp.buf.signature_help,                                                    desc = "Signature help" },

      -- Telescope Integration
      { "<leader>lR", "<cmd>Telescope lsp_references<cr>",                                           desc = "Show references (Telescope)" },
      { "<leader>lw", "<cmd>Telescope diagnostics<cr>",                                              desc = "Show diagnostics (Telescope)" },
      { "<leader>lt", [[<Esc><Cmd>lua require('telescope').extensions.refactoring.refactors()<CR>]], desc = "Refactoring options" },

      -- Trouble Integration
      { "<leader>ll", "<cmd>TroubleToggle document_diagnostics<cr>",                                 desc = "Document diagnostics (Trouble)" },
      { "<leader>lL", "<cmd>TroubleToggle workspace_diagnostics<cr>",                                desc = "Workspace diagnostics (Trouble)" },

      -- Insert Mode Bindings
      { "<C-h>",      vim.lsp.buf.signature_help,                                                    mode = "i",                              desc = "Signature help" },
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
--       -- Basic mason setup
--       require("mason").setup({
--         ui = { border = "rounded", icons = { package_installed = "✓", package_pending = "➜", package_uninstalled = "✗" } }
--       })
--
--       -- Load and configure LSP immediately
--       local lspconfig = require("lspconfig")
--       local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
--
--       -- Server configurations
--       local servers = {
--         lua_ls = {
--           settings = {
--             Lua = {
--               runtime = { version = "LuaJIT" },
--               workspace = { checkThirdParty = false, library = vim.api.nvim_get_runtime_file("", true) },
--               completion = { callSnippet = "Replace" }
--             }
--           }
--         },
--         terraformls = {
--           cmd = { vim.fn.expand('~/.local/share/nvim/mason/bin/terraform-ls'), "serve" },
--           filetypes = { "terraform", "tf", "terraform-vars" },
--           root_dir = function(fname)
--             return require('lspconfig.util').root_pattern('.terraform', '.git')(fname) or vim.fs.dirname(fname)
--           end
--         },
--         yamlls = {
--           settings = {
--             yaml = {
--               schemas = {
--                 ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
--                 ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] =
--                 "docker-compose*.yml"
--               }
--             }
--           }
--         },
--         jsonls = {
--           settings = {
--             json = {
--               schemas = require("schemastore").json.schemas(),
--               validate = { enable = true }
--             }
--           }
--         }
--       }
--
--       -- Setup all configured servers
--       for server_name, server_settings in pairs(servers) do
--         lspconfig[server_name].setup(vim.tbl_deep_extend("force", server_settings, { capabilities = capabilities }))
--       end
--
--       -- Setup basic servers
--       for _, server in ipairs({ "bashls", "vimls", "pyright", "solidity_ls_nomicfoundation" }) do
--         lspconfig[server].setup({ capabilities = capabilities })
--       end
--
--       -- Rest of your mason setup...
--       vim.defer_fn(function()
--         require("mason-lspconfig").setup({
--           ensure_installed = {
--             "jsonls", "terraformls", "lua_ls", "bashls",
--             "vimls", "pyright", "solidity_ls_nomicfoundation", "yamlls",
--           },
--           automatic_installation = true
--         })
--
--         require("mason-tool-installer").setup({
--           ensure_installed = {
--             "prettier", "stylua", "terraform-ls", "tflint", "tfsec",
--           }
--         })
--       end, 0)
--
--       -- Diagnostic configuration
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
--           prefix = ""
--         }
--       })
--
--       for type, icon in pairs({ Error = "󰊨", Warn = "󰝦", Hint = "󰈧", Info = "󰉉" }) do
--         local hl = "DiagnosticSign" .. type
--         vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
--       end
--     end,
--     keys = {
--       -- Non-leader keymaps
--       { "gd",         function() vim.lsp.buf.definition() end },
--       { "gD",         function() vim.lsp.buf.declaration() end },
--       { "gi",         function() vim.lsp.buf.implementation() end },
--       { "gl",         function() vim.diagnostic.open_float() end },
--       { "go",         function() vim.lsp.buf.type_definition() end },
--       { "gr",         function() vim.lsp.buf.references() end },
--       { "K",          function() vim.lsp.buf.hover() end },
--
--       -- Leader keymaps
--       { "<leader>la", function() vim.lsp.buf.code_action() end },
--       { "<leader>lA", function() vim.lsp.buf.range_code_action() end, mode = "v" },
--       { "<leader>lf", function() vim.lsp.buf.format() end },
--       { "<leader>lr", function() vim.lsp.buf.rename() end },
--       { "<leader>ls", function() vim.lsp.buf.signature_help() end },
--       { "<leader>lR", "<cmd>Telescope lsp_references<cr>" },
--       { "<leader>ll", "<cmd>TroubleToggle document_diagnostics<cr>" },
--       { "<leader>lL", "<cmd>TroubleToggle workspace_diagnostics<cr>" },
--       { "<leader>lw", "<cmd>Telescope diagnostics<cr>" },
--       { "<leader>lt", [[<Esc><Cmd>lua require('telescope').extensions.refactoring.refactors()<CR>]] },
--
--       -- Insert mode bindings
--       { "<C-h>",      function() vim.lsp.buf.signature_help() end, mode = "i" },
--     }
--   }
-- }
--
--
--
--
--
--
--
