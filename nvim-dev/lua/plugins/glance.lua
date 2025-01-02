return {
  {
    "dnlhc/glance.nvim",
    cmd = "Glance",
    config = function()
      require("glance").setup({
        -- Height of the Glance window
        height = 30,

        -- Border style
        border = {
          enable = true,
          characters = {
            '╭', '─', '╮',
            '│',      '│',
            '╰', '─', '╯'
          },
          highlight = "Comment",
        },

        -- Preview window options
        preview_win_opts = {
          cursorline = true,    -- Highlight current line
          number = false,        -- Show line numbers
          wrap = true,          -- Wrap long lines
        },

        -- List window position and size
        list = {
          position = 'right',   -- 'left' or 'right'
          width = 0.33,        -- Width as percentage (0.1 to 0.5)
        },

        -- Theme settings
        theme = {
          enable = true,        -- Use your colorscheme colors
          mode = 'auto',       -- 'brighten', 'darken', or 'auto'
        },

        -- Indent settings
        indent_lines = {
          enable = true,       -- Show indent guides
          icon = '│',         -- Indent guide character
        },

        -- Fold settings
        folds = {
          fold_closed = '',   -- Icon for closed folds
          fold_open = '',    -- Icon for open folds
          folded = true,      -- Auto-fold on startup
        },

        -- Window bar (requires Neovim 0.8+)
        winbar = {
          enable = true,
        }
      })
    end
  }
}

-- return {
--   {
--     "dnlhc/glance.nvim",
--     cmd = "Glance",
--     config = function()
--       require("glance").setup({
--         border = {
--           enable = true,
--           top_char = '─',
--           bottom_char = '─',
--           characters = {
--             '╭', '─', '╮',
--             '│',      '│',
--             '╰', '─', '╯'
--           },
--           highlight = "Comment", -- or "#555555" for a specific grey
--         },
--       })
--     end
--   }
-- }

-- return {
--   {
--     'dnlhc/glance.nvim',
--     cmd = 'Glance'
--   }
-- }
