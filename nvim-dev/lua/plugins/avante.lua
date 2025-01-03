return {
  {
    "yetone/avante.nvim",
    lazy = true,
    keys = {
      { "<leader>aa",  "<cmd>AvanteToggle<cr>",                 desc = "Avante: Show sidebar" },
      { "<leader>ar",  "<cmd>AvanteRefresh<cr>",                desc = "Avante: Refresh sidebar" },
      { "<leader>af",  "<cmd>AvanteFocus<cr>",                  desc = "Avante: Switch sidebar focus" },
      { "<leader>ae",  "<cmd>AvanteEdit<cr>",                   desc = "Avante: Edit selected blocks" },
      { "<leader>aC",  "<cmd>AvanteClear<cr>",                  desc = "Avante: Clear" },
      { "<leader>aR",  "<cmd>AvanteShowRepoMap<cr>",            desc = "Avante: Show Repo Map" },
      { "<leader>asc", "<cmd>AvanteSwitchProvider claude<cr>",  desc = "Avante: Switch provider claude" },
      { "<leader>asC", "<cmd>AvanteSwitchProvider copilot<cr>", desc = "Avante: Switch provider copilot" },
      { "<leader>aso", "<cmd>AvanteSwitchProvider openai<cr>",  desc = "Avante: Switch provider openai" },
      { "<leader>asg", "<cmd>AvanteSwitchProvider gemini<cr>",  desc = "Avante: Switch provider gemini" },
      { "co",          "<cmd>AvanteChooseOurs<cr>",             desc = "Avante: Choose ours" },
      { "ct",          "<cmd>AvanteChooseTheirs<cr>",           desc = "Avante: Choose theirs" },
      { "ca",          "<cmd>AvanteChooseAllTheirs<cr>",        desc = "Avante: Choose all theirs" },
      { "c0",          "<cmd>AvanteChooseNone<cr>",             desc = "Avante: Choose none" },
      { "cb",          "<cmd>AvanteChooseBoth<cr>",             desc = "Avante: Choose both" },
      { "cc",          "<cmd>AvanteChooseCursor<cr>",           desc = "Avante: Choose cursor" },
      { "]x",          "<cmd>AvanteNextConflict<cr>",           desc = "Avante: Next conflict" },
      { "[x",          "<cmd>AvantePrevConflict<cr>",           desc = "Avante: Previous conflict" },
      { "[[",          "<cmd>AvantePrevCodeblock<cr>",          desc = "Avante: Previous codeblock" },
      { "]]",          "<cmd>AvanteNextCodeblock<cr>",          desc = "Avante: Next codeblock" },

    },
    version = false,
    opts = {},
    build = "make",
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "hrsh7th/nvim-cmp",
      "nvim-tree/nvim-web-devicons",
      "zbirenbaum/copilot.lua",
      {
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  }
}