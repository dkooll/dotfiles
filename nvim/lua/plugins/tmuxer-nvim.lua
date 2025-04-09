return {
  "dkooll/tmuxer.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  opts = {
    max_depth = 2,
    theme = "ivy",
    previewer = false,
    border = true,
    layout_config = {
      width = 0.5,
      height = 0.31,
    }
  },
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
