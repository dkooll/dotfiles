return {
  'numToStr/FTerm.nvim',
  keys = {
    { "<C-t>", function() require('FTerm').toggle() end, desc = "Fterm: Toggle Floating Terminal" },
  },
  opts = {
    border = 'single',
    dimensions = {
      height = 0.9,
      width = 0.9,
    },
    hl = 'FTermBorder',
  },
  config = function(_, opts)
    local fterm = require('FTerm')
    fterm.setup(opts)

    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      callback = function()
        vim.api.nvim_set_hl(0, "FTermBorder", { fg = "#D3D3D3" })
      end,
    })
    vim.api.nvim_set_hl(0, "FTermBorder", { fg = "#D3D3D3" })
  end,
}
