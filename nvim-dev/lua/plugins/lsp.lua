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
      local servers = { "terraformls", "rust_analyzer", "gopls", "pyright", "lua_ls" }

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


--return {
--"neovim/nvim-lspconfig",
--event = { "BufReadPre", "BufNewFile" },
--dependencies = {
--"williamboman/mason.nvim",
--"williamboman/mason-lspconfig.nvim",
--"hrsh7th/nvim-cmp",
--"hrsh7th/cmp-nvim-lsp",
--},
--config = function()
---- Setup Mason which manages external tooling such as LSP servers, DAP servers, etc.
--require("mason").setup({
--ui = {
--border = "rounded",
--icons = {
--package_installed = "✓",
--package_pending = "➜",
--package_uninstalled = "✗",
--},
--},
--})

---- Automatically install LSP servers via Mason
--require("mason-lspconfig").setup({
--ensure_installed = {
--"terraformls",    -- Terraform LSP
--"rust_analyzer",  -- Rust LSP
--"gopls",          -- Go LSP
--"pyright",        -- Python LSP
--"lua_ls",         -- Lua LSP
--},
--automatic_installation = true,
--})

---- nvim-cmp supports additional capabilities
--local capabilities = vim.lsp.protocol.make_client_capabilities()
--local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
--if cmp_nvim_lsp_ok then
--capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
--end

---- Setup lspconfig for each server
--local lspconfig = require("lspconfig")
--local servers = { "terraformls", "rust_analyzer", "gopls", "pyright", "lua_ls" }

--for _, server in ipairs(servers) do
--local server_opts = {
--capabilities = capabilities,
--}

---- Additional Lua-specific configurations
--if server == "lua_ls" then
--server_opts.settings = {
--Lua = {
--diagnostics = {
--globals = {'vim'},  -- Acknowledge 'vim' as a global variable
--},
--workspace = {
---- Setup Lua workspace to recognize Neovim's API
--library = vim.api.nvim_get_runtime_file("", true),
--},
--telemetry = {
--enable = false,  -- Disable telemetry to prevent sending data
--},
--},
--}
--end

---- Setup the LSP server with the configured options
--lspconfig[server].setup(server_opts)
--end

---- LSP Key mappings setup on LSP attach
--vim.api.nvim_create_autocmd("LspAttach", {
--group = vim.api.nvim_create_augroup("UserLspConfig", {}),
--callback = function(ev)
--local opts = { buffer = ev.buf }
--vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
--vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
--vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
--vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
--vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
--vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
--vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
--vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
--vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
--vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
--end,
--})

---- Diagnostic configuration for appearance and behavior
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
--prefix = "",
--},
--})

---- Custom diagnostic signs for better visual representation
--local signs = { Error = "󰊨", Warn = "󰝦", Hint = "󰈧", Info = "󰉉" }
--for type, icon in pairs(signs) do
--local hl = "DiagnosticSign" .. type
--vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
--end
--end,
--}



--return {
--"neovim/nvim-lspconfig",
--event = { "BufReadPre", "BufNewFile" },
--dependencies = {
--"williamboman/mason.nvim",
--"williamboman/mason-lspconfig.nvim",
--"hrsh7th/nvim-cmp",
--"hrsh7th/cmp-nvim-lsp",
--},
--config = function()
--require("mason").setup({
--ui = {
--border = "rounded",
--icons = {
--package_installed = "✓",
--package_pending = "➜",
--package_uninstalled = "✗",
--},
--},
--})

--require("mason-lspconfig").setup({
--ensure_installed = {
--"terraformls",
--"rust_analyzer",
--"gopls",
--"pyright",
--"lua_ls",
--},
--automatic_installation = true,
--})

--local capabilities = vim.lsp.protocol.make_client_capabilities()
--local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
--if cmp_nvim_lsp_ok then
--capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
--end

--local lspconfig = require("lspconfig")
--local servers = { "terraformls", "rust_analyzer", "gopls", "pyright", "lua_ls" }

--for _, server in ipairs(servers) do
--lspconfig[server].setup({
--capabilities = capabilities,
--})
--end

---- Key mappings
--vim.api.nvim_create_autocmd("LspAttach", {
--group = vim.api.nvim_create_augroup("UserLspConfig", {}),
--callback = function(ev)
--local opts = { buffer = ev.buf }
--vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
--vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
--vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
--vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
--vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
--vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
--vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
--vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
--vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
--vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
--end,
--})

---- Diagnostic configuration
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
--prefix = "",
--},
--})

---- Diagnostic signs
--local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
--for type, icon in pairs(signs) do
--local hl = "DiagnosticSign" .. type
--vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
--end
--end,
--}
