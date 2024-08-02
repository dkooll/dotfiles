return {
  "dkooll/tmuxer.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  cmd = { "WorkspaceOpen", "TmuxSessions" },
  keys = {
    { "<leader>ws", "<cmd>WorkspaceOpen<cr>", desc = "Open Workspace" },
    { "<leader>ms", "<cmd>TmuxSessions<cr>",  desc = "Tmux Sessions" },
  },
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
