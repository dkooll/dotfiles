-- https://github.com/alex35mil/dotfiles/blob/master/home/.config/nvim/.luarc.json
return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    require("mason").setup({
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    require("mason-lspconfig").setup({
      ensure_installed = {
        "terraformls",
        "rust_analyzer",
        "gopls",
        "lua_ls",
      },
      automatic_installation = true,
    })

    local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

    local function setup_servers()
      local lspconfig = require("lspconfig")
      local servers = { "terraformls", "rust_analyzer", "gopls", "lua_ls" }

      local lua_settings = {
        Lua = {
          diagnostics = {
            -- suppress the warning for undefined global `vim`
            globals = { 'vim' },
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
          },
          telemetry = {
            enable = false,
          },
        }
      }

      for _, server in ipairs(servers) do
        local opts = { capabilities = capabilities }
        if server == "lua_ls" then
          opts.settings = lua_settings
        end
        lspconfig[server].setup(opts)
      end
    end

    setup_servers()

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local opts = { buffer = ev.buf }
        local mappings = {
          { "n", "gd",          vim.lsp.buf.definition },
          { "n", "K",           vim.lsp.buf.hover },
          { "n", "<leader>vws", vim.lsp.buf.workspace_symbol },
          { "n", "<leader>vd",  vim.diagnostic.open_float },
          { "n", "[d",          vim.diagnostic.goto_next },
          { "n", "]d",          vim.diagnostic.goto_prev },
          { "n", "<leader>vca", vim.lsp.buf.code_action },
          { "n", "<leader>vrr", vim.lsp.buf.references },
          { "n", "<leader>vrn", vim.lsp.buf.rename },
          { "i", "<C-h>",       vim.lsp.buf.signature_help },
        }
        for _, map in ipairs(mappings) do
          vim.keymap.set(map[1], map[2], map[3], opts)
        end
      end,
    })

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
      },
    })

    local signs = { Error = "󰊨", Warn = "󰝦", Hint = "󰈧", Info = "󰉉" }
    for type, icon in pairs(signs) do
      vim.fn.sign_define("DiagnosticSign" .. type, { text = icon, texthl = "DiagnosticSign" .. type, numhl = "" })
    end
  end,
}
