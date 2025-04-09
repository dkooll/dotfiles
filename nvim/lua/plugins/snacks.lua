return {
  {
    "folke/snacks.nvim",
    lazy = true,
    keys = {
      -- { "<leader>gn", function() require("snacks").notifier.show_history() end, desc = "Show Notification History" },
      { "<leader>gB", function() require("snacks").gitbrowse() end,      desc = "Snacks: Git Browse" },
      { "<leader>gb", function() require("snacks").git.blame_line() end, desc = "Snacks: Git Blame Line" },
      -- { "<leader>gf", function() require("snacks").lazygit.log_file() end,                               desc = "Snacks: Lazygit File History" },
      -- { "<leader>gz", function() require("snacks").lazygit() end,                                        desc = "Snacks: Lazygit" },
      -- { "<leader>gl", function() require("snacks").lazygit.log() end,                                    desc = "Snacks: Lazygit Log" },
      -- { "<leader>.",  function() require("snacks").scratch() end,        desc = "Toggle Scratch Buffer" },
      -- { "<leader>S",  function() require("snacks").scratch.select() end, desc = "Select Scratch Buffer" },
      --     {
      --     "<leader>.",
      --     function()
      --       require("snacks").scratch({
      --         layout = {
      --           hidden = { "preview" },
      --           preset = "ivy_split",
      --           layout = {
      --             width = 0.8,   -- 80% of screen width
      --             height = 0.25, -- 30% of screen height
      --           },
      --         }
      --       })
      --     end,
      --     desc = "Snacks: Scratch Buffer"},
      --
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
