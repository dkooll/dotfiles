local api = vim.api
local opt = vim.opt

-- Helper function for creating autocommands
local function autocmd(event, pattern, callback, group)
  api.nvim_create_autocmd(event, {
    pattern = pattern,
    callback = callback,
    group = group
  })
end

-- Don't auto comment new lines
opt.formatoptions:remove({ 'c', 'r', 'o' })

-- Remove all trailing whitespace on save
local TrimWhiteSpaceGrp = api.nvim_create_augroup("TrimWhiteSpaceGrp", { clear = true })
autocmd("BufWritePre", "*", function()
  local save_cursor = api.nvim_win_get_cursor(0)
  vim.cmd([[%s/\s\+$//e]])
  api.nvim_win_set_cursor(0, save_cursor)
end, TrimWhiteSpaceGrp)

-- Wrap words "softly" (no carriage return) in mail buffer
autocmd("FileType", "mail", function()
  opt.textwidth = 0
  opt.wrapmargin = 0
  opt.wrap = true
  opt.linebreak = true
  opt.columns = 80
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

-- Apply the cursor line highlight setting after any color scheme is loaded
local myGroup = api.nvim_create_augroup("MyColorSchemeFixes", { clear = true })
autocmd("ColorScheme", "*", function()
  api.nvim_set_hl(0, 'CursorLine', { bg = 'NONE' })
end, myGroup)

-- Enable spell checking for certain file types
autocmd({ "BufRead", "BufNewFile" }, { "*.txt", "*.md", "*.tex" }, function()
  opt.spell = false
  opt.spelllang = "en,de"
end)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
autocmd('LspAttach', '*', function(ev)
  vim.keymap.set('n', '<leader>v', "<cmd>vsplit | lua vim.lsp.buf.definition()<CR>", { buffer = ev.buf })
end)

-- Set filetype for Terraform files
autocmd({ "BufRead", "BufNewFile" }, { "*.tf", "*.tfvars", "*.tfstate" }, function()
  vim.bo.filetype = "terraform"
end)
