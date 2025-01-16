local api = vim.api
local opt = vim.opt

local myGroup = api.nvim_create_augroup("MyAutocmds", { clear = true })

-- Helper for creating autocommands
local function create_autocmd(event, pattern, callback)
  api.nvim_create_autocmd(event, {
    pattern = pattern,
    callback = callback,
    group = myGroup,
  })
end

-- Don’t auto-comment new lines
opt.formatoptions:remove({ 'c', 'r', 'o' })

-- Remove trailing whitespace on save (Lua-based removal)
create_autocmd("BufWritePre", "*", function()
  local line_count = api.nvim_buf_line_count(0)
  for i = 1, line_count do
    local line = api.nvim_buf_get_lines(0, i - 1, i, false)[1]
    if line then
      local trimmed = line:gsub("%s+$", "")
      if trimmed ~= line then
        api.nvim_buf_set_lines(0, i - 1, i, false, { trimmed })
      end
    end
  end
end)

-- Wrap words in mail buffers
create_autocmd("FileType", "mail", function()
  opt.wrap = true
  opt.linebreak = true
  opt.colorcolumn = '80'
end)

-- Highlight on yank
api.nvim_set_hl(0, 'YankHighlight', { fg = '#9E8069', bg = 'NONE' })
create_autocmd("TextYankPost", "*", function()
  vim.highlight.on_yank({ higroup = 'YankHighlight', timeout = 300 })
end)

-- Go to last location when opening a file
create_autocmd("BufReadPost", "*", function()
  local mark = api.nvim_buf_get_mark(0, '"')
  local lcount = api.nvim_buf_line_count(0)
  if mark[1] > 0 and mark[1] <= lcount then
    pcall(api.nvim_win_set_cursor, 0, mark)
  end
end)

-- Close man pages with 'q'
create_autocmd("FileType", "man", function()
  vim.keymap.set('n', 'q', ':quit<CR>', { buffer = true, silent = true })
end)

-- Clear cursor line after colorscheme load
create_autocmd("ColorScheme", "*", function()
  api.nvim_set_hl(0, 'CursorLine', { bg = 'NONE' })
end)

-- Enable spell checking for text-like files
create_autocmd({ "BufRead", "BufNewFile" }, { "*.txt", "*.md", "*.tex" }, function()
  opt.spell = false
  opt.spelllang = { "en", "de" }
end)

-- Keymaps when LSP attaches
create_autocmd("LspAttach", "*", function(ev)
  vim.keymap.set('n', '<leader>v', function()
    vim.cmd('vsplit')
    vim.lsp.buf.definition()
  end, { buffer = ev.buf })
end)

-- Set Terraform filetype
create_autocmd({ "BufRead", "BufNewFile" }, { "*.tf", "*.tfvars", "*.tfstate" }, function()
  vim.bo.filetype = "terraform"
end)
