return {
  'akinsho/toggleterm.nvim',
  version = "*",
  config = function()
    local Terminal = require("toggleterm.terminal").Terminal

    -- Horizontal Terminal
    local horizontal_terminal = Terminal:new({
      cmd = "zsh",
      direction = "horizontal",
      size = 90,
    })

    _G.toggle_horizontal_terminal = function()
      horizontal_terminal:toggle()
      vim.cmd("startinsert")
    end

    vim.cmd('command! ToggleTerm lua _G.toggle_horizontal_terminal()')

    _G.resize_horizontal_toggleterm = function(percentage)
      horizontal_terminal:resize(math.floor(vim.o.lines * (percentage / 100)))
      vim.cmd("startinsert")
    end

    vim.cmd("command! -nargs=1 ResizeHorizontalToggleTerm lua _G.resize_horizontal_toggleterm(<args>)")

    -- Vertical Terminal
    local vertical_terminal = Terminal:new({
      cmd = "zsh",
      direction = "vertical",
      size = 90,
    })

    _G.toggle_vertical_terminal = function()
      vertical_terminal:toggle()
      vim.cmd("startinsert")
      if vertical_terminal:is_open() then
        _G.resize_vertical_toggleterm(50)
      end
    end

    vim.cmd('command! ToggleVertTerm lua _G.toggle_vertical_terminal()')

    _G.resize_vertical_toggleterm = function(percentage)
      vertical_terminal:resize(math.floor(vim.o.columns * (percentage / 100)))
      vim.cmd("startinsert")
    end

    vim.cmd("command! -nargs=1 ResizeVerticalToggleTerm lua _G.resize_vertical_toggleterm(<args>)")

    -- Key mappings for horizontal terminal
    vim.api.nvim_set_keymap("t", "<F1>", "<C-\\><C-n>:ResizeHorizontalToggleTerm 25<CR>", { noremap = true })
    vim.api.nvim_set_keymap("t", "<F2>", "<C-\\><C-n>:ResizeHorizontalToggleTerm 50<CR>", { noremap = true })
    vim.api.nvim_set_keymap("t", "<F3>", "<C-\\><C-n>:ResizeHorizontalToggleTerm 75<CR>", { noremap = true })
    vim.api.nvim_set_keymap("t", "<F4>", "<C-\\><C-n>:ResizeHorizontalToggleTerm 100<CR>", { noremap = true })

    -- Key mappings for vertical terminal
    vim.api.nvim_set_keymap("t", "<F5>", "<C-\\><C-n>:ResizeVerticalToggleTerm 25<CR>", { noremap = true })
    vim.api.nvim_set_keymap("t", "<F6>", "<C-\\><C-n>:ResizeVerticalToggleTerm 50<CR>", { noremap = true })
    vim.api.nvim_set_keymap("t", "<F7>", "<C-\\><C-n>:ResizeVerticalToggleTerm 75<CR>", { noremap = true })
    vim.api.nvim_set_keymap("t", "<F8>", "<C-\\><C-n>:ResizeVerticalToggleTerm 100<CR>", { noremap = true })

    -- Key mappings to toggle terminals
    vim.api.nvim_set_keymap("n", "<C-\\>", ":ToggleTerm<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<C-_>", ":ToggleVertTerm<CR>", { noremap = true, silent = true })

    require("toggleterm").setup {
      direction = "horizontal",
      size = 30,
      open_mapping = [[<C-\>]],
      shade_terminals = true,
      shading_factor = 0
    }

    vim.cmd([[
      augroup ToggleTermInsertMode
        autocmd!
        autocmd BufEnter term://* startinsert
        autocmd BufLeave term://* stopinsert
      augroup END
    ]])
  end,
}
