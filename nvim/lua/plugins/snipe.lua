return {
  'leath-dub/snipe.nvim',
  keys = { 'gb' }, -- Lazy loads on 'gb', but we'll make sure to initialize it first in the mapping
  config = function()
    require('snipe').setup({
      ui = {
        max_width = -1, -- Dynamic width
        position = 'topleft'
      },
      hints = {
        dictionary = "sadflewcmpghio",
      },
      navigate = {
        next_page = "J",
        prev_page = "K",
        under_cursor = "<cr>",
        cancel_snipe = "<esc>",
      },
      sort = "default"
    })

    -- Key mapping that ensures snipe is fully loaded before calling open_buffer_menu
    vim.api.nvim_set_keymap('n', 'gb', "<cmd>lua require('snipe').open_buffer_menu()<CR>",
      { noremap = true, silent = true, desc = "Open Snipe buffer menu" })
  end
}
