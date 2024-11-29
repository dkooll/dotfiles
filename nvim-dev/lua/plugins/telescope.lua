return {
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    version = false,
    lazy = true,
    keys = {
      { "<leader><leader>", "<cmd>Telescope buffers<cr>", desc = "Show buffers" },
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'jvgrootveld/telescope-zoxide',
      'nvim-tree/nvim-web-devicons',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      'nvim-telescope/telescope-ui-select.nvim',
      'debugloop/telescope-undo.nvim',
      'aaronhallaert/advanced-git-search.nvim',
      'tpope/vim-fugitive',
      'tpope/vim-rhubarb',
    },
    config = function()
      local telescope = require('telescope')
      local actions = require('telescope.actions')
      local previewers = require("telescope.previewers")
      local sorters = require("telescope.sorters")

      -- Optimized file previewer
      local new_maker = function(filepath, bufnr, opts)
        opts = opts or {}
        filepath = vim.fn.expand(filepath)

        local file_size = vim.fn.getfsize(filepath)
        if file_size > 100000 then
          return
        end

        previewers.buffer_previewer_maker(filepath, bufnr, opts)
      end

      telescope.setup {
        defaults = {
          theme = 'dropdown',
          previewer = true,
          buffer_previewer_maker = new_maker,
          file_ignore_patterns = {
            "%.git/",
            "%.terraform/",
            "node_modules/",
            "target/",
            "bin/",
            "pkg/",
            "vendor/",
            "%.lock",
            "%.class",
            "__pycache__/",
            "package%-lock.json",
            "%.o$",
            "%.a$",
            "%.out$",
            "%.pdf$",
            "%.mkv$",
            "%.mp4$",
            "%.zip$",
            "%.tar$",
            "%.tar.gz$",
            "%.tar.bz2$",
            "%.rar$",
            "%.7z$",
            "%.jar$",
            "%.war$",
            "%.ear$",
            "%.min.js$",
            "%.min.css$",
            "dist/",
            "build/",
          },
          file_sorter = sorters.get_fuzzy_file,
          generic_sorter = sorters.get_generic_fuzzy_sorter,
          path_display = { "truncate" },
          sorting_strategy = "ascending",
          initial_mode = "insert",
          selection_strategy = "reset",
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden",
            "--glob=!.git/",
            "--max-columns=150",
            "--max-filesize=500K",
            "--threads=8",
            "--no-binary",
          },
          cache_picker = {
            num_pickers = 5,
            limit_entries = 1000,
          },
          mappings = {
            i = {
              ["<esc>"] = actions.close,
              ["<C-u>"] = false,
              ["<C-d>"] = require("telescope.actions").delete_buffer,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
            },
            n = {
              ["<esc>"] = actions.close,
              ["<C-d>"] = require("telescope.actions").delete_buffer,
              ["j"] = actions.move_selection_next,
              ["k"] = actions.move_selection_previous,
            },
          },
          layout_strategy = 'horizontal',
          layout_config = {
            width = 0.75,
            height = 0.75,
            prompt_position = "top",
            preview_cutoff = 120,
          },
        },
        pickers = {
          find_files = {
            find_command = {
              "fd",
              "--type", "f",
              "--strip-cwd-prefix",
              "--hidden",
              "--follow",
              "--exclude", ".git",
              "--exclude", "node_modules",
              "-E", "*.lock",
            },
            hidden = true,
            no_ignore = false,
            previewer = false,
            layout_config = {
              horizontal = {
                width = 0.5,
                height = 0.4,
                preview_width = 0.6,
              },
            },
          },
          git_files = {
            hidden = true,
            previewer = false,
            show_untracked = true,
            layout_config = {
              horizontal = {
                width = 0.5,
                height = 0.4,
                preview_width = 0.6,
              },
            },
          },
          live_grep = {
            only_sort_text = true,
            previewer = true,
            layout_config = {
              horizontal = {
                width = 0.9,
                height = 0.75,
                preview_width = 0.6,
              },
            },
          },
          oldfiles = {
            previewer = false,
            path_display = { "smart" },
            layout_config = {
              horizontal = {
                width = 0.5,
                height = 0.4,
                preview_width = 0.6,
              },
            },
          },
          grep_string = {
            only_sort_text = true,
            previewer = true,
            word_match = "-w",
            layout_config = {
              horizontal = {
                width = 0.9,
                height = 0.75,
                preview_width = 0.6,
              },
            },
          },
          buffers = {
            previewer = false,
            show_all_buffers = true,
            sort_mru = true,
            mappings = {
              i = {
                ["<c-d>"] = actions.delete_buffer,
              },
            },
            layout_config = {
              horizontal = {
                width = 0.5,
                height = 0.4,
                preview_width = 0.6,
              },
            },
          },
          lsp_references = {
            show_line = false,
            layout_config = {
              horizontal = {
                width = 0.9,
                height = 0.75,
                preview_width = 0.6,
              },
            },
          },
          treesitter = {
            show_line = false,
            layout_config = {
              horizontal = {
                width = 0.9,
                height = 0.75,
                preview_width = 0.6,
              },
            },
            symbols = {
              "class",
              "function",
              "method",
              "interface",
              "type",
              "const",
              "variable",
              "property",
              "constructor",
              "module",
              "struct",
              "trait",
              "field"
            }
          }
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
          undo = {
            use_delta = true,
            side_by_side = false,
            layout_strategy = "horizontal",
            layout_config = {
              preview_width = 0.6,
            },
          },
          ["advanced-git-search"] = {
            diff_plugin = "fugitive",
            git_flags = { "--no-pager" },
            git_diff_flags = {},
            show_builtin_git_pickers = false,
          },
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({
              previewer = false,
              initial_mode = "normal",
              sorting_strategy = 'ascending',
              layout_strategy = 'horizontal',
              layout_config = {
                horizontal = {
                  width = 0.5,
                  height = 0.4,
                  preview_width = 0.6,
                },
              },
            })
          },
        }
      }

      -- Load extensions efficiently
      local extensions = {
        'fzf',
        'ui-select',
        'zoxide',
        'undo',
        'advanced_git_search'
      }

      for _, ext in ipairs(extensions) do
        pcall(telescope.load_extension, ext)
      end
    end
  },
}
