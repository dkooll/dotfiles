return {
  'VonHeikemen/searchbox.nvim',
  requires = {
    'MunifTanjim/nui.nvim'
  },
  config = function()
    vim.api.nvim_set_keymap('n', 'si', ':SearchBoxIncSearch<CR>', { noremap = true })
    vim.api.nvim_set_keymap('n', 'S', ':SearchBoxMatchAll<CR>', { noremap = true })
    vim.api.nvim_set_keymap('n', 's', ':SearchBoxSimple<CR>', { noremap = true })
    vim.api.nvim_set_keymap('n', 'r', ':SearchBoxReplace<CR>', { noremap = true })
  end
}
