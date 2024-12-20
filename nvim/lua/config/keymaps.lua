local opts = { noremap = true, silent = true }

local navigation_keys = {
  Up = "k",
  Down = "j",
  Left = "h",
  Right = "l",
}

local map = vim.keymap.set

-- Move selected line / block of text in visual mode
vim.keymap.set("v", "<S-k>", ":m '<-2<CR>gv=gv", { silent = true })
vim.keymap.set("v", "<S-j>", ":m '>+1<CR>gv=gv", { silent = true })

-- scrolls up and down half a page centered
map("n", "<C-d>", "<C-d>zz", opts)
map("n", "<C-u>", "<C-u>zz", opts)

-- Remap for dealing with visual line wraps
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- paste over currently selected text without yanking it
map("v", "p", '"_dp')
map("v", "P", '"_dP')

vim.keymap.set('n', 'w', ':write!<CR>')
vim.keymap.set('n', 'q', ':q!<CR>', { silent = true })
map("n", "m", "ciw", opts)

-- Left Option/Alt + numbers for percentage-based window sizing vertically
map("n", "¡", "<cmd>vertical resize 90<CR>", opts)     -- Option + 1 -> 25%
map("n", "€", "<cmd>vertical resize 135<CR>", opts)    -- Option + 2 -> 35%
map("n", "£", "<cmd>vertical resize 180<CR>", opts)    -- Option + 3 -> 50%
map("n", "¢", "<cmd>vertical resize 360<CR>", opts)    -- Option + 4 -> 100%

for key, cmd in pairs(navigation_keys) do
  -- Navigate between windows in Normal mode
  vim.keymap.set("n", "<Esc><" .. key .. ">", ":wincmd " .. cmd .. "<CR>", { noremap = true })

  -- Use Option (Meta) + arrow keys to navigate between windows in Terminal mode
  vim.keymap.set("t", "<M-" .. key .. ">", "<C-\\><C-n>:wincmd " .. cmd .. "<CR>", { noremap = true })
end
