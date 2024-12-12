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
  defaults = { lazy = true },
  install = { missing = true },
  performance = {
    cache = { enabled = true },
    reset_packpath = true,
    rtp = {
      reset = true,
      disabled_plugins = {
        "gzip", "matchit", "matchparen",
        "netrwPlugin", "tarPlugin", "tohtml",
        "tutor", "zipPlugin"
      },
    },
  },
  ui = { border = "rounded" },
  checker = { enabled = true, notify = false },  -- Re-enabled plugin updates
  change_detection = { enabled = true, notify = false },  -- Re-enabled config change detection
  debug = false,
})


-- local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- if vim.fn.empty(vim.fn.glob(lazypath)) == 1 then
--   vim.fn.system({
--     "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git",
--     "--branch=stable", lazypath,
--   })
-- end
-- vim.opt.rtp:prepend(lazypath)
--
-- require("lazy").setup("plugins", {
--   defaults = { lazy = true },
--   install = { missing = true },
--   performance = {
--     cache = { enabled = true },
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
--   ui = { border = "rounded" },
--   checker = { enabled = false },
--   change_detection = { enabled = false },
--   debug = false,
-- })

-- local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
--
-- -- Check if lazy.nvim is installed
-- local lazy_exists = vim.fn.empty(vim.fn.glob(lazypath)) == 0
--
-- if not lazy_exists then
--   print("Installing lazy.nvim...")
--   vim.fn.system({
--     "git",
--     "clone",
--     "--filter=blob:none",
--     "https://github.com/folke/lazy.nvim.git",
--     "--branch=stable",
--     lazypath,
--   })
--   print("lazy.nvim installed successfully!")
-- end
--
-- vim.opt.rtp:prepend(lazypath)
--
-- -- Lazy.nvim setup
-- require("lazy").setup("plugins", {
--   install = {
--     missing = true,
--   },
--   checker = {
--     enabled = true,
--     notify = false,
--   },
--   change_detection = {
--     enabled = true,
--     notify = false,
--   },
--   performance = {
--     rtp = {
--       disabled_plugins = {
--         "gzip",
--         "tarPlugin",
--         "tohtml",
--         "tutor",
--         "zipPlugin",
--         "netrwPlugin",
--         "matchit",
--       },
--     },
--   },
--   ui = {
--     size = { width = 0.8, height = 0.8 },
--     wrap = true,
--     border = "rounded",
--   },
--   debug = false,
-- })
