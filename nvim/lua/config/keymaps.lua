local opts = { noremap = true, silent = true }

local navigation_keys = {
  Up = "k",
  Down = "j",
  Left = "h",
  Right = "l",
}

local map = vim.keymap.set

-- TODO: add different keymap

-- Keep cursor centered when scrolling
--vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
--vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)

-- Move selected line / block of text in visual mode
vim.keymap.set("v", "<S-k>", ":m '<-2<CR>gv=gv", { silent = true })
vim.keymap.set("v", "<S-j>", ":m '>+1<CR>gv=gv", { silent = true })

-- map("n", "<C-Space>", ":WhichKey \\<space><cr>", opts)
map("n", "<C-d>", "<C-d>zz", opts)
map("n", "<C-u>", "<C-u>zz", opts)
map("v", "J", ":m '>+1<CR>gv=gv", opts)
map("v", "K", ":m '<-2<CR>gv=gv", opts)
map("n", "<leader><leader>", ":Telescope buffers<CR>", opts)
map("n", "m", "ciw", opts)

-- Remap for dealing with visual line wraps
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- paste over currently selected text without yanking it
map("v", "p", '"_dp')
map("v", "P", '"_dP')

-- Fast saving
vim.keymap.set('n', 'w', ':write!<CR>')
vim.keymap.set('n', 'q', ':q!<CR>', { silent = true })

-- Exit on jj and jk
vim.keymap.set('i', 'jj', '<ESC>')
vim.keymap.set('i', 'jk', '<ESC>')

for key, cmd in pairs(navigation_keys) do
  -- Navigate between windows in Normal mode
  vim.keymap.set("n", "<Esc><" .. key .. ">", ":wincmd " .. cmd .. "<CR>", { noremap = true })

  -- Use Option (Meta) + arrow keys to navigate between windows in Terminal mode
  vim.keymap.set("t", "<M-" .. key .. ">", "<C-\\><C-n>:wincmd " .. cmd .. "<CR>", { noremap = true })
end
