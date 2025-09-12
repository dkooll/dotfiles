return {
  "catppuccin/nvim",
  lazy = false,
  priority = 1000,
  name = "catppuccin",
  commit = "94f6e8a06b6bb7b8e5529cf9f93adb4654534241",
  opts = {
    flavour = "mocha",
    compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
    no_italic = false,
    no_bold = false,
    no_underline = false,
    color_overrides = {
      mocha = {
        rosewater = "#EA6962",
        flamingo = "#EA6962",
        pink = "#D3869B",
        mauve = "#D3869B",
        red = "#EA6962",
        maroon = "#EA6962",
        peach = "#BD6F3E",
        yellow = "#D8A657",
        green = "#A9B665",
        teal = "#89B482",
        sky = "#89B482",
        sapphire = "#89B482",
        blue = "#7DAEA3",
        lavender = "#7DAEA3",
        text = "#D4BE98",
        subtext1 = "#BDAE8B",
        subtext0 = "#A69372",
        overlay2 = "#8C7A58",
        overlay1 = "#735F3F",
        overlay0 = "#958272",
        surface2 = "#4B4F51",
        surface1 = "#2A2D2E",
        surface0 = "#232728",
        base = "#1D2021",
        mantle = "#191C1D",
        crust = "#151819",
      },
    },
    transparent_background = true,
    show_end_of_buffer = false,
    integrations = {
      cmp = true,
      gitsigns = true,
      nvimtree = true,
      treesitter = true,
      telescope = {
        enabled = true,
      },
      lsp_trouble = false,
      which_key = true,
    },
    custom_highlights = function(colors)
      return {
        CursorLineNr = { fg = colors.mauve },
        IndentBlanklineChar = { fg = colors.surface0 },
        IndentBlanklineContextChar = { fg = colors.surface2 },
        GitSignsChange = { fg = colors.peach },
        NvimTreeIndentMarker = { link = "IndentBlanklineChar" },
        NvimTreeExecFile = { fg = colors.text },
        Visual = { fg = "#9E8069" },
        FloatBorder = { fg = "#303030" },
        Comment = { fg = "#9E8069" },
      }
    end,
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin")

    vim.api.nvim_set_hl(0, "CursorInsert", { fg = "NONE", bg = "#9E8069" })
    vim.api.nvim_set_hl(0, "Cursor", { fg = "NONE", bg = "#9E8069" })
    vim.opt.guicursor =
    "n-v-c:block-CursorInsert,i-ci-ve:hor20-CursorInsert,r-cr:hor20-CursorInsert,o:hor50-CursorInsert"
  end,
}
