return {
  'numToStr/FTerm.nvim',
  keys = {
    { "<C-t>", desc = "Toggle floating terminal" },
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

    -- Create a custom highlight group for the border
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      callback = function()
        vim.api.nvim_set_hl(0, "FTermBorder", { fg = "#D3D3D3" })  -- Light grey color
      end,
    })

    -- Apply the highlight immediately
    vim.cmd([[doautocmd ColorScheme]])

    -- Keybindings
    vim.keymap.set('n', '<C-t>', fterm.toggle)
    vim.keymap.set('t', '<C-t>', function()
      fterm.toggle()
    end)
  end
}
