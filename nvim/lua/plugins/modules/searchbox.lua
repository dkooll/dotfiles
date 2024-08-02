return {
  'VonHeikemen/searchbox.nvim',
  requires = {
    'MunifTanjim/nui.nvim'
  },
  config = function()
    vim.api.nvim_set_keymap('n', '<leader>si', ':SearchBoxIncSearch<CR>', { noremap = true })
    vim.api.nvim_set_keymap('n', '<leader>S', ':SearchBoxMatchAll<CR>', { noremap = true })
    vim.api.nvim_set_keymap('n', '<leader>s', ':SearchBoxSimple<CR>', { noremap = true })
    vim.api.nvim_set_keymap('n', '<leader>r', ':SearchBoxReplace<CR>', { noremap = true })
  end
}
