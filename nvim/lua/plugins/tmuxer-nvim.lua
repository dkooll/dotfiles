return {
  "dkooll/tmuxer.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  cmd = { "WorkspaceOpen", "TmuxSessions" },
  keys = {
    { "<leader>tc", "<cmd>WorkspaceOpen<cr>", desc = "Tmuxer: Create Tmux Session" },
    { "<leader>ts", "<cmd>TmuxSessions<cr>",  desc = "Tmuxer: Switch Tmux Session" },
  },
  lazy = true,
  opts = {
    workspaces = {
      { name = "workspaces", path = "~/Documents/workspaces" },
    }
  },
  config = function(_, opts)
    local tmuxer = require("tmuxer")
    tmuxer.setup(opts)
    vim.api.nvim_create_user_command("WorkspaceOpen", function()
      tmuxer.open_workspace_popup(tmuxer.workspaces[1])
    end, {})
    vim.api.nvim_create_user_command("TmuxSessions", tmuxer.tmux_sessions, {})
  end,
}
