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
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      disabled_filetypes = {
        statusline = { "help", "neo-tree", "toggleterm", "alpha" },
        tabline = { "alpha" },
      },
    },
    sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {
      lualine_a = {
        {
          "fancy_branch",
          cond = function() return vim.fn.buflisted(vim.fn.bufnr()) == 1 end,
          color = { fg = "#7DAEA3", bg = "NONE" }
        },
        {
          "filename",
          cond = function() return vim.fn.buflisted(vim.fn.bufnr()) == 1 end,
          color = { fg = "#D3869B", bg = "NONE" },
          path = 1,
          symbols = { modified = "  " }
        },
        {
          "fancy_lsp_servers",
          cond = function() return vim.fn.buflisted(vim.fn.bufnr()) == 1 end,
          color = { fg = "#D3869B", bg = "NONE" }
        },
        {
          function()
            local lazy = require("lazy.status")
            return lazy.has_updates() and lazy.updates() or ""
          end,
          cond = function() return vim.fn.buflisted(vim.fn.bufnr()) == 1 and require("lazy.status").has_updates() end,
          color = { fg = "#BD6F3E", bg = "NONE", gui = "bold" }
        },
      },
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
    extensions = { "neo-tree" },
  },
}
