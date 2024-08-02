return {
  "dkooll/workspace.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  config = function()
    local workspace = require("workspace")

    workspace.setup({
      workspaces = {
        { name = "cloudnation-wam", path = "~/Documents/workspaces", keymap = { "<leader>ws" } },
      }
    })
    vim.keymap.set('n', '<leader>ms', workspace.tmux_sessions)
  end,
}
