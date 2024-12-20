local opts = { noremap = true, silent = true }

-- window movement with option key + arrow keys
vim.keymap.set('n', '<M-Left>', '<C-w>h', opts)
vim.keymap.set('n', '<M-Down>', '<C-w>j', opts)
vim.keymap.set('n', '<M-Up>', '<C-w>k', opts)
vim.keymap.set('n', '<M-Right>', '<C-w>l', opts)

-- Move selected line / block of text in visual mode
vim.keymap.set("v", "<S-k>", ":m '<-2<CR>gv=gv", { silent = true })
vim.keymap.set("v", "<S-j>", ":m '>+1<CR>gv=gv", { silent = true })

-- scrolls up and down half a page centered
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)

-- Remap for dealing with visual line wraps
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- better indenting
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- paste over currently selected text without yanking it
vim.keymap.set("v", "p", '"_dp', opts)
vim.keymap.set("v", "P", '"_dP', opts)

-- quick save and quit
vim.keymap.set('n', 'w', ':write!<CR>', opts)
vim.keymap.set('n', 'q', ':q!<CR>', opts)

-- quick change word under cursor
vim.keymap.set("n", "m", "ciw", opts)

-- Resize windows with Option/Alt + or -
vim.keymap.set("n", "≠", "<cmd>vertical resize +10<CR>", opts)
vim.keymap.set("n", "–", "<cmd>vertical resize -10<CR>", opts)

-- Buffer management keymaps
vim.keymap.set("n", "<Tab>", ":bnext<CR>", opts)
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", opts)
