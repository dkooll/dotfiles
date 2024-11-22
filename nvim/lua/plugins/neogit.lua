return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",         -- required
    "sindrets/diffview.nvim",        -- optional - Diff integration
    "nvim-telescope/telescope.nvim", -- optional
    -- "ibhagwan/fzf-lua",           -- optional (commented out)
    -- "echasnovski/mini.pick",      -- optional (commented out)
  },
  cmd = "Neogit",
  keys = {
    { "<leader>gg", "<cmd>Neogit<CR>", desc = "Open Neogit" },
  },
  opts = {
    -- Add any Neogit-specific options here
  },
  config = function(_, opts)
    require("neogit").setup(opts)
  end,
}
