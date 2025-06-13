return {
  {
    "zbirenbaum/copilot.lua",
    enabled = true,
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        panel = {
          enabled = true,
          auto_refresh = true,
          keymap = {
            jump_next = "<c-j>",
            jump_prev = "<c-k>",
            accept = "<c-a>",
            refresh = "r",
            open = "<M-CR>",
          },
          layout = {
            position = "bottom",
            ratio = 0.4,
          },
        },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = "<c-a>",
            accept_word = false,
            accept_line = false,
            next = "<c-j>",
            prev = "<c-k>",
            dismiss = "<C-e>",
          },
        },
      })
    end
  },
  {
    "zbirenbaum/copilot-cmp",
    after = { "copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    build = "make tiktoken",
    keys = {
      { "<leader>cn", "<cmd>CopilotChat<cr>",          desc = "CopilotChat: New chat" },
      { "<leader>co", "<cmd>CopilotChatOpen<cr>",      desc = "CopilotChat: Open existing chat" },
      { "<leader>cc", "<cmd>CopilotChatClose<cr>",     desc = "CopilotChat: Close chat window" },
      { "<leader>ct", "<cmd>CopilotChatToggle<cr>",    desc = "CopilotChat: Toggle chat window" },
      { "<leader>cs", "<cmd>CopilotChatStop<cr>",      desc = "CopilotChat: Stop chat" },
      { "<leader>cR", "<cmd>CopilotChatReset<cr>",     desc = "CopilotChat: Reset chat" },
      { "<leader>cv", "<cmd>CopilotChatSave<cr>",      desc = "CopilotChat: Save chat" },
      { "<leader>cl", "<cmd>CopilotChatLoad<cr>",      desc = "CopilotChat: Load chat" },
      { "<leader>cD", "<cmd>CopilotChatDebugInfo<cr>", desc = "CopilotChat: Debug info" },
      { "<leader>cm", "<cmd>CopilotChatModels<cr>",    desc = "CopilotChat: List models" },
      { "<leader>ca", "<cmd>CopilotChatAgents<cr>",    desc = "CopilotChat: List agents" },
      { "<leader>ce", "<cmd>CopilotChatExplain<cr>",   desc = "CopilotChat: Explain code" },
      { "<leader>cr", "<cmd>CopilotChatReview<cr>",    desc = "CopilotChat: Review code" },
      { "<leader>cf", "<cmd>CopilotChatFix<cr>",       desc = "CopilotChat: Fix code" },
      { "<leader>cO", "<cmd>CopilotChatOptimize<cr>",  desc = "CopilotChat: Optimize code" },
      { "<leader>cd", "<cmd>CopilotChatDocs<cr>",      desc = "CopilotChat: Documentation" },
      { "<leader>cg", "<cmd>CopilotChatTests<cr>",     desc = "CopilotChat: Generate tests" },
      { "<leader>ck", "<cmd>CopilotChatCommit<cr>",    desc = "CopilotChat: Generate commit" },
    },
    opts = {
      model = "gpt-4o",
      show_help = false,
      separator = "",
      show_folds = false,
      window = {
        layout = 'vertical',
        border = 'none',
      },
      mappings = {
        complete = {
          insert = '<Tab>',
        },
        close = {
          normal = 'q',
          insert = '<C-c>',
        },
        reset = {
          normal = '<C-l><C-l>',
          insert = '<C-x>',
        },
        submit_prompt = {
          normal = '<CR>',   -- Changed to Enter key for normal mode
          insert = '<C-CR>', -- Changed to Ctrl+Enter for insert mode
        },
        accept_diff = {
          normal = '<C-y>',
          insert = '<C-y>',
        },
        yank_diff = {
          normal = 'gy',
        },
        show_diff = {
          normal = 'gd',
        },
        show_system_prompt = {
          normal = 'gc',
        },
        show_info = {
          normal = 'gi',
        },
        show_context = {
          normal = 'gs',
        },
      }
    },
  }
}
