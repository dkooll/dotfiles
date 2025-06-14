return {
  "dkooll/tmuxer.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  config = function()
    require("tmuxer").setup({
      nvim_alias = "NVIM_APPNAME=nvim-dev nvim",
      max_depth = 2,
      theme = "ivy",
      previewer = false,
      border = true,
      parent_highlight = {
        fg = "#9E8069",
        bold = true,
      },
      layout_config = {
        width = 0.5,
        height = 0.31,
      }
    })
  end,
  keys = {
    {
      "<leader>tc",
      function()
        require("tmuxer").open_workspace_popup({
          name = "workspaces",
          path = "~/Documents/workspaces"
        })
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
