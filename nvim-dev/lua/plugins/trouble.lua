--return {
--"folke/trouble.nvim",
--dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
--keys = {
--{ "<leader>xx", "<cmd>TroubleToggle<CR>",                       desc = "Open/close trouble list" },
--{ "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<CR>", desc = "Open trouble workspace diagnostics" },
--{ "<leader>xd", "<cmd>TroubleToggle document_diagnostics<CR>",  desc = "Open trouble document diagnostics" },
--{ "<leader>xq", "<cmd>TroubleToggle quickfix<CR>",              desc = "Open trouble quickfix list" },
--{ "<leader>xl", "<cmd>TroubleToggle loclist<CR>",               desc = "Open trouble location list" },
--{ "<leader>xt", "<cmd>TodoTrouble<CR>",                         desc = "Open todos in trouble" },
--},
--}

--return {
--"stefandtw/quickfix-reflector.vim",
--config = function()
---- Plugin configuration
--vim.g.qf_modifiable = 1
--vim.g.qf_join_changes = 1
--vim.g.qf_write_changes = 1

---- Keymaps
--vim.api.nvim_set_keymap('n', '<leader>qo', ':copen<CR>', {noremap = true, silent = true})
--vim.api.nvim_set_keymap('n', '<leader>qc', ':cclose<CR>', {noremap = true, silent = true})
--vim.api.nvim_set_keymap('n', '<leader>qn', ':cnext<CR>', {noremap = true, silent = true})
--vim.api.nvim_set_keymap('n', '<leader>qp', ':cprevious<CR>', {noremap = true, silent = true})
--vim.api.nvim_set_keymap('n', '<leader>qf', ':cfirst<CR>', {noremap = true, silent = true})
--vim.api.nvim_set_keymap('n', '<leader>ql', ':clast<CR>', {noremap = true, silent = true})

---- Optional: Add a keymap to toggle the quickfix window
--vim.api.nvim_create_user_command('ToggleQF', function()
--local qf_exists = false
--for _, win in pairs(vim.fn.getwininfo()) do
--if win.quickfix == 1 then
--qf_exists = true
--end
--end
--if qf_exists == true then
--vim.cmd('cclose')
--else
--vim.cmd('copen')
--end
--end, {})
--vim.api.nvim_set_keymap('n', '<leader>qt', ':ToggleQF<CR>', {noremap = true, silent = true})
--end,
--}

return {
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  }
  --"folke/trouble.nvim",
  --dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
  --keys = {
  --{ "<leader>xx", "<cmd>TroubleToggle<cr>",                       desc = "Open/close trouble list" },
  --{ "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Open trouble workspace diagnostics" },
  --{ "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>",  desc = "Open trouble document diagnostics" },
  --{ "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",              desc = "Open trouble quickfix list" },
  --{ "<leader>xl", "<cmd>TroubleToggle loclist<cr>",               desc = "Open trouble location list" },
  --}
}

--return {
--"folke/trouble.nvim",
--cmd = { "TroubleToggle", "Trouble" },
--opts = { use_diagnostic_signs = true },
--lazy = true,
--config = function()
--require("trouble").setup {
----"workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist",
--mode = "workspace_diagnostics", "quickfix",
--position = "bottom", -- position of the list can be: bottom, top, left, right
--height = 15,
--padding = false,
--action_keys = {
---- key mappings for actions in the trouble list
--close = "q",                -- close the list
--cancel = "<esc>",           -- cancel the preview and get back to your last window / buffer / cursor
--refresh = "r",              -- manually refresh
--jump = { "<cr>", "<tab>" }, -- jump to the diagnostic or open / close folds
--open_split = { "<c-x>" },   -- open buffer in new split
--open_vsplit = { "<c-v>" },  -- open buffer in new vsplit
--pn_tab = { "<c-t>" },     -- open buffer in new tab
--jump_close = { "o" },       -- jump to the diagnostic and close the list
--toggle_mode = "m",          -- toggle between "workspace" and "document" diagnostics mode
--toggle_preview = "P",       -- toggle auto_preview
--hover = "K",                -- opens a small popup with the full multiline message
--preview = "p",              -- preview the diagnostic location
--close_folds = { "zM" },     -- close all folds
--open_folds = { "zR" },      -- open all foldsTroubleToggle
--toggle_fold = { "za" },     -- toggle fold of current file
--},
--auto_jump = {},
--use_diagnostic_signs = true,
--}
--end
--}
