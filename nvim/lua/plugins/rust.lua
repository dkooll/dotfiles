return {
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-lua/plenary.nvim",
      "mfussenegger/nvim-dap",
      "saecki/crates.nvim",
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
            check = {
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
    keys = {
      -- Rust Tools
      -- { "<leader>Rj", function() require('rust-tools').join_lines.join_lines() end, desc = "Join Lines" },
      -- { "<leader>Rr", "<cmd>RustRunnables<cr>",                                     desc = "Runnables" },
      -- { "<leader>Rt", "<cmd>lua *CARGO*TEST()<cr>",                                 desc = "Cargo Test" },
      -- { "<leader>Rm", "<cmd>RustExpandMacro<cr>",                                   desc = "Expand Macro" },
      -- { "<leader>Rc", "<cmd>RustOpenCargo<cr>",                                     desc = "Open Cargo" },
      -- { "<leader>Rp", "<cmd>RustParentModule<cr>",                                  desc = "Parent Module" },
      -- { "<leader>Rd", "<cmd>RustDebuggables<cr>",                                   desc = "Debuggables" },
      -- { "<leader>Rv", "<cmd>RustViewCrateGraph<cr>",                                desc = "View Crate Graph" },
      {
        "<leader>RR",
        function()
          require('rust-tools/workspace_refresh')._reload_workspace_from_cargo_toml()
        end,
        desc = "Rust: Reload Workspace"
      },

      -- Crates
      -- { "<leader>Co", function() require('crates').show_popup() end,              desc = "Show popup" },
      -- { "<leader>Cr", function() require('crates').reload() end,                  desc = "Reload" },
      -- { "<leader>Cv", function() require('crates').show_versions_popup() end,     desc = "Show Versions" },
      -- { "<leader>Cf", function() require('crates').show_features_popup() end,     desc = "Show Features" },
      -- { "<leader>Cd", function() require('crates').show_dependencies_popup() end, desc = "Show Dependencies Popup" },
      -- { "<leader>Cu", function() require('crates').update_crate() end,            desc = "Update Crate" },
      -- { "<leader>Ca", function() require('crates').update_all_crates() end,       desc = "Update All Crates" },
      -- { "<leader>CU", function() require('crates').upgrade_crate() end,           desc = "Upgrade Crate" },
      -- { "<leader>CA", function() require('crates').upgrade_all_crates(true) end,  desc = "Upgrade All Crates" },
      -- { "<leader>CH", function() require('crates').open_homepage() end,           desc = "Open Homepage" },
      -- { "<leader>CR", function() require('crates').open_repository() end,         desc = "Open Repository" },
      -- { "<leader>CD", function() require('crates').open_documentation() end,      desc = "Open Documentation" },
      -- { "<leader>CC", function() require('crates').open_crates_io() end,          desc = "Open Crate.io" },
    },
    config = function(_, opts)
      require("rust-tools").setup(opts)
    end,
  },
}
