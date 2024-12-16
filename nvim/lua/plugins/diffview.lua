return {
  "sindrets/diffview.nvim",
  keys = {
    { "<leader>gh", "<cmd>DiffviewFileHistory<CR>", desc = "Diffview: Git Diff View File History" },
  },
  config = function()
    require("diffview").setup({})
  end,
}
