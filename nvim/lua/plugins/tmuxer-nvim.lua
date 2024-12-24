return {
  "dkooll/tmuxer.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  keys = {
    {
      "<leader>tc",
      function()
        require("tmuxer").open_workspace_popup(
          { name = "workspaces", path = "~/Documents/workspaces" }
        )
      end,
      desc = "Tmuxer: Create Tmux Session"
    },
    {
      "<leader>ts",
      function()
        require("tmuxer").tmux_sessions()
      end,
      desc = "Tmuxer: Switch Tmux Session"
    },
  },
}
