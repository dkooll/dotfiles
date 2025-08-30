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

-- Don't auto-comment new lines
opt.formatoptions:remove({ 'c', 'r', 'o' })

-- Remove trailing whitespace on save (optimized)
create_autocmd("BufWritePre", "*", function()
  local save_cursor = api.nvim_win_get_cursor(0)
  vim.cmd([[%s/\s\+$//e]])
  api.nvim_win_set_cursor(0, save_cursor)
end)

-- YAML color scheme (using helper function)
create_autocmd("ColorScheme", "*", function()
  api.nvim_set_hl(0, '@keyword.directive', { fg = "#9E8069" })

  -- Clear cursor line
  api.nvim_set_hl(0, 'CursorLine', { bg = 'NONE' })

  -- Fold colors
  api.nvim_set_hl(0, 'FoldColumn', { fg = '#9E8069', bg = 'NONE' })
  api.nvim_set_hl(0, 'Folded', { fg = '#9E8069', bg = 'NONE' })
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

-- Terraform filetype detection and highlighting
create_autocmd({ "BufRead", "BufNewFile" }, { "*.tf", "*.tfvars", "*.tfstate" }, function()
  vim.bo.filetype = "terraform"
end)

create_autocmd("FileType", "terraform", function()
  -- Ensure syntax highlighting is properly applied
  vim.schedule(function()
    if vim.fn.exists(":TSBufEnable") > 0 then
      vim.cmd("TSBufEnable highlight")
    end
  end)
end)
