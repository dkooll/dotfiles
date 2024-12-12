-- references:
-- https://github.com/nvim-neo-tree/neo-tree.nvim
-- https://github.com/nvim-neo-tree/neo-tree.nvim/wiki/Recipes
--return {
  --"nvim-neo-tree/neo-tree.nvim",
  --version = "*",
  --dependencies = {
    --"nvim-lua/plenary.nvim",
    --"nvim-tree/nvim-web-devicons",
    --"MunifTanjim/nui.nvim",
  --},
  --lazy = true, -- Performance: Only load when needed
  --keys = {
    --{ "<leader>e", ":Neotree toggle<CR>", silent = true, desc = "Neotree: File Explorer" },
  --},
  --config = function()
    --require("neo-tree").setup({
      --close_if_last_window = true,
      --popup_border_style = "single",
      --enable_git_status = true,
      --enable_modified_markers = true,
      --enable_diagnostics = false,
      --sort_case_insensitive = true,
      --use_popups_for_input = true,
      --enable_refresh_on_write = false,
      --git_status_async = true,
      --default_component_configs = {
        --indent = {
          --with_markers = false,
          --with_expanders = true,
        --},
        --modified = {
          --symbol = " ",
          --highlight = "NeoTreeModified",
        --},
        --icon = {
          --folder_closed = "",
          --folder_open = "",
          --folder_empty = "",
          --folder_empty_open = "",
        --},
        --git_status = {
          --symbols = {
            --added = "",
            --deleted = "",
            --modified = "",
            --renamed = "",
            --untracked = "",
            --ignored = "",
            --unstaged = "",
            --staged = "",
            --conflict = "",
          --},
        --},
      --},
      --window = {
        --position = "left",
        --width = 35,
        --mapping_options = {
          --noremap = true,
          --nowait = true,
        --},
        --mappings = {
          --["<cr>"] = "open_drop", -- Back to the working Enter behavior
        --}
      --},
      --filesystem = {
        --use_libuv_file_watcher = true,
        --async_directory_scan = "auto",
        --scan_mode = "deep",
        --filtered_items = {
          --hide_dotfiles = false,
          --hide_gitignored = false,
          --hide_by_name = {
            --"node_modules",
            --".git",
            --"target",
            --"build",
            --"dist",
          --},
          --never_show = {
            --".DS_Store",
            --"thumbs.db",
          --},
        --},
        --bind_to_cwd = true,
        --follow_current_file = {
          --enabled = false,
        --},
        --group_empty_dirs = true,
        --search_limit = 50,
        --scan_delay_ms = 50,
        --cache_directory_scan = true,
        --never_buffer_directories = true,
      --},
      --source_selector = {
        --winbar = false,
        --statusline = false,
      --},
      --event_handlers = {
        --{
          --event = "file_opened",
          --handler = function()
            --require("neo-tree").close_all()
          --end,
        --},
        --{
          --event = "neo_tree_window_after_open",
          --handler = function(args)
            --if args.position == "left" or args.position == "right" then
              --vim.cmd("wincmd =")
            --end
          --end,
        --},
        --{
          --event = "neo_tree_window_after_close",
          --handler = function(args)
            --if args.position == "left" or args.position == "right" then
              --vim.cmd("wincmd =")
            --end
          --end,
        --},
      --},
      --log_level = "warn",
      --log_to_file = false,
    --})
  --end,
--}


return {
  "nvim-neo-tree/neo-tree.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  cmd = "Neotree",
  keys = {
    { "<leader>e", ":Neotree toggle<CR>", silent = true, desc = "Neotree: File Explorer" },
  },
  opts = {
    close_if_last_window = true,
    popup_border_style = "single",
    enable_git_status = true,
    enable_modified_markers = true,
    enable_diagnostics = false,
    sort_case_insensitive = true,
    use_popups_for_input = true,
    enable_refresh_on_write = false,
    git_status_async = true,
    default_component_configs = {
      indent = {
        with_markers = false,
        with_expanders = true,
      },
      modified = {
        symbol = " ",
        highlight = "NeoTreeModified",
      },
      icon = {
        folder_closed = "",
        folder_open = "",
        folder_empty = "",
        folder_empty_open = "",
      },
      git_status = {
        symbols = {
          added = "",
          deleted = "",
          modified = "",
          renamed = "",
          untracked = "",
          ignored = "",
          unstaged = "",
          staged = "",
          conflict = "",
        },
      },
    },
    window = {
      position = "left",
      width = 35,
      mapping_options = {
        noremap = true,
        nowait = true,
      },
      mappings = {
        ["<cr>"] = "open_drop",
      }
    },
    filesystem = {
      use_libuv_file_watcher = true,
      async_directory_scan = "auto",
      scan_mode = "deep",
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_by_name = {
          "node_modules",
          ".git",
          "target",
          "build",
          "dist",
        },
        never_show = {
          ".DS_Store",
          "thumbs.db",
        },
      },
      bind_to_cwd = true,
      follow_current_file = {
        enabled = false,
      },
      group_empty_dirs = true,
      search_limit = 50,
      scan_delay_ms = 50,
      cache_directory_scan = true,
      never_buffer_directories = true,
    },
    source_selector = {
      winbar = false,
      statusline = false,
    },
    event_handlers = {
      {
        event = "file_opened",
        handler = function()
          require("neo-tree").close_all()
        end,
      },
      {
        event = "neo_tree_window_after_open",
        handler = function(args)
          if args.position == "left" or args.position == "right" then
            vim.cmd("wincmd =")
          end
        end,
      },
      {
        event = "neo_tree_window_after_close",
        handler = function(args)
          if args.position == "left" or args.position == "right" then
            vim.cmd("wincmd =")
          end
        end,
      },
    },
    log_level = "warn",
    log_to_file = false,
  }
}
