return {
  "yetone/avante.nvim",
  lazy = true,
  keys = {
    { "<leader>aa", "<cmd>AvanteToggle<cr>",          desc = "Avante: Show sidebar" },
    { "<leader>ar", "<cmd>AvanteRefresh<cr>",         desc = "Avante: Refresh sidebar" },
    { "<leader>af", "<cmd>AvanteFocus<cr>",           desc = "Avante: Switch sidebar focus" },
    { "<leader>ae", "<cmd>AvanteEdit<cr>",            desc = "Avante: Edit selected blocks" },
    { "co",         "<cmd>AvanteChooseOurs<cr>",      desc = "Avante: Choose ours" },
    { "ct",         "<cmd>AvanteChooseTheirs<cr>",    desc = "Avante: Choose theirs" },
    { "ca",         "<cmd>AvanteChooseAllTheirs<cr>", desc = "Avante: Choose all theirs" },
    { "c0",         "<cmd>AvanteChooseNone<cr>",      desc = "Avante: Choose none" },
    { "cb",         "<cmd>AvanteChooseBoth<cr>",      desc = "Avante: Choose both" },
    { "cc",         "<cmd>AvanteChooseCursor<cr>",    desc = "Avante: Choose cursor" },
    { "]x",         "<cmd>AvanteNextConflict<cr>",    desc = "Avante: Next conflict" },
    { "[x",         "<cmd>AvantePrevConflict<cr>",    desc = "Avante: Previous conflict" },
    { "[[",         "<cmd>AvantePrevCodeblock<cr>",   desc = "Avante: Previous codeblock" },
    { "]]",         "<cmd>AvanteNextCodeblock<cr>",   desc = "Avante: Next codeblock" },

  },
  version = false,
  opts = {
    sidebar = {
      width = 50,
      position = "right",
      auto_close = false, -- Prevent auto-closing which might trigger the error
    },
    llm = {
      timeout = 30000, -- Increase timeout to ensure proper state serialization
    },
    state = {
      persist = false, -- Disable state persistence to avoid deserialization issues
    },
  },
  build = "make",
  init = function()
    -- Disable the problematic ModeChanged autocmd
    vim.api.nvim_create_autocmd("User", {
      pattern = "AvanteLoad",
      callback = function()
        vim.api.nvim_create_autocmd("ModeChanged", {
          pattern = "*:i",
          callback = function()
            pcall(function()
              -- Add protection against the error
              local avante = require('avante')
              if avante.sidebar and avante.sidebar.is_open() then
                return true
              end
            end)
          end
        })
      end
    })
  end,
  dependencies = {
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "hrsh7th/nvim-cmp",
    "nvim-tree/nvim-web-devicons",
    "zbirenbaum/copilot.lua",
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}

--   version = false,
--   opts = {
--     sidebar = {
--       width = 40,
--       position = "right",
--     },
--     handlers = {
--       default = true,
--       error = function(err)
--         -- Add basic error handling
--         vim.notify("Avante error: " .. vim.inspect(err), vim.log.levels.WARN)
--       end
--     },
--     -- Add these settings to help with stability
--     setup = {
--       ensure_installed = true,
--       auto_setup = true,
--     },
--   },
--   build = "make",
--   dependencies = {
--     "stevearc/dressing.nvim",
--     "nvim-lua/plenary.nvim",
--     "MunifTanjim/nui.nvim",
--     "hrsh7th/nvim-cmp",
--     "nvim-tree/nvim-web-devicons",
--     "zbirenbaum/copilot.lua",
--     {
--       "HakonHarnes/img-clip.nvim",
--       event = "VeryLazy",
--       opts = {
--         default = {
--           embed_image_as_base64 = false,
--           prompt_for_file_name = false,
--           drag_and_drop = {
--             insert_mode = true,
--           },
--           use_absolute_path = true,
--         },
--       },
--     },
--     {
--       "MeanderingProgrammer/render-markdown.nvim",
--       opts = {
--         file_types = { "markdown", "Avante" },
--       },
--       ft = { "markdown", "Avante" },
--     },
--   },
-- }
-- -- return {
-- --  "yetone/avante.nvim",
-- --  lazy = true,
-- --  keys = {
-- --    { "<leader>aa", "<cmd>AvanteToggle<cr>", desc = "Show sidebar" },
-- --    { "<leader>ar", "<cmd>AvanteRefresh<cr>", desc = "Refresh sidebar" },
-- --    { "<leader>af", "<cmd>AvanteFocus<cr>", desc = "Switch sidebar focus" },
-- --    { "<leader>ae", "<cmd>AvanteEdit<cr>", desc = "Edit selected blocks" },
-- --    { "co", "<cmd>AvanteChooseOurs<cr>", desc = "Choose ours" },
-- --    { "ct", "<cmd>AvanteChooseTheirs<cr>", desc = "Choose theirs" },
-- --    { "ca", "<cmd>AvanteChooseAllTheirs<cr>", desc = "Choose all theirs" },
-- --    { "c0", "<cmd>AvanteChooseNone<cr>", desc = "Choose none" },
-- --    { "cb", "<cmd>AvanteChooseBoth<cr>", desc = "Choose both" },
-- --    { "cc", "<cmd>AvanteChooseCursor<cr>", desc = "Choose cursor" },
-- --    { "]x", "<cmd>AvanteNextConflict<cr>", desc = "Next conflict" },
-- --    { "[x", "<cmd>AvantePrevConflict<cr>", desc = "Previous conflict" },
-- --    { "[[", "<cmd>AvantePrevCodeblock<cr>", desc = "Previous codeblock" },
-- --    { "]]", "<cmd>AvanteNextCodeblock<cr>", desc = "Next codeblock" },
-- --  },
-- --  version = false,
-- --  opts = {
-- --    -- add any opts here
-- --  },
-- --  build = "make",
-- --  dependencies = {
-- --    "stevearc/dressing.nvim",
-- --    "nvim-lua/plenary.nvim",
-- --    "MunifTanjim/nui.nvim",
-- --    "hrsh7th/nvim-cmp",
-- --    "nvim-tree/nvim-web-devicons",
-- --    "zbirenbaum/copilot.lua",
-- --    {
-- --      "HakonHarnes/img-clip.nvim",
-- --      event = "VeryLazy",
-- --      opts = {
-- --        default = {
-- --          embed_image_as_base64 = false,
-- --          prompt_for_file_name = false,
-- --          drag_and_drop = {
-- --            insert_mode = true,
-- --          },
-- --          use_absolute_path = true,
-- --        },
-- --      },
-- --    },
-- --    {
-- --      "MeanderingProgrammer/render-markdown.nvim",
-- --      opts = {
-- --        file_types = { "markdown", "Avante" },
-- --      },
-- --      ft = { "markdown", "Avante" },
-- --    },
-- --  },
-- -- }
--
-- -- return {
-- --   "yetone/avante.nvim",
-- --   event = "VeryLazy",
-- --   lazy = false,
-- --   version = false, -- set this if you want to always pull the latest change
-- --   opts = {
-- --     -- add any opts here
-- --   },
-- --   -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
-- --   build = "make",
-- --   -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
-- --   dependencies = {
-- --     "stevearc/dressing.nvim",
-- --     "nvim-lua/plenary.nvim",
-- --     "MunifTanjim/nui.nvim",
-- --     --- The below dependencies are optional,
-- --     "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
-- --     "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
-- --     "zbirenbaum/copilot.lua", -- for providers='copilot'
-- --     {
-- --       -- support for image pasting
-- --       "HakonHarnes/img-clip.nvim",
-- --       event = "VeryLazy",
-- --       opts = {
-- --         -- recommended settings
-- --         default = {
-- --           embed_image_as_base64 = false,
-- --           prompt_for_file_name = false,
-- --           drag_and_drop = {
-- --             insert_mode = true,
-- --           },
-- --           -- required for Windows users
-- --           use_absolute_path = true,
-- --         },
-- --       },
-- --     },
-- --     {
-- --       -- Make sure to set this up properly if you have lazy=true
-- --       "MeanderingProgrammer/render-markdown.nvim",
-- --       opts = {
-- --         file_types = { "markdown", "Avante" },
-- --       },
-- --       ft = { "markdown", "Avante" },
-- --     },
-- --   },
-- -- }
-- --
