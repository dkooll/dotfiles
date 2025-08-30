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
    renderers = {
      file = {
        { "indent" },
        { "icon" },
        { "name",  use_git_status_colors = true },
      },
      directory = {
        { "indent" },
        { "icon" },
        { "name",  use_git_status_colors = true },
      },
    },
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
      -- position = "left",
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

-- Oil.nvim - file manager that lets you edit your filesystem like a buffer
-- return {
--   {
--     'stevearc/oil.nvim',
--     opts = {
--       default_file_explorer = true,
--       skip_confirm_for_simple_edits = true,
--       prompt_save_on_select_new_entry = false,
--       watch_for_changes = false,
--       columns = {
--         "icon",
--       },
--       keymaps = {
--         ["<CR>"] = "actions.select",
--         ["<C-s>"] = "actions.select_vsplit",
--         ["<C-h>"] = "actions.select_split",
--         ["-"] = "actions.parent",
--         ["g."] = "actions.toggle_hidden",
--         ["a"] = {
--           callback = function()
--             vim.cmd("normal! o")
--             vim.cmd("startinsert")
--             vim.api.nvim_create_autocmd("InsertLeave", {
--               buffer = 0,
--               once = true,
--               callback = function() vim.cmd("silent! w!") end,
--             })
--             vim.keymap.set("i", "<CR>", function()
--               vim.cmd("stopinsert")
--               vim.cmd("silent! w!")
--             end, { buffer = 0, noremap = true })
--           end,
--           desc = "Create file/directory"
--         },
--         ["d"] = {
--           callback = function()
--             -- Get the file path before deleting
--             local oil = require("oil")
--             local entry = oil.get_cursor_entry()
--             local dir = oil.get_current_dir()
--
--             if entry and dir then
--               local file_path = dir .. entry.name
--               vim.cmd("normal! dd")
--               oil.save({ confirm = false })
--
--               -- Close buffer if file was open (optimized)
--               vim.defer_fn(function()
--                 for _, buf in ipairs(vim.api.nvim_list_bufs()) do
--                   if vim.api.nvim_buf_is_loaded(buf) then
--                     local buf_name = vim.api.nvim_buf_get_name(buf)
--                     if buf_name == file_path then
--                       vim.api.nvim_buf_delete(buf, { force = true })
--                       break -- Exit loop after finding the buffer
--                     end
--                   end
--                 end
--               end, 0)
--             end
--           end,
--           desc = "Delete file/directory"
--         },
--       },
--       use_default_keymaps = true,
--       view_options = {
--         show_hidden = true,
--         is_always_hidden = function(name)
--           return name == '..' or name == '.git'
--         end,
--       },
--     },
--     dependencies = {
--       "nvim-tree/nvim-web-devicons",
--     },
--     config = function(_, opts)
--       require("oil").setup(opts)
--       -- Fix hidden file and directory colors
--       vim.api.nvim_create_autocmd("ColorScheme", {
--         callback = function()
--           vim.api.nvim_set_hl(0, "OilHidden", { link = "Normal" })
--           vim.api.nvim_set_hl(0, "OilDirHidden", { link = "Directory" })
--         end
--       })
--       -- Apply immediately
--       vim.api.nvim_set_hl(0, "OilHidden", { link = "Normal" })
--       vim.api.nvim_set_hl(0, "OilDirHidden", { link = "Directory" })
--     end,
--     keys = {
--       {
--         "<leader>e",
--         function()
--           if vim.bo.filetype == "oil" then
--             vim.cmd("bd!")
--             if vim.fn.bufname() == "" or vim.bo.filetype == "" then
--               vim.cmd("Alpha")
--             end
--           else
--             -- Always open at workspace root
--             require("oil").open(vim.fn.getcwd())
--           end
--         end,
--         desc = "Toggle oil file explorer"
--       },
--     },
--   },
-- }
--
