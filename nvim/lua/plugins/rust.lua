return {
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-lua/plenary.nvim",
      "mfussenegger/nvim-dap",
    },
    opts = {
      server = {
        on_attach = function(_, bufnr)
          local opts = { buffer = bufnr, silent = true }
          vim.keymap.set("n", "<C-space>", function()
            require("rust-tools").hover_actions.hover_actions()
          end, opts)
          vim.keymap.set("n", "<Leader>a", function()
            require("rust-tools").code_action_group.code_action_group()
          end, opts)
        end,
        settings = {
          ["rust-analyzer"] = {
            checkOnSave = {
              command = "clippy",
              extraArgs = { "--all-features" }
            },
            cargo = {
              loadOutDirsFromCheck = true,
              allFeatures = true,
            },
            procMacro = { enable = true },
            lens = { enable = true },
            diagnostics = {
              disabled = { "unresolved-proc-macro" },
              enableExperimental = false,
            },
            completion = {
              privateEditable = { enable = false },
              fullFunctionSignatures = { enable = false },
            },
          },
        },
      },
      tools = {
        reload_workspace_from_cargo_toml = true,
        inlay_hints = {
          auto = false,
          only_current_line = true,
          show_parameter_hints = true,
          parameter_hints_prefix = "<- ",
          other_hints_prefix = "=> ",
          max_len_align = false,
          highlight = "Comment",
        },
        hover_actions = {
          border = "rounded",
          auto_focus = false,
        },
      },
    },
    config = function(_, opts)
      require("rust-tools").setup(opts)
    end,
  },
}
