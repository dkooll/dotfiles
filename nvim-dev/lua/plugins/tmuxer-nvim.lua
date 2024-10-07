-- .TODO: change commands to TmuxCreate and TmuxSwitch
--  create control D support for killing sessions
return {
  "dkooll/tmuxer.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  cmd = { "WorkspaceOpen", "TmuxSessions" },
  keys = {
    { "tc", "<cmd>WorkspaceOpen<cr>", desc = "create tmux session" },
    { "ts", "<cmd>TmuxSessions<cr>",  desc = "switch tmux session" },
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
