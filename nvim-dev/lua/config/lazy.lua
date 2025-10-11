local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if vim.fn.empty(vim.fn.glob(lazypath)) == 1 then
  vim.fn.system({
    "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.keymap.set("n", "<leader>L", "<cmd>Lazy update<CR>", { desc = "Lazy: Update plugins" })

require("lazy").setup("plugins", {
  defaults = {
    lazy = true,
    version = false,
  },
  install = {
    missing = true,
    colorscheme = { "catppuccin" },
  },
  performance = {
    cache = {
      enabled = true,
    },
    reset_packpath = true,
    rtp = {
      reset = true,
      paths = {},
      disabled_plugins = {
        "gzip", "matchit", "matchparen", "netrwPlugin",
        "tarPlugin", "tohtml", "tutor", "zipPlugin",
        "rplugin", "syntax", "synmenu", "optwin",
        "compiler", "bugreport", "ftplugin"
      },
    },
  },
  ui = {
    border = "rounded",
    backdrop = 60,
  },
  checker = {
    enabled = false,
  },
  change_detection = {
    enabled = false,
  },
  debug = false,
})
--
--
-- local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- if vim.fn.empty(vim.fn.glob(lazypath)) == 1 then
--   vim.fn.system({
--     "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git",
--     "--branch=stable", lazypath,
--   })
-- end
-- vim.opt.rtp:prepend(lazypath)
--
-- vim.keymap.set("n", "<leader>L", "<cmd>Lazy update<CR>", { desc = "Lazy: Update plugins" })
--
-- require("lazy").setup("plugins", {
--   defaults = {
--     lazy = true,
--     colorscheme = { "catppuccin" },
--   },
--   install = {
--     missing = true
--   },
--   performance = {
--     cache = {
--       enabled = true
--     },
--     reset_packpath = true,
--     rtp = {
--       reset = true,
--       disabled_plugins = {
--         "gzip", "matchit", "matchparen",
--         "netrwPlugin", "tarPlugin", "tohtml",
--         "tutor", "zipPlugin"
--       },
--     },
--   },
--   ui = {
--     border = "rounded",
--   },
--   checker = {
--     enabled = true,
--     notify = false
--   },
--   change_detection = {
--     enabled = true,
--     notify = false
--   },
--   debug = false,
-- })
--
-- -- Set transparent background for Lazy
-- vim.api.nvim_set_hl(0, 'LazyNormal', { bg = 'NONE' })
