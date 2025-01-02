return {
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    ft = { "go", "gomod", "gowork", "gotmpl" },
    opts = {
      lsp_cfg = true,
      lsp_on_attach = true,
      go_silent_install = true,
      luasnip = false,
      dap_debug = false,
      lsp_codelens = false,
      lsp_inlay_hints = { enable = false },
      lsp_keymaps = false,
      diagnostic = {
        virtual_text = false,
        hdlr = false,
      },
      gopls_cmd = { "gopls" },
      gopls_settings = {
        staticcheck = true,
        gofumpt = true,
        analyses = {
          unusedparams = false,
          shadow = false,
        },
        experimentalWorkspaceModule = false,
        memoryMode = "Normal",
        expandWorkspaceToModule = false,
        templateExtensions = false,
        completionBudget = "100ms",
        diagnosticsDelay = "250ms",
        symbolScope = "workspace",
        matcher = "fuzzy",
        diagnosticStyle = "instant",
      },
    },
    keys = {
      -- LSP format
      { "<leader>lf",  function() vim.lsp.buf.format({ async = true }) end, desc = "Format file" },

      -- Main Go commands
      -- { "<leader>gi",  "<cmd>GoInstallDeps<cr>",                            desc = "Install Go Dependencies" },
      -- { "<leader>go",  "<cmd>GoPkgOutline<cr>",                             desc = "Outline" },
      -- { "<leader>gI",  "<cmd>GoToggleInlay<cr>",                            desc = "Toggle inlay" },
      -- { "<leader>gg",  "<cmd>GoGenerate<cr>",                               desc = "Go Generate" },
      -- { "<leader>gG",  "<cmd>GoGenerate %<cr>",                             desc = "Go Generate File" },
      -- { "<leader>gc",  "<cmd>GoCmt<cr>",                                    desc = "Generate Comment" },
      -- { "<leader>gs",  "<cmd>GoFillStruct<cr>",                             desc = "Autofill struct" },
      -- { "<leader>gj",  "<cmd>'<,'>GoJson2Struct<cr>",                       desc = "Json to struct" },

      -- Helper submenu
      -- { "<leader>gha", "<cmd>GoAddTag<cr>",                                 desc = "Add tags to struct" },
      -- { "<leader>ghr", "<cmd>GoRMTag<cr>",                                  desc = "Remove tags to struct" },
      -- { "<leader>ghc", "<cmd>GoCoverage<cr>",                               desc = "Test coverage" },
      -- { "<leader>ghv", "<cmd>GoVet<cr>",                                    desc = "Go vet" },
      -- { "<leader>ght", "<cmd>GoModTidy<cr>",                                desc = "Go mod tidy" },
      -- { "<leader>ghi", "<cmd>GoModInit<cr>",                                desc = "Go mod init" },

      -- Tests submenu
      -- { "<leader>gtr", "<cmd>GoTest<cr>",                                   desc = "Run tests" },
      -- { "<leader>gta", "<cmd>GoAlt!<cr>",                                   desc = "Open alt file" },
      -- { "<leader>gts", "<cmd>GoAltS!<cr>",                                  desc = "Open alt file in split" },
      -- { "<leader>gtv", "<cmd>GoAltV!<cr>",                                  desc = "Open alt file in vertical split" },
      -- { "<leader>gtu", "<cmd>GoTestFunc<cr>",                               desc = "Run test for current func" },
      -- { "<leader>gtf", "<cmd>GoTestFile<cr>",                               desc = "Run test for current file" },
      -- { "<leader>gtT", "<cmd>GoTestAdd<cr>",                                desc = "Add Test" },
      -- { "<leader>gtA", "<cmd>GoTestsAll<cr>",                               desc = "Add All Tests" },
      -- { "<leader>gte", "<cmd>GoTestsExp<cr>",                               desc = "Add Exported Tests" },

      -- Code Lens submenu
      -- { "<leader>gxl", "<cmd>GoCodeLenAct<cr>",                             desc = "Toggle Lens" },
      -- { "<leader>gxa", "<cmd>GoCodeAction<cr>",                             desc = "Code Action" },
    },
    config = function(_, opts)
      require("go").setup(opts)
    end,
  }
}
