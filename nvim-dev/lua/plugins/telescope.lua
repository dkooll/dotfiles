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
      telescope.setup {
        defaults   = {
          theme                = 'dropdown',
          previewer            = true,
          file_ignore_patterns = { 'node_modules', 'package-lock.json' },
          initial_mode         = 'insert',
          select_strategy      = 'reset',
          sorting_strategy     = 'ascending',
          layout_strategy      = 'horizontal',
          layout_config        = {
            width = 0.75,
            height = 0.75,
            prompt_position = "top",
            preview_cutoff = 120,
          },
          path_display         = { "smart" },
          winblend             = 0,
          border               = {},
          borderchars          = nil,
          color_devicons       = true,
          set_env              = { ["colorterm"] = "truecolor" },
          vimgrep_arguments    = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden",
            "--glob=!.git/",
          },
          mappings             = {
            i = {
              ["<esc>"] = actions.close,
              ["<C-d>"] = function(prompt_bufnr)
                local action_state = require("telescope.actions.state")
                local current_picker = action_state.get_current_picker(prompt_bufnr)
                current_picker:delete_selection(function(selection)
                  if vim.api.nvim_buf_is_valid(selection.bufnr) then
                    vim.api.nvim_buf_delete(selection.bufnr, { force = true })
                  end
                end)
              end,
            },
            n = {
              ["<esc>"] = actions.close,
            },
          },
        },
        pickers    = {
          find_files = {
            hidden = true,
            previewer = false,
            layout_config = {
              horizontal = {
                width = 0.5,
                height = 0.4,
                preview_width = 0.6,
              },
            },
          },
          oldfiles = {
            previewer = false,
            layout_config = {
              width = 0.5,
              height = 0.4,
            },
          },
          git_files = {
            hidden = true,
            previewer = false,
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
          grep_string = {
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
          buffers = {
            previewer = false,
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
            sorting_strategy = nil,
            layout_config = {
              horizontal = {
                width = 0.9,
                height = 0.75,
                preview_width = 0.6,
              },
            },
            symbols = {
              "class", "function", "method", "interface",
              "type", "const", "variable", "property",
              "constructor", "module", "struct", "trait", "field"
            }
          }
        },
        extensions = {
          undo = {
            use_delta = true,
            use_custom_command = nil,
            side_by_side = false,
            entry_format = "state #$id, $stat, $time",
            mappings = {
              i = {
                ["<cr>"] = require("telescope-undo.actions").yank_additions,
                ["<c-j>"] = require("telescope-undo.actions").yank_deletions,
                ["<c-k>"] = require("telescope-undo.actions").restore,
              },
            }
          },
          project = {
            hidden_files = true,
          },
          ["advanced-git_search"] = {
            diff_plugin = "fugitive",
            git_flags = {},
            git_diff_flags = {},
            show_builtin_git_pickers = true,
          },
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({
              previewer        = false,
              initial_mode     = "normal",
              sorting_strategy = 'ascending',
              layout_strategy  = 'horizontal',
              layout_config    = {
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

      telescope.load_extension('fzf')
      telescope.load_extension('ui-select')
      telescope.load_extension("zoxide")
      telescope.load_extension("undo")
      telescope.load_extension("advanced_git_search")
    end
  },
}
