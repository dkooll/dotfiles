return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "github/copilot.vim" },
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
      show_help = false,
      separator = "",
      show_folds = false,
      window = {
        layout = 'vertical',
        border = 'none',
      }
    },
  },
}
