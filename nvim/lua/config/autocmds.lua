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
