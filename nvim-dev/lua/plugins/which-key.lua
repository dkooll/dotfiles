-- .FIX: needs to be rewritten. Config as well. Annoying startup messages are suppressed.
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  lazy = true,
  init = function()
    vim.schedule(function()
      local orig_notify = vim.notify
      vim.notify = function(msg, level, opts)
        -- Specific messages to suppress
        local suppress_patterns = {
          "deprecated option '.*'",
          "popup_mappings",
          "window",
          "ignore_missing",
          "hidden",
          "triggers_blacklist",
          "Please refer to the docs for the new options.",
          "Use `:checkhealth which[-]key` to find out more."
        }

        -- Check if the message matches any of the suppression patterns
        for _, pattern in ipairs(suppress_patterns) do
          if msg:match(pattern) then
            return -- Suppress the message
          end
        end

        -- For other messages, use the original notify function
        orig_notify(msg, level, opts)
      end
    end)
  end,
  opts = {
    plugins = {
      marks = false,
      registers = false,
      spelling = {
        enabled = true,
        suggestions = 20,
      },
      presets = {
        operators = false,
        motions = false,
        text_objects = false,
        windows = false,
        nav = false,
        z = false,
        g = false,
      },
    },
    icons = {
      breadcrumb = "»",
      separator = "➜",
      group = "+",
    },
    popup_mappings = {
      scroll_down = "<c-d>",
      scroll_up = "<c-u>",
    },
    window = {
      border = "none",
      position = "bottom",
      margin = { 2, 0, 2, 0 },
      padding = { 2, 2, 2, 2 },
      winblend = 0,
      zindex = 1000,
    },
    layout = {
      height = { min = 4, max = 25 },
      width = { min = 20, max = 50 },
      spacing = 3,
      align = "left",
    },
    ignore_missing = false,
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },
    show_help = false,
    show_keys = false,
    triggers = "auto",
    triggers_blacklist = {
      i = { "j", "k" },
      v = { "j", "k" },
    },
    disable = {
      buftypes = {},
      filetypes = { "TelescopePrompt" },
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    wk.register(require('config.which_key_defaults'), {
      mode = "n",
      prefix = "<leader>",
    })
    wk.register(require('config.which_key_non_leader'))
  end
}

--return {
--"folke/which-key.nvim",
--event = "VeryLazy",
--lazy = true,
--opts = {
--plugins = {
--marks = false,     -- shows a list of your marks on ' and `
--registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
--spelling = {
--enabled = true,
--suggestions = 20,
--},
--presets = {
--operators = false,    -- adds help for operators like d, y, ...
--motions = false,      -- adds help for motions
--text_objects = false, -- help for text objects triggered after entering an operator
--windows = false,      -- default bindings on <c-w>
--nav = false,          -- misc bindings to work with windows
--z = false,            -- bindings for folds, spelling and others prefixed with z
--g = false,            -- bindings for prefixed with g
--},
--},
--delay = 500,     -- Set the delay in milliseconds before the which-key popup appears
--operators = { gc = "Comments" },
--icons = {
--breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
--separator = "➜", -- symbol used between a key and its label
--group = "+", -- symbol prepended to a group
--ellipsis = "…",
--rules = false,
--colors = false, -- Retain colors if you want them; set to false if not
--keys = {},      -- Try an empty table to see if this simply removes icon decoration without disabling the menu
--},
--popup_mappings = {
--scroll_down = "<c-d>", -- binding to scroll down inside the popup
--scroll_up = "<c-u>",   -- binding to scroll up inside the popup
--},
--window = {
--border = "none",          -- none, single, double, shadow
--position = "bottom",      -- bottom, top
--margin = { 2, 0, 2, 0 },  -- extra window margin [top, right, bottom, left]
--padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
--winblend = 0,
--zindex = 1000,            -- positive value to position WhichKey above other floating windows.
--},
--layout = {
--height = { min = 4, max = 25 },                                             -- min and max height of the columns
--width = { min = 20, max = 50 },                                             -- min and max width of the columns
--spacing = 3,                                                                -- spacing between columns
--align = "left",                                                             -- align columns left, center or right
--},
--ignore_missing = false,                                                       -- enable this to hide mappings for which you didn't specify a label
--hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
--show_help = false,                                                            -- show help message on the command line when the popup is visible
--show_keys = false,
--triggers = "auto",                                                            -- automatically setup triggers
--triggers_blacklist = {
--i = { "j", "k" },
--v = { "j", "k" },
--},
--disable = {
--buftypes = {},
--filetypes = { "TelescopePrompt" },
--},
--},
--config = function(_, opts)
--local which_key = require("which-key")
--which_key.setup(opts)

--which_key.register(require('config.which_key_defaults'), {
--mode = "n",
--prefix = "<leader>",
--})

--which_key.register(require('config.which_key_non_leader'))
--end
--}
