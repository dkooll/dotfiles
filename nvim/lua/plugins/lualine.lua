return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "meuter/lualine-so-fancy.nvim",
    -- "arkav/lualine-lsp-progress",
  },
  event = "VeryLazy",
  opts = {
    options = {
      theme = "auto",
      globalstatus = true,
      icons_enabled = true,
      component_separators = { left = "|", right = "|" },
      section_separators = { left = "", right = "" },
      disabled_filetypes = {
        statusline = {
          "alfa-nvim",
          "help",
          "neo-tree",
          "Trouble",
          "spectre_panel",
          "toggleterm",
        },
        winbar = {},
      },
    },
    sections = {
      lualine_a = {},
      lualine_b = {
        {
          "fancy_branch",
          color = { fg = "#7DAEA3", bg = "" },
        }
      },
      lualine_c = {
        {
          "filename",
          color = { fg = "#D3869B" },
          path = 1,
          symbols = {
            modified = "  ",
          },
        },
        {
          "fancy_diagnostics",
          sources = { "nvim_lsp" },
          symbols = { error = " ", warn = " ", info = " " }
        },
        { "fancy_searchcount" },
      },
      lualine_x = {
        {
          function() return require("lazy.status").updates() end,
          cond = function() return require("lazy.status").has_updates() end,
          color = { fg = "#7DAEA3", gui = "bold" },
        },
        { "fancy_lsp_servers", color = { fg = "#D3869B" } },
        -- { "lsp_progress",      color = { fg = "#D3869B", gui = "bold" } },
      },
      lualine_y = {},
      lualine_z = {},
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { "filename" },
      lualine_y = {},
      lualine_z = {},
    },
    extensions = { "neo-tree", "lazy" },
  }
}

-- return {
--   "nvim-lualine/lualine.nvim",
--   dependencies = {
--     "nvim-tree/nvim-web-devicons",
--     "meuter/lualine-so-fancy.nvim",
--   },
--   enabled = true,
--   event = { "BufReadPost", "BufNewFile", "VeryLazy" },
--   config = function()
--     local lazy_status = require("lazy.status")
--     require("lualine").setup({
--       options = {
--         theme = "auto",
--         --theme = "catppuccin",
--         globalstatus = true,
--         icons_enabled = true,
--         component_separators = { left = "|", right = "|" },
--         section_separators = { left = "", right = "" },
--         disabled_filetypes = {
--           statusline = {
--             "alfa-nvim",
--             "help",
--             "neo-tree",
--             "Trouble",
--             "spectre_panel",
--             "toggleterm",
--           },
--           winbar = {},
--         },
--       },
--       sections = {
--         lualine_a = {
--         },
--         lualine_b = {
--           {
--             "fancy_branch",
--             color = { fg = "#7DAEA3", bg = "" },
--           }
--         },
--         lualine_c = {
--           {
--             "filename",
--             color = { fg = "#D3869B" },
--             path = 1,
--             symbols = {
--               modified = "  ",
--             },
--           },
--           { "fancy_diagnostics", sources = { "nvim_lsp" }, symbols = { error = " ", warn = " ", info = " " } },
--           { "fancy_searchcount" },
--         },
--         lualine_x = {
--           {
--             lazy_status.updates,
--             cond = lazy_status.has_updates,
--             color = { fg = "#7DAEA3", gui = "bold" },
--           },
--           { "fancy_lsp_servers", color = { fg = "#D3869B" } },
--           --{ "fancy_diff",        color = { fg = "#ff9e64" } },
--           { "progress", color = { fg = "#D3869B", gui = "bold" },
--           },
--         },
--         lualine_y = {},
--         lualine_z = {},
--       },
--       inactive_sections = {
--         lualine_a = {},
--         lualine_b = {},
--         lualine_c = { "filename" },
--         lualine_y = {},
--         lualine_z = {},
--       },
--       tabline = {},
--       extensions = { "neo-tree", "lazy" },
--     })
--   end,
-- }
