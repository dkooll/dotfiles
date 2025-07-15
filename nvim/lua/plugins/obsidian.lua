return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    {
      "<leader>onf",
      function()
        require("obsidian-config").create_note("fleeting", "Fleeting note title: ")
      end,
      desc = "Obsidian: New fleeting note"
    },
    {
      "<leader>onl",
      function()
        require("obsidian-config").create_note("literature", "Literature note title: ")
      end,
      desc = "Obsidian: New literature note"
    },
    {
      "<leader>onp",
      function()
        require("obsidian-config").create_note("permanent", "Permanent note title: ")
      end,
      desc = "Obsidian: New permanent note"
    },
    {
      "<leader>os",
      function()
        require("obsidian-config").search_notes()
      end,
      desc = "Obsidian: Search notes content"
    },
    {
      "<leader>of",
      function()
        require("obsidian-config").find_notes()
      end,
      desc = "Obsidian: Find notes"
    },
    {
      "<leader>ob",
      function()
        require("obsidian-config").show_backlinks()
      end,
      desc = "Obsidian: Show backlinks"
    },
    {
      "<leader>ol",
      function()
        require("obsidian-config").show_links()
      end,
      desc = "Obsidian: Show links"
    },
    {
      "<leader>or",
      "<cmd>ObsidianRename<CR>",
      desc = "Obsidian: Rename note"
    },
    {
      "<leader>ow",
      function()
        require("obsidian-config").switch_workspace()
      end,
      desc = "Obsidian: Switch workspace"
    },
    {
      "<leader>ot",
      function()
        require("obsidian-config").find_tags()
      end,
      desc = "Obsidian: Find tags"
    },
  },

  config = function()
    -- Constants
    local NOTES_PATH_PATTERN = "Documents/.*%-notes"
    local WORKSPACES = {
      { name = "tech",    path = "~/Documents/tech-notes" },
      { name = "worship", path = "~/Documents/worship-notes" },
    }

    -- Create highlight groups
    vim.api.nvim_set_hl(0, 'NotesBrown', { fg = "#9E8069" })
    vim.api.nvim_set_hl(0, 'NotesBrownBold', { fg = "#9E8069", bold = true })
    vim.api.nvim_set_hl(0, 'NotesBrownItalic', { fg = "#9E8069", italic = true })
    vim.api.nvim_set_hl(0, 'NotesPink', { fg = "#D3869B" })
    vim.api.nvim_set_hl(0, 'NotesBlue', { fg = "#7DAEA3" })
    vim.api.nvim_set_hl(0, 'ObsidianParentDir', { fg = "#9E8069", bold = false })
    vim.api.nvim_set_hl(0, 'NotesWhiteItalic', { fg = "#C0B8A8", italic = true })
    vim.api.nvim_set_hl(0, 'NotesWhiteItalicDark', { fg = "#968A80", italic = true })
    vim.api.nvim_set_hl(0, 'NotesLightItalic', { fg = "#C0B8A8", italic = true })
    vim.api.nvim_set_hl(0, 'NotesYamlString', { fg = "#968A80", italic = true })
    vim.api.nvim_set_hl(0, 'NotesYamlKey', { fg = "#C0B8A8", italic = false })
    vim.api.nvim_set_hl(0, '@markup.raw.block.markdown.markdown', { fg = "#968A80", italic = true })
    vim.api.nvim_set_hl(0, 'markdownCodeBlock', { fg = "#968A80", italic = true })

    local NOTES_HIGHLIGHTS =
    '@punctuation.special:NotesBrown,@markup.heading.1.markdown:NotesLightItalic,@markup.heading.2.markdown:NotesLightItalic,@markup.heading.3.markdown:NotesLightItalic,@markup.heading.4.markdown:NotesLightItalic,@markup.heading.5.markdown:NotesLightItalic,@markup.heading.6.markdown:NotesLightItalic,@markup.heading:NotesLightItalic,markdownCode:NotesWhiteItalic,@markup.raw.markdown_inline:NotesWhiteItalic,@text.literal.markdown_inline:NotesWhiteItalic,@markup.strong.markdown_inline:NotesLightItalic,markdownItalic:NotesLightItalic,markdownItalicDelimiter:NotesLightItalic,@text.emphasis:NotesLightItalic,@text.strong:NotesLightItalic,@markup.italic.markdown_inline:NotesLightItalic,@markup.bold.markdown_inline:NotesLightItalic,@markup.link.label:NotesBlue,@markup.link:NotesBlue,@keyword.directive:NotesWhiteItalic,@property:NotesYamlKey,@property.yaml:NotesYamlKey,@string.yaml:NotesYamlString'

    --original yml colors
    -- local NOTES_HIGHLIGHTS =
    -- '@punctuation.special:NotesBrown,@markup.heading.3.markdown:NotesLightItalic,@markup.heading.2.markdown:NotesLightItalic,@markup.heading.3.markdown:NotesLightItalic,@markup.heading.4.markdown:NotesLightItalic,@markup.heading.5.markdown:NotesLightItalic,@markup.heading.6.markdown:NotesLightItalic,@markup.heading:NotesLightItalic,markdownCode:NotesWhiteItalic,@markup.raw.markdown_inline:NotesWhiteItalic,@text.literal.markdown_inline:NotesWhiteItalic,@markup.strong.markdown_inline:NotesLightItalic,markdownItalic:NotesLightItalic,markdownItalicDelimiter:NotesLightItalic,@text.emphasis:NotesLightItalic,@text.strong:NotesLightItalic,@markup.italic.markdown_inline:NotesLightItalic,@markup.bold.markdown_inline:NotesLightItalic,@markup.link.label:NotesBlue,@markup.link:NotesBlue,Normal:NotesWhite'

    -- Helper function to check if file is a note
    local function is_notes_file(filename)
      return vim.bo.filetype == "markdown" and filename:match(NOTES_PATH_PATTERN)
    end

    -- Auto-update modified field on save
    vim.api.nvim_create_autocmd({ "BufWritePre" }, {
      pattern = { "*.md" },
      callback = function()
        local filename = vim.api.nvim_buf_get_name(0)
        if filename:match(NOTES_PATH_PATTERN) then
          local lines = vim.api.nvim_buf_get_lines(0, 0, 20, false)
          for i, line in ipairs(lines) do
            if line:match("^modified:") then
              vim.api.nvim_buf_set_lines(0, i - 1, i, false, { "modified: " .. os.date("%Y-%m-%d %H:%M") })
              break
            end
          end
        end
      end,
    })

    -- Apply window-local highlights for notes
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
      callback = function()
        local filename = vim.api.nvim_buf_get_name(0)
        if is_notes_file(filename) then
          vim.opt_local.conceallevel = 2
          vim.opt_local.wrap = true
          vim.opt_local.linebreak = true
          vim.wo.winhighlight = NOTES_HIGHLIGHTS
        end
      end,
    })

    -- Clear highlights when leaving notes
    vim.api.nvim_create_autocmd({ "BufLeave" }, {
      callback = function()
        local filename = vim.api.nvim_buf_get_name(0)
        if is_notes_file(filename) then
          vim.wo.winhighlight = ''
        end
      end,
    })

    -- Ensure highlights apply to telescope previews and other windows
    vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile", "WinEnter", "ColorScheme" }, {
      callback = function()
        vim.schedule(function()
          for _, winid in ipairs(vim.api.nvim_list_wins()) do
            local bufnr = vim.api.nvim_win_get_buf(winid)
            local filename = vim.api.nvim_buf_get_name(bufnr)
            if vim.bo[bufnr].filetype == "markdown" and filename:match(NOTES_PATH_PATTERN) then
              local current_winhighlight = vim.api.nvim_get_option_value('winhighlight', { win = winid })
              if not current_winhighlight:match("NotesBrown") then
                vim.api.nvim_set_option_value('winhighlight', NOTES_HIGHLIGHTS, { win = winid })
              end
            end
          end
        end)
      end,
    })

    -- Reset YAML highlights for non-notes files
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
      pattern = { "*.yaml", "*.yml" },
      callback = function()
        local filename = vim.api.nvim_buf_get_name(0)
        if not filename:match(NOTES_PATH_PATTERN) then
          vim.wo.winhighlight = ''
        end
      end,
    })

    -- Initialize obsidian config module
    local obsidian_config = {}

    -- Workspace management
    vim.g.obsidian_current_workspace = WORKSPACES[1].name
    local tag_cache = {}
    local cache_timestamp = 0

    -- Get current workspace path
    local function get_workspace()
      for _, workspace in ipairs(WORKSPACES) do
        if workspace.name == vim.g.obsidian_current_workspace then
          return vim.fn.expand(workspace.path)
        end
      end
      return vim.fn.expand(WORKSPACES[1].path)
    end

    -- Telescope configuration
    local function telescope_config(title, cwd)
      return require("telescope.themes").get_ivy({
        prompt_title = title .. " (" .. vim.g.obsidian_current_workspace .. ")",
        cwd = cwd,
        previewer = false,
        layout_config = {
          height = 0.31,
        },
      })
    end

    -- Compact telescope picker
    local function picker(title, items, on_select, is_files, mappings)
      local config = telescope_config(title, nil)

      require("telescope.pickers").new(config, {
        finder = require("telescope.finders").new_table({
          results = items,
          entry_maker = function(entry)
            if is_files then
              local workspace_path = get_workspace()
              local relative_path = entry:gsub("^" .. vim.pesc(workspace_path) .. "/", "")
              local folder = vim.fn.fnamemodify(relative_path, ":h")
              local filename = vim.fn.fnamemodify(relative_path, ":t")

              local display_func
              if folder and folder ~= "." then
                local entry_display = require("telescope.pickers.entry_display")
                local displayer = entry_display.create {
                  separator = "/",
                  items = {
                    { width = nil },
                    { width = nil },
                  },
                }
                display_func = function()
                  return displayer {
                    folder,
                    { filename, "ObsidianParentDir" },
                  }
                end
              else
                display_func = filename
              end

              return {
                value = entry,
                display = display_func,
                ordinal = folder and folder ~= "." and (folder .. "/" .. filename) or filename,
                path = entry
              }
            else
              return { value = entry, display = entry, ordinal = entry }
            end
          end,
        }),
        sorter = require("telescope.config").values.generic_sorter({}),
        attach_mappings = function(prompt_bufnr, map)
          require("telescope.actions").select_default:replace(function()
            local selection = require("telescope.actions.state").get_selected_entry()
            require("telescope.actions").close(prompt_bufnr)
            if selection and on_select then
              on_select(selection.value)
            end
          end)
          if mappings then
            mappings(prompt_bufnr, map)
          end
          return true
        end,
      }):find()
    end

    -- Tag operations
    local function get_tags()
      local now = os.time()
      if tag_cache.data and (now - cache_timestamp) < 30 then
        return tag_cache.data
      end

      local ws = get_workspace()
      local tag_set = {}

      local cmd = vim.fn.executable('rg') == 1 and
          string.format("rg --no-filename --no-line-number -o '(^  - [a-zA-Z0-9_-]+$|#[a-zA-Z0-9_-]+)' '%s' --type md",
            ws) or
          string.format("grep -r -h -o -E '(^  - [a-zA-Z0-9_-]+$|#[a-zA-Z0-9_-]+)' '%s' --include='*.md'", ws)

      local output = vim.fn.system(cmd)

      if vim.v.shell_error == 0 then
        for match in output:gmatch("[^\r\n]+") do
          local tag = match:match("^  %- (.+)") or match:match("#(.+)")
          if tag and tag ~= "" then
            tag_set[tag] = true
          end
        end
      end

      local tags = {}
      for tag, _ in pairs(tag_set) do
        table.insert(tags, tag)
      end
      table.sort(tags)

      tag_cache.data = tags
      cache_timestamp = now
      return tags
    end

    local function get_files_with_tag(tag)
      local ws = get_workspace()
      local cmd = vim.fn.executable('rg') == 1 and
          string.format("rg --files-with-matches '^  - %s$' '%s' --type md", vim.fn.shellescape(tag), ws) or
          string.format("grep -l '^  - %s$' '%s'/*.md '%s'/*/*.md 2>/dev/null", vim.fn.shellescape(tag), ws, ws)

      local output = vim.fn.system(cmd)
      local files = {}

      if vim.v.shell_error == 0 then
        for file in output:gmatch("[^\r\n]+") do
          if file ~= "" then
            table.insert(files, file)
          end
        end
      end
      return files
    end

    -- Note operations
    function obsidian_config.create_note(folder, prompt)
      local title = vim.fn.input(prompt)
      if title == "" then return end

      local workspace = get_workspace()
      local timestamp = os.time()
      local date = os.date("%Y-%m-%d")
      local safe_title = title:gsub("[^%w%s%-]", ""):gsub("%s+", "-"):lower()

      local filename = string.format("%s/%s/%s-%s.md", workspace, folder, date, safe_title)
      local template_path = string.format("%s/templates/%s.md", workspace, folder)

      if vim.fn.filereadable(template_path) == 0 then
        print("Template not found: " .. template_path)
        return
      end

      local content = {}
      local id = string.format("%s-%s", timestamp, safe_title)
      local time = os.date("%H:%M")

      for _, line in ipairs(vim.fn.readfile(template_path)) do
        local new_line = line:gsub("{{title}}", title)
            :gsub("{{date}}", date)
            :gsub("{{time}}", time)
            :gsub("{{id}}", id)
            :gsub("{{modified}}", date .. " " .. time)
        table.insert(content, new_line)
      end

      vim.fn.writefile(content, filename)
      vim.cmd("edit " .. filename)
    end

    function obsidian_config.search_notes()
      local config = telescope_config("Search Notes", get_workspace())

      require("telescope.pickers").new(config, {
        prompt_title = "Search Notes (" .. vim.g.obsidian_current_workspace .. ")",
        finder = require("telescope.finders").new_job(function(prompt)
          if not prompt or prompt == "" then
            return nil
          end

          local workspace_path = get_workspace()
          return { "rg", "--with-filename", "--line-number", "--column", "--smart-case", prompt, workspace_path, "--type",
            "md" }
        end, function(entry)
          local make_entry = require("telescope.make_entry")
          local default_entry = make_entry.gen_from_vimgrep({})(entry)

          if not default_entry then return end

          local workspace_path = get_workspace()
          local relative_path = default_entry.filename:gsub("^" .. vim.pesc(workspace_path) .. "/", "")
          local folder = vim.fn.fnamemodify(relative_path, ":h")
          local filename = vim.fn.fnamemodify(relative_path, ":t")

          if folder and folder ~= "." then
            local entry_display = require("telescope.pickers.entry_display")
            local displayer = entry_display.create {
              separator = "/",
              items = {
                { width = nil },
                { width = nil },
              },
            }
            default_entry.display = function()
              return displayer {
                folder,
                { filename, "ObsidianParentDir" },
              }
            end
          else
            default_entry.display = filename
          end

          return default_entry
        end, 120),
        sorter = require("telescope.config").values.generic_sorter({}),
      }):find()
    end

    function obsidian_config.find_notes()
      local workspace_path = get_workspace()
      local cmd

      if vim.fn.executable('fd') == 1 then
        cmd = string.format("fd -e md -t f . '%s'", workspace_path)
      elseif vim.fn.executable('rg') == 1 then
        cmd = string.format("rg --files --type md '%s'", workspace_path)
      else
        cmd = string.format("find '%s' -name '*.md' -type f", workspace_path)
      end

      local output = vim.fn.system(cmd)
      local files = {}

      if vim.v.shell_error == 0 then
        for file in output:gmatch("[^\r\n]+") do
          if file ~= "" and vim.fn.filereadable(file) == 1 then
            table.insert(files, file)
          end
        end
      end

      table.sort(files)

      picker("Find Notes", files, function(file)
        vim.cmd("edit " .. file)
      end, true, function(prompt_bufnr, map)
        map("i", "<C-d>", function()
          local selection = require("telescope.actions.state").get_selected_entry()
          if selection and selection.value then
            os.remove(selection.value)
            local current_line = require("telescope.actions.state").get_current_line()
            require("telescope.actions").close(prompt_bufnr)
            vim.schedule(function()
              obsidian_config.find_notes()
              if current_line ~= "" then
                vim.api.nvim_feedkeys(current_line, "n", false)
              end
            end)
          end
        end)
      end)
    end

    function obsidian_config.show_backlinks()
      local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t:r")
      local workspace_path = get_workspace()

      local cmd = string.format("rg --with-filename --line-number '\\[\\[.*%s.*\\]\\]' '%s' --type md", filename,
        workspace_path)
      local output = vim.fn.system(cmd)
      local results = {}

      if vim.v.shell_error == 0 then
        for line in output:gmatch("[^\r\n]+") do
          if line ~= "" then
            table.insert(results, line)
          end
        end
      end

      if #results == 0 then
        print("No backlinks found for " .. filename)
        return
      end

      require("telescope.pickers").new(telescope_config("Backlinks", nil), {
        finder = require("telescope.finders").new_table({
          results = results,
          entry_maker = function(entry)
            local file_path, lnum, text = entry:match("^([^:]+):(%d+):(.*)$")
            if not file_path then return end

            local current_workspace = get_workspace()
            local relative_path = file_path:gsub("^" .. vim.pesc(current_workspace) .. "/", "")
            local folder = vim.fn.fnamemodify(relative_path, ":h")
            local file_name = vim.fn.fnamemodify(relative_path, ":t")

            local display_text
            if folder and folder ~= "." then
              local entry_display = require("telescope.pickers.entry_display")
              local displayer = entry_display.create {
                separator = "/",
                items = {
                  { width = nil },
                  { width = nil },
                },
              }
              display_text = displayer {
                folder,
                { file_name, "ObsidianParentDir" },
              }
            else
              display_text = file_name
            end

            return {
              value = entry,
              display = display_text,
              ordinal = file_path,
              filename = file_path,
              lnum = tonumber(lnum),
              text = text,
            }
          end,
        }),
        sorter = require("telescope.config").values.generic_sorter({}),
      }):find()
    end

    function obsidian_config.show_links()
      local current_file = vim.api.nvim_buf_get_name(0)

      local cmd = string.format("rg --with-filename --line-number '\\[\\[.*\\]\\]' '%s'", current_file)
      local output = vim.fn.system(cmd)
      local results = {}

      if vim.v.shell_error == 0 then
        for line in output:gmatch("[^\r\n]+") do
          if line ~= "" then
            table.insert(results, line)
          end
        end
      end

      if #results == 0 then
        print("No links found in current file")
        return
      end

      require("telescope.pickers").new(telescope_config("Links", nil), {
        finder = require("telescope.finders").new_table({
          results = results,
          entry_maker = function(entry)
            local file_path, lnum, text = entry:match("^([^:]+):(%d+):(.*)$")
            if not file_path then return end

            local link_content = text:match("%[%[(.-)%]%]")
            local display_text = link_content or text

            return {
              value = entry,
              display = display_text,
              ordinal = text,
              filename = file_path,
              lnum = tonumber(lnum),
              text = text,
            }
          end,
        }),
        sorter = require("telescope.config").values.generic_sorter({}),
      }):find()
    end

    function obsidian_config.find_tags()
      local function show_tags()
        picker("Find Tags", get_tags(), function(tag)
          picker("Files with tag: " .. tag, get_files_with_tag(tag), function(file)
            vim.cmd("edit " .. file)
          end, true, function(prompt_bufnr, map)
            map("i", "<Esc>", function()
              require("telescope.actions").close(prompt_bufnr)
              vim.schedule(show_tags)
            end)
            map("n", "<Esc>", function()
              require("telescope.actions").close(prompt_bufnr)
              vim.schedule(show_tags)
            end)
          end)
        end, false)
      end
      show_tags()
    end

    function obsidian_config.switch_workspace()
      local available = {}
      for _, ws in ipairs(WORKSPACES) do
        if ws.name ~= vim.g.obsidian_current_workspace then
          table.insert(available, ws.name)
        end
      end

      picker("Switch Workspace", available, function(ws)
        vim.g.obsidian_current_workspace = ws
        tag_cache = {}
        cache_timestamp = 0
        print("Switched to " .. ws .. " workspace - tag cache cleared")
      end, false)
    end

    package.loaded["obsidian-config"] = obsidian_config

    require("obsidian").setup({
      workspaces = WORKSPACES,
      templates = { subdir = "templates", date_format = "%Y-%m-%d", time_format = "%H:%M" },
      completion = { nvim_cmp = true, min_chars = 2, use_path_only = true },

      mappings = {
        ["gf"] = {
          action = function()
            local cfile = vim.fn.expand('<cfile>')

            -- Handle wikilink with alias: [[filename|alias]] - extract just the filename
            local filename = cfile:match('%[%[([^|%]]+)')
            if filename then
              cfile = filename
            else
              -- Strip simple wikilink brackets
              cfile = cfile:gsub('%[%[', ''):gsub('%]%]', '')
            end

            -- Handle URLs (http/https)
            if cfile:match('^https?://') then
              vim.fn.system('open ' .. vim.fn.shellescape(cfile))
              return ""
            end

            -- If it's an image file, open it
            if cfile:match('%.png$') or cfile:match('%.jpg$') or cfile:match('%.jpeg$') then
              local full_path = vim.fn.expand('%:p:h:h') .. '/attachments/' .. cfile
              vim.fn.system('open ' .. vim.fn.shellescape(full_path))
              return ""
            end

            -- If it's a YAML/YML file, open it in vim
            if cfile:match('%.ya?ml$') then
              local workspace_path = get_workspace()
              local full_path = workspace_path .. '/' .. cfile
              if vim.fn.filereadable(full_path) == 1 then
                vim.cmd('edit ' .. vim.fn.fnameescape(full_path))
                return ""
              end
            end

            -- For everything else, use obsidian default
            return require("obsidian").util.gf_passthrough()
          end,
          opts = { noremap = false, expr = true, buffer = true },
        },
        ["<leader>ch"] = {
          action = function() return require("obsidian").util.toggle_checkbox() end,
          opts = { buffer = true },
        },
      },
      new_notes_location = "current_dir",

      wiki_link_func = function(opts)
        return string.format("[[%s]]", opts.path:match("([^/]+)%.md$") or opts.path)
      end,

      note_id_func = function(title)
        local date = os.date("%Y-%m-%d")
        local safe_title = title:gsub("[^%w%s%-]", ""):gsub("%s+", "-"):lower()
        return string.format("%s-%s", date, safe_title)
      end,

      sort_by = "modified",
      sort_reversed = true,
      ui = {
        enable = true,
        update_debounce = 200,
        checkboxes = {
          [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
          ["x"] = { char = "", hl_group = "ObsidianDone" },
          [">"] = { char = "", hl_group = "ObsidianRightArrow" },
          ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
        },
        external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
        reference_text = { hl_group = "ObsidianRefText" },
        highlight_text = { hl_group = "ObsidianHighlightText" },
        tags = { hl_group = "ObsidianTag" },
        hl_groups = {
          ObsidianTodo = { bold = true, fg = "#9E8069" },
          ObsidianDone = { bold = true, fg = "#9E8069" },
          ObsidianRightArrow = { bold = true, fg = "#9E8069" },
          ObsidianTilde = { bold = true, fg = "#9E8069" },
          ObsidianRefText = { underline = true, fg = "#7DAEA3" },
          ObsidianExtLinkIcon = { fg = "#9E8069" },
          ObsidianTag = { italic = true, fg = "#9E8069" },
          ObsidianHighlightText = { bg = "#9E8069" },
          ObsidianBlockID = { italic = true, fg = "#9E8069" },
        },
      },
      attachments = { img_folder = "attachments" },
    })
  end
}
