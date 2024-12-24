return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    { "nvim-tree/nvim-web-devicons",  event = "VeryLazy" },
    { "meuter/lualine-so-fancy.nvim", event = "VeryLazy" },
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
        statusline = { "help", "neo-tree", "toggleterm" },
      },
    },
    sections = {
      lualine_a = {},
      lualine_b = {
        { "fancy_branch", color = { fg = "#7DAEA3", bg = "NONE" } },
      },
      lualine_c = {
        {
          "filename",
          color = { fg = "#D3869B" },
          path = 1,
          symbols = { modified = "  " },
        },
        {
          "diagnostics",
          sources = { "nvim_diagnostic" },
          symbols = { error = " ", warn = " ", info = " " },
        },
        { "fancy_searchcount" },
      },
      lualine_x = {
        {
          function()
            local lazy = require("lazy.status")
            return lazy.has_updates() and lazy.updates() or ""
          end,
          cond = function()
            return require("lazy.status").has_updates()
          end,
          color = { fg = "#7DAEA3", gui = "bold" },
        },
        { "fancy_lsp_servers", color = { fg = "#D3869B" } },
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
    extensions = { "neo-tree" },
  },
}
