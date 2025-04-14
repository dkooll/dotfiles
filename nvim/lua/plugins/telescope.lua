return {
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    version = false,
    lazy = true,
    keys = {
      { "<leader>sf",       "<cmd>Telescope fd<cr>",                        desc = "Telescope: Find Files" },
      { "<leader>sg",       "<cmd>Telescope live_grep<cr>",                 desc = "Telescope: Live Grep" },
      { "<leader><leader>", "<cmd>Telescope buffers<cr>",                   desc = "Telescope: Buffers" },
      { "<leader>sh",       "<cmd>Telescope help_tags<cr>",                 desc = "Telescope: Help Tags" },
      { "<leader>sH",       "<cmd>Telescope highlights<cr>",                desc = "Telescope: Find HighLight Groups" },
      { "<leader>so",       "<cmd>Telescope oldfiles<cr>",                  desc = "Telescope: Recent Files" },
      { "<leader>sR",       "<cmd>Telescope registers<cr>",                 desc = "Telescope: Registers" },
      { "<leader>sF",       "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Telescope: Current Buffer fuzzy Find" },
      { "<leader>sc",       "<cmd>Telescope commands<cr>",                  desc = "Telescope: Find Commands" },
      { "<leader>su",       "<cmd>Telescope undo<cr>",                      desc = "Telescope: Undo List" },
      { "<leader>sq",       "<cmd>Telescope quickfix<cr>",                  desc = "Telescope: Quickfix" },
      { "<leader>st",       "<cmd>Telescope quickfixhistory<cr>",           desc = "Telescope: Quickfix History" },
      { "<leader>p",        "<cmd>Telescope treesitter<cr>",                desc = "Telescope: Treesitter List Symbols" },
      { "<leader>sm",       "<cmd>Telescope marks<cr>",                     desc = "Telescope: Marks" },
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      'nvim-telescope/telescope-ui-select.nvim',
      'debugloop/telescope-undo.nvim',
    },
    config = function()
      local telescope = require('telescope')
      local actions = require('telescope.actions')
      local previewers = require("telescope.previewers")
      local sorters = require("telescope.sorters")

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
          marks = {
            theme = "ivy",
            previewer = false,
            layout_config = {
              width = 0.5,
              height = 0.31,
              horizontal = {
                preview_width = 0.6,
              },
            },
          },

          commands = {
            theme = "ivy",
            previewer = false,
            layout_config = {
              width = 0.5,
              height = 0.31,
              horizontal = {
                preview_width = 0.6,
              },
            },
          },

          quickfix = {
            theme = "ivy",
            previewer = false,
            layout_config = {
              width = 0.5,
              height = 0.31,
              horizontal = {
                preview_width = 0.6,
              },
            },
          },

          quickfixhistory = {
            theme = "ivy",
            previewer = false,
            layout_config = {
              width = 0.5,
              height = 0.31,
              horizontal = {
                preview_width = 0.6,
              },
            },
          },
          fd = {
            hidden = true,
            follow = true,
            theme = "ivy",
            find_command = {
              "fd",
              "--type", "f",
              "--hidden",
              "--follow",
              "--exclude", ".git",
              "--exclude", "node_modules",
              "-E", "*.lock",
            },
            previewer = false,
            layout_config = {
              width = 0.5,
              height = 0.31,
              horizontal = {
              },
            },
          },
          git_files = {
            theme = "ivy",
            hidden = true,
            previewer = false,
            show_untracked = true,
            layout_config = {
              width = 0.5,
              height = 0.31,
              horizontal = {
                preview_width = 0.6,
              },
            },
          },
          live_grep = {
            only_sort_text = true,
            previewer = true,
            layout_config = {
              width = 0.9,
              height = 0.75,
              horizontal = {
                preview_width = 0.6,
              },
            },
          },
          oldfiles = {
            theme = "ivy",
            previewer = false,
            path_display = { "smart" },
            layout_config = {
              width = 0.5,
              height = 0.31,
              horizontal = {
                preview_width = 0.6,
              },
            },
          },
          grep_string = {
            theme = "ivy",
            only_sort_text = true,
            previewer = true,
            word_match = "-w",
            layout_config = {
              width = 0.5,
              height = 0.31,
              horizontal = {
                preview_width = 0.6,
              },
            },
          },
          buffers = {
            theme = "ivy",
            previewer = false,
            show_all_buffers = true,
            sort_mru = true,
            mappings = {
              i = {
                ["<c-d>"] = actions.delete_buffer,
              },
            },
            layout_config = {
              width = 0.5,
              height = 0.31,
              horizontal = {
                preview_width = 0.6,
              },
            },
          },
          current_buffer_fuzzy_find = {
            theme = "ivy",
            previewer = false,
            layout_config = {
              prompt_position = "top",
              preview_cutoff = 120,
              width = 0.5,
              height = 0.31
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
          ["ui-select"] = {
            require("telescope.themes").get_ivy({
              layout_config = {
                height = 0.31,
                width = 0.5,
              },
              previewer = false,
              initial_mode = "insert",
              attach_mappings = function(prompt_bufnr)
                -- Clear the prompt when opening
                vim.schedule(function()
                  if vim.api.nvim_buf_is_valid(prompt_bufnr) then
                    local prompt = vim.api.nvim_buf_get_lines(prompt_bufnr, 0, 1, false)[1] or ""
                    if prompt:match("^.") then
                      local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
                      picker:reset_prompt("")
                    end
                  end
                end)
                return true
              end
            })
          }
        }
      }

      vim.api.nvim_set_hl(0, 'TelescopeSelection', { fg = "#9E8069" })
      vim.api.nvim_set_hl(0, 'TelescopeSelectionCaret', { fg = "#9E8069" })
      vim.api.nvim_set_hl(0, 'TelescopePromptPrefix', { fg = "#9E8069" })
      vim.api.nvim_set_hl(0, 'TelescopeMatching', { fg = "#7DAEA3" })

      local extensions = {
        'fzf',
        'ui-select',
        'undo',
      }

      for _, ext in ipairs(extensions) do
        pcall(telescope.load_extension, ext)
      end
    end
  },
}
