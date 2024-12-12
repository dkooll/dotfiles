return {
  "sindrets/diffview.nvim",
  keys = {
    { "<leader>gh", "<cmd>DiffviewFileHistory<CR>", desc = "Diffview: Git Diff View File History" },
  },
  config = function()
    require("diffview").setup({})
  end,
}


--return {
  --"sindrets/diffview.nvim",
  --lazy = true,
  --keys = {
    --{ "<leader>gd", "<cmd>DiffviewFileHistory<CR>", desc = "Diffview: Git Diff View File History" },
  --},
  --config = function()
    --require("diffview").setup({
      --view = {
        --default = {
          --layout = "diff2_horizontal",
          --disable_diagnostics = false,
        --},
      --},
    --})
  --end,
--}


--return {
  --"sindrets/diffview.nvim",
  --lazy = true,
  --keys = {
    --{ "<leader>gd", "<cmd>DiffviewFileHistory<CR>", desc = "Diffview: Git Diff Vieuw File History" },
  --},
--}


--return {
  --"sindrets/diffview.nvim",
--}
