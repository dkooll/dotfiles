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
    },
    config = function()
      -- Basic mason setup
      require("mason").setup({
        ui = { border = "rounded", icons = { package_installed = "✓", package_pending = "➜", package_uninstalled = "✗" } }
      })

      -- Load and configure LSP immediately
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

      -- Server configurations
      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              runtime = { version = "LuaJIT" },
              workspace = { checkThirdParty = false, library = vim.api.nvim_get_runtime_file("", true) },
              completion = { callSnippet = "Replace" }
            }
          }
        },
        terraformls = {
          cmd = { vim.fn.expand('~/.local/share/nvim/mason/bin/terraform-ls'), "serve" },
          filetypes = { "terraform", "tf", "terraform-vars" },
          root_dir = function(fname)
            return require('lspconfig.util').root_pattern('.terraform', '.git')(fname) or vim.fs.dirname(fname)
          end
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
              schemas = require("schemastore").json.schemas(),
              validate = { enable = true }
            }
          }
        }
      }

      -- Setup all configured servers
      for server_name, server_settings in pairs(servers) do
        lspconfig[server_name].setup(vim.tbl_deep_extend("force", server_settings, { capabilities = capabilities }))
      end

      -- Setup basic servers
      for _, server in ipairs({ "bashls", "vimls", "pyright", "solidity_ls_nomicfoundation" }) do
        lspconfig[server].setup({ capabilities = capabilities })
      end

      -- Defer the mason-lspconfig and tool installer setup
      vim.defer_fn(function()
        require("mason-lspconfig").setup({
          ensure_installed = {
            "jsonls", "terraformls", "lua_ls", "bashls",
            "vimls", "pyright", "solidity_ls_nomicfoundation", "yamlls",
          },
          automatic_installation = true
        })

        require("mason-tool-installer").setup({
          ensure_installed = {
            "prettier", "stylua", "terraform-ls", "tflint", "tfsec",
          }
        })
      end, 0)

      -- Set up diagnostic config and signs
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
          prefix = ""
        }
      })

      for type, icon in pairs({ Error = "󰊨", Warn = "󰝦", Hint = "󰈧", Info = "󰉉" }) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end
    end,
    keys = {
      { "gd",          function() vim.lsp.buf.definition() end },
      { "K",           function() vim.lsp.buf.hover() end },
      { "<leader>vws", function() vim.lsp.buf.workspace_symbol() end },
      { "<leader>vd",  function() vim.diagnostic.open_float() end },
      { "[d",          function() vim.diagnostic.goto_prev() end },
      { "]d",          function() vim.diagnostic.goto_next() end },
      { "<leader>vca", function() vim.lsp.buf.code_action() end },
      { "<leader>vrr", function() vim.lsp.buf.references() end },
      { "<leader>vrn", function() vim.lsp.buf.rename() end },
      { "<C-h>",       function() vim.lsp.buf.signature_help() end, mode = "i" },
    }
  }
}
--return {
  --{
    --"williamboman/mason.nvim",
    --event = "VeryLazy",
    --dependencies = {
      --"williamboman/mason-lspconfig.nvim",
      --"WhoIsSethDaniel/mason-tool-installer.nvim",
      --"neovim/nvim-lspconfig",
      --"hrsh7th/cmp-nvim-lsp",
      --"b0o/schemastore.nvim",
    --},
    --config = function()
      ---- Cache frequently used modules
      --local mason = require("mason")
      --local mason_lspconfig = require("mason-lspconfig")
      --local mason_tool_installer = require("mason-tool-installer")
      --local lspconfig = require("lspconfig")
      --local cmp_nvim_lsp = require("cmp_nvim_lsp")
      --local capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())

      ---- Basic mason setup
      --mason.setup({
        --ui = { border = "rounded", icons = { package_installed = "✓", package_pending = "➜", package_uninstalled = "✗" } }
      --})

      --local servers = {
        --["lua_ls"] = {
          --settings = {
            --Lua = {
              --runtime = { version = "LuaJIT" },
              --workspace = { checkThirdParty = false, library = vim.api.nvim_get_runtime_file("", true) },
              --completion = { callSnippet = "Replace" }
            --}
          --}
        --},
        --["terraformls"] = {
          --cmd = { vim.fn.expand('~/.local/share/nvim/mason/bin/terraform-ls'), "serve" },
          --filetypes = { "terraform", "tf", "terraform-vars" },
          --root_dir = function(fname)
            --return require('lspconfig.util').root_pattern('.terraform', '.git')(fname) or vim.fs.dirname(fname)
          --end
        --},
        --["yamlls"] = {
          --settings = {
            --yaml = {
              --schemas = {
                --["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
                --["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] =
                --"docker-compose*.yml"
              --}
            --}
          --}
        --},
        --["jsonls"] = {
          --settings = {
            --json = {
              --schemas = require("schemastore").json.schemas(),
              --validate = { enable = true }
            --}
          --}
        --}
      --}

      --mason_lspconfig.setup({
        --ensure_installed = {
          --"jsonls",
          --"terraformls",
          --"lua_ls",
          --"bashls",
          --"vimls",
          --"pyright",
          --"solidity_ls_nomicfoundation",
          --"yamlls",
        --},
        --automatic_installation = true
      --})

      --mason_tool_installer.setup({
        --ensure_installed = {
          --"prettier",
          --"stylua",
          --"terraform-ls",
          --"tflint",
          --"tfsec",
        --}
      --})

      ---- Setup all servers
      --for server_name, server_settings in pairs(servers) do
        --local config = vim.tbl_deep_extend("force", server_settings, { capabilities = capabilities })
        --lspconfig[server_name].setup(config)
      --end

      ---- Setup basic servers
      --for _, server in ipairs({ "bashls", "vimls", "pyright", "solidity_ls_nomicfoundation" }) do
        --lspconfig[server].setup({ capabilities = capabilities })
      --end

      ---- set lsp keymaps only once
      --local function setup_keymaps(bufnr)
        --local opts = { buffer = bufnr, silent = true }
        --local keymaps = {
          --{ "n", "gd",          vim.lsp.buf.definition },
          --{ "n", "K",           vim.lsp.buf.hover },
          --{ "n", "<leader>vws", vim.lsp.buf.workspace_symbol },
          --{ "n", "<leader>vd",  vim.diagnostic.open_float },
          --{ "n", "[d",          vim.diagnostic.goto_prev },
          --{ "n", "]d",          vim.diagnostic.goto_next },
          --{ "n", "<leader>vca", vim.lsp.buf.code_action },
          --{ "n", "<leader>vrr", vim.lsp.buf.references },
          --{ "n", "<leader>vrn", vim.lsp.buf.rename },
          --{ "i", "<C-h>",       vim.lsp.buf.signature_help }
        --}
        --for _, map in ipairs(keymaps) do
          --vim.keymap.set(map[1], map[2], map[3], opts)
        --end
      --end

      ---- attach keymaps to lsp buffers
      --vim.api.nvim_create_autocmd("LspAttach", {
        --group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        --callback = function(ev)
          --setup_keymaps(ev.buf)
        --end
      --})

      --vim.diagnostic.config({
        --virtual_text = true,
        --signs = true,
        --update_in_insert = false,
        --underline = true,
        --severity_sort = true,
        --float = {
          --focusable = false,
          --style = "minimal",
          --border = "rounded",
          --source = "if_many",
          --header = "",
          --prefix = ""
        --}
      --})

      --for type, icon in pairs({ Error = "󰊨", Warn = "󰝦", Hint = "󰈧", Info = "󰉉" }) do
        --local hl = "DiagnosticSign" .. type
        --vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      --end
    --end
  --}
--}
