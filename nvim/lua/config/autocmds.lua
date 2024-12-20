local api = vim.api
local opt = vim.opt

-- Create a general augroup
local myGroup = api.nvim_create_augroup("MyAutocmds", { clear = true })

-- Helper function for creating autocommands
local function autocmd(event, pattern, callback)
  api.nvim_create_autocmd(event, {
    pattern = pattern,
    callback = callback,
    group = myGroup,
  })
end

-- Don't auto comment new lines
opt.formatoptions:remove({ 'c', 'r', 'o' })

-- Remove all trailing whitespace on save
autocmd("BufWritePre", "*", function()
  vim.cmd([[keeppatterns %s/\s\+$//e]])
end)

-- Wrap words "softly" in mail buffers
autocmd("FileType", "mail", function()
  opt.wrap = true
  opt.linebreak = true
  opt.colorcolumn = "80"
end)

-- Highlight on yank
api.nvim_set_hl(0, 'YankHighlight', { fg = '#9E8069', bg = 'NONE' })
autocmd("TextYankPost", "*", function()
  vim.highlight.on_yank({ higroup = 'YankHighlight', timeout = 300 })
end)

-- Go to last location when opening a buffer
autocmd("BufReadPost", "*", function()
  local mark = api.nvim_buf_get_mark(0, '"')
  local lcount = api.nvim_buf_line_count(0)
  if mark[1] > 0 and mark[1] <= lcount then
    pcall(api.nvim_win_set_cursor, 0, mark)
  end
end)

-- Set 'q' to quit in man pages
autocmd("FileType", "man", function()
  vim.keymap.set('n', 'q', ':quit<CR>', { buffer = true, silent = true })
end)

-- Apply the cursor line highlight after any colorscheme is loaded
autocmd("ColorScheme", "*", function()
  api.nvim_set_hl(0, 'CursorLine', { bg = 'NONE' })
end)

-- Enable spell checking for certain file types
autocmd({ "BufRead", "BufNewFile" }, { "*.txt", "*.md", "*.tex" }, function()
  opt.spell = true
  opt.spelllang = { "en", "de" }
end)

-- Map keys after LSP attaches to the buffer
autocmd('LspAttach', '*', function(ev)
  vim.keymap.set('n', '<leader>v', function()
    vim.cmd('vsplit')
    vim.lsp.buf.definition()
  end, { buffer = ev.buf })
end)

-- Set filetype for Terraform files
autocmd({ "BufRead", "BufNewFile" }, { "*.tf", "*.tfvars", "*.tfstate" }, function()
  vim.bo.filetype = "terraform"
end)
