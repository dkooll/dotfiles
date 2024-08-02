return {
  "dkooll/tmuxer.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  cmd = { "WorkspaceOpen", "TmuxSessions" },
  keys = {
    { "<leader>mc", "<cmd>WorkspaceOpen<cr>", desc = "Create tmux session" },
    { "<leader>ms", "<cmd>TmuxSessions<cr>",  desc = "Switch tmux session" },
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
