return {
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    ft = { "go", "gomod", "gowork", "gotmpl" },
    opts = {
      lsp_cfg = true,
      lsp_on_attach = true,
      go_silent_install = true,
      luasnip = false,
      dap_debug = false,
      lsp_codelens = false,
      lsp_inlay_hints = { enable = false },
      lsp_keymaps = false,
      diagnostic = {
        virtual_text = false,
        hdlr = false,
      },
      gopls_cmd = { "gopls" },
      gopls_settings = {
        staticcheck = true,
        gofumpt = true,
        analyses = {
          unusedparams = false,
          shadow = false,
        },
        experimentalWorkspaceModule = false,
        memoryMode = "Normal",
        expandWorkspaceToModule = false,
        templateExtensions = false,
        completionBudget = "100ms",
        diagnosticsDelay = "250ms",
        symbolScope = "workspace",
        matcher = "fuzzy",
        diagnosticStyle = "instant",
      },
    },
    config = function(_, opts)
      require("go").setup(opts)
    end,
  }
}
