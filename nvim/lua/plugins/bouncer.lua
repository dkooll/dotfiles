return {
  "dkooll/bouncer.nvim",
  dependencies = { "folke/snacks.nvim" },

  lazy = true,
  cmd = { "BounceModuleToLocal", "BounceModuleToRegistry", "BounceModulesToRegistry" },
  keys = {
    { "<leader>bl", ":BounceModuleToLocal<CR>",     desc = "Bouncer: Change Current Module to Local" },
    { "<leader>br", ":BounceModuleToRegistry<CR>",  desc = "Bouncer: Change Current Module to Registry" },
    { "<leader>ba", ":BounceModulesToRegistry<CR>", desc = "Bouncer: Change All Modules to Registry" },
  },
  config = function()
    require("bouncer").setup({
      namespace = "cloudnationhq",
    })
  end,
}
