return {
  jsonls = {
    settings = {
      json = {
        schema = require("schemastore").json.schemas(),
        validate = { enable = true },
      },
    },
  },
  terraformls = {
    cmd = { vim.fn.expand('~/.local/share/nvim/mason/bin/terraform-ls'), "serve" },
    filetypes = { "terraform", "tf", "terraform-vars" },
    single_file_support = true,
    root_dir = function(fname)
      local util = require('lspconfig.util')
      return util.root_pattern('.terraform', '.git')(fname) or vim.fs.dirname(fname)
    end,
    capabilities = {
      workspace = {
        workspaceFolders = false
      }
    },
    before_init = function(initialize_params)
      initialize_params.workspaceFolders = nil
    end,
    on_attach = function(_, bufnr)
      -- Set up formatting keymap
      local opts = {
        mode = "n",
        prefix = "<leader>",
        buffer = bufnr,
        silent = true,
        noremap = true,
        nowait = true,
      }
      local mappings = {
        l = {
          f = {
            function()
              vim.lsp.buf.format({ async = true })
            end,
            "Format file"
          },
        },
      }
      require("which-key").register(mappings, opts)
    end,
  },
  lua_ls = {
    settings = {
      Lua = {
        runtime = { version = "LuaJIT" },
        workspace = {
          checkThirdParty = false,
          library = {
            "${3rd}/luv/library",
            table.unpack(vim.api.nvim_get_runtime_file("", true)),
          },
        },
        completion = {
          callSnippet = "Replace",
        },
      },
    },
  },
  bashls = {
    filetypes = { "sh", "zsh" },
  },
  vimls = {
    filetypes = { "vim" },
  },
  tsserver = {},
  gopls = {},
  pyright = {},
  solidity_ls_nomicfoundation = {},
  yamlls = {
    cmd = { "yaml-language-server", "--stdio" },
    filetypes = { "yaml" },
  },
}
