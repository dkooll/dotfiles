return {
  "echasnovski/mini.indentscope",
  version = false,
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    --symbol = "│",
    options = { try_as_border = true },
  },
  init = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
      callback = function()
        vim.b.miniindentscope_disable = true
      end,
    })
  end,
  config = function(_, opts)
    require("mini.indentscope").setup(opts)
    -- Set indent line color to light grey
    vim.api.nvim_set_hl(0, 'MiniIndentscopeSymbol', { fg = '#2F2F2F' })
  end,
}
