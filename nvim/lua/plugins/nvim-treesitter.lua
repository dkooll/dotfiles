return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  opts = {
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = { enable = true },
    autotag = { enable = true },
    ensure_installed = {
      "bash",
      "dockerfile",
      "go",
      "gomod",
      "gosum",
      "json",
      "lua",
      "markdown",
      "markdown_inline",
      "python",
      "regex",
      "rust",
      "terraform",
      "vim",
      "yaml",
    },
    sync_install = false,
    auto_install = true,
    ignore_install = {},
    modules = {},
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<leader>vv",
        node_incremental = "<leader>vv",
        scope_incremental = false,
        node_decremental = "<BS>",
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
      },
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          ["]m"] = "@function.outer",
          ["]]"] = "@class.outer",
        },
        goto_next_end = {
          ["]M"] = "@function.outer",
          ["]["] = "@class.outer",
        },
        goto_previous_start = {
          ["[m"] = "@function.outer",
          ["[["] = "@class.outer",
        },
        goto_previous_end = {
          ["[M"] = "@function.outer",
          ["[]"] = "@class.outer",
        },
      },
    },
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}

--return {
--"nvim-treesitter/nvim-treesitter",
--event = { "BufReadPost", "BufNewFile" },
--build = ":TSUpdate",
--dependencies = {
--"windwp/nvim-ts-autotag",
--"nvim-treesitter/nvim-treesitter-textobjects",
--},
--config = function()
--local treesitter = require("nvim-treesitter.configs")

--treesitter.setup({
--highlight = {
--enable = true,
--},
--indent = {
--enable = true,
--},
--autotag = {
--enable = true,
--},
--ensure_installed = {
--"terraform",
--"json",
--"bash",
--"c",
--"html",
--"javascript",
--"json",
--"lua",
--"luadoc",
--"luap",
--"markdown",
--"markdown_inline",
--"python",
--"query",
--"regex",
--"tsx",
--"typescript",
--"vim",
--"vimdoc",
--"yaml",
--"rust",
--"go",
--"gomod",
--"gowork",
--"gosum",
--"dockerfile",
--},
--incremental_selection = {
--enable = true,
--keymaps = {
--init_selection = "<leader>vv",
--node_incremental = "<leader>vv",
--scope_incremental = false,
--node_decremental = "bs",
--},
--},

--})
--end
--}

--return {
--{
--"nvim-treesitter/nvim-treesitter",
--version = false, -- last release is way too old and doesn't work on Windows
--build = ":TSUpdate",
--lazy = false,
--event = { "BufReadPost", "BufNewFile" },
--dependencies = {
--"nvim-treesitter/nvim-treesitter-textobjects",
--},
--opts = function(_, opts)
--if type(opts.ensure_installed) == "table" then
--vim.list_extend(opts.ensure_installed, { "typescript", "tsx" })
--end
--end,
--config = function ()
--require("nvim-treesitter.configs").setup {
--highlight = {
--enable = true,
--additional_vim_regex_highlighting = false,
--},
--indent = { enable = true },
--context_commentstring = { enable = true, enable_autocmd = false },
--auto_install = true,
--ensure_installed = {
--"terraform",
--"bash",
--"c",
--"html",
--"javascript",
--"json",
--"lua",
--"luadoc",
--"luap",
--"markdown",
--"markdown_inline",
--"python",
--"query",
--"regex",
--"tsx",
--"typescript",
--"vim",
--"vimdoc",
--"yaml",
--"rust",
--"go"
--},
--incremental_selection = {
--enable = true,
--keymaps = {
--init_selection = "<leader>vv",
--node_incremental = "+",
--scope_incremental = false,
--node_decremental = "_",
--},
--},
--textobjects = {
--select = {
--enable = true,
--lookahead = true,

--keymaps = {
---- You can use the capture groups defined in textobjects.scm
--["af"] = { query = "@function.outer", desc = "around a function" },
--["if"] = { query = "@function.inner", desc = "inner part of a function" },
--["ac"] = { query = "@class.outer", desc = "around a class" },
--["ic"] = { query = "@class.inner", desc = "inner part of a class" },
--["ai"] = { query = "@conditional.outer", desc = "around an if statement" },
--["ii"] = { query = "@conditional.inner", desc = "inner part of an if statement" },
--["al"] = { query = "@loop.outer", desc = "around a loop" },
--["il"] = { query = "@loop.inner", desc = "inner part of a loop" },
--["ap"] = { query = "@parameter.outer", desc = "around parameter" },
--["ip"] = { query = "@parameter.inner", desc = "inside a parameter" },
--},
--selection_modes = {
--["@parameter.outer"] = "v", -- charwise
--["@parameter.inner"] = "v", -- charwise
--["@function.outer"] = "v", -- charwise
--["@conditional.outer"] = "V", -- linewise
--["@loop.outer"] = "V", -- linewise
--["@class.outer"] = "<c-v>", -- blockwise
--},
--include_surrounding_whitespace = false,
--},
--move = {
--enable = true,
--set_jumps = true, -- whether to set jumps in the jumplist
--goto_previous_start = {
--["[f"] = { query = "@function.outer", desc = "Previous function" },
--["[c"] = { query = "@class.outer", desc = "Previous class" },
--["[p"] = { query = "@parameter.inner", desc = "Previous parameter" },
--},
--goto_next_start = {
--["]f"] = { query = "@function.outer", desc = "Next function" },
--["]c"] = { query = "@class.outer", desc = "Next class" },
--["]p"] = { query = "@parameter.inner", desc = "Next parameter" },
--},
--},
--},
--}
--end
--},
--}
