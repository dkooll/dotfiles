return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    cmd = "ToggleTerm",
    keys = {
      { "<C-\\>", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
      { "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "ToggleTerm horizontal split" },
      { "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", desc = "ToggleTerm vertical split" },
    },
    opts = {
      size = function(term)
        if term.direction == "horizontal" then
          return 30
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      open_mapping = [[<c-\>]],
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      direction = "horizontal",
      close_on_exit = true,
      shell = vim.o.shell,
    },
    config = function(_, opts)
      require("toggleterm").setup(opts)

      local function set_terminal_keymaps()
        local options = {buffer = 0}
        vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], options)
        vim.keymap.set('t', 'jk', [[<C-\><C-n>]], options)
        vim.keymap.set('t', '<C-h>', [[<C-\><C-n><C-W>h]], options)
        vim.keymap.set('t', '<C-j>', [[<C-\><C-n><C-W>j]], options)
        vim.keymap.set('t', '<C-k>', [[<C-\><C-n><C-W>k]], options)
        vim.keymap.set('t', '<C-l>', [[<C-\><C-n><C-W>l]], options)
      end

      vim.api.nvim_create_autocmd("TermOpen", {
        pattern = "term://*",
        callback = set_terminal_keymaps
      })
    end,
  }
}
