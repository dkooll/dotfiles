return {
  {
    "folke/snacks.nvim",
    lazy = true,
    keys = {
      -- { "<leader>gn", function() require("snacks").notifier.show_history() end, desc = "Show Notification History" },
      { "<leader>gB", function() require("snacks").gitbrowse() end,             desc = "Snacks: Git Browse" },
      { "<leader>gb", function() require("snacks").git.blame_line() end,        desc = "Snacks: Git Blame Line" },
      { "<leader>gf", function() require("snacks").lazygit.log_file() end,      desc = "Snacks: Lazygit File History" },
      { "<leader>gz", function() require("snacks").lazygit() end,               desc = "Snacks: Lazygit" },
      { "<leader>gl", function() require("snacks").lazygit.log() end,           desc = "Snacks: Lazygit Log" },
    },
    opts = {
      notifier = {
        enabled = false,
        timeout = 3000,
      },
      styles = {
        notification = {
          wo = { wrap = true },
        },
      },
    },
    init = function()
    end,
  },
}

-- return {
--   {
--     "folke/snacks.nvim",
--     lazy = false,
--     keys = {
--       { "<leader>gn", function() require("snacks").notifier.show_history() end, desc = "Show Notification History" },
--       { "<leader>gB", function() require("snacks").gitbrowse() end,             desc = "Snacks: Git Browse" },
--       { "<leader>gb", function() require("snacks").git.blame_line() end,        desc = "Snacks: Git Blame Line" },
--       { "<leader>gf", function() require("snacks").lazygit.log_file() end,      desc = "Snacks: Lazygit File History" },
--       { "<leader>gz", function() require("snacks").lazygit() end,               desc = "Snacks: Lazygit" },
--       { "<leader>gl", function() require("snacks").lazygit.log() end,           desc = "Snacks: Lazygit Log" },
--     },
--     opts = {
--       notifier = {
--         enabled = true,
--         timeout = 3000,
--         style = "minimal", -- Use "minimal" style for borderless notifications
--         icons = {          -- Remove all symbols
--           error = "",
--           warn = "",
--           info = "",
--           debug = "",
--           trace = "",
--         },
--       },
--       styles = {
--         notification = {
--           border = "none", -- Remove borders entirely
--           wo = { wrap = true },
--         },
--       },
--     },
--     init = function()
--     end,
--   },
-- }
