local function make_key(key, func_name, desc, param1, param2)
  local action = param1 and function() require("obsidian-config")[func_name](param1, param2) end
      or function() require("obsidian-config")[func_name]() end
  return { key, action, desc = "Obsidian: " .. desc }
end

return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    make_key("<leader>onf", "create_note", "New fleeting note", "fleeting", "Fleeting note title: "),
    make_key("<leader>onl", "create_note", "New literature note", "literature", "Literature note title: "),
    make_key("<leader>onp", "create_note", "New permanent note", "permanent", "Permanent note title: "),
    make_key("<leader>os", "search_notes", "Search notes content"),
    make_key("<leader>of", "find_notes", "Find notes"),
    make_key("<leader>ob", "show_backlinks", "Show backlinks"),
    make_key("<leader>ol", "show_links", "Show links"),
    { "<leader>or", "<cmd>ObsidianRename<CR>", desc = "Obsidian: Rename note" },
    make_key("<leader>ow", "switch_workspace", "Switch workspace"),
    make_key("<leader>ot", "find_tags", "Find tags"),
  },

  config = function()
    local NOTES_PATH_PATTERN = "Documents/.*%-notes"
    local WORKSPACES = {
      { name = "tech",    path = "~/Documents/tech-notes" },
      { name = "worship", path = "~/Documents/worship-notes" },
    }

    local highlights = {
      NotesBrown = { fg = "#9E8069" },
      NotesBrownBold = { fg = "#9E8069", bold = true },
      NotesBrownItalic = { fg = "#9E8069", italic = true },
      NotesPink = { fg = "#D3869B" },
      NotesBlue = { fg = "#7DAEA3" },
      ObsidianParentDir = { fg = "#9E8069", bold = false },
      NotesWhiteItalic = { fg = "#C0B8A8", italic = true },
      NotesWhiteItalicDark = { fg = "#968A80", italic = true },
      NotesLightItalic = { fg = "#C0B8A8", italic = true },
      NotesYamlString = { fg = "#968A80", italic = true },
      NotesYamlKey = { fg = "#C0B8A8", italic = false },
      ['@markup.raw.block.markdown.markdown'] = { fg = "#968A80", italic = true },
      markdownCodeBlock = { fg = "#968A80", italic = true },
    }
    for name, opts in pairs(highlights) do
      vim.api.nvim_set_hl(0, name, opts)
    end

    local NOTES_HIGHLIGHTS =
    '@punctuation.special:NotesBrown,@markup.heading.1.markdown:NotesLightItalic,@markup.heading.2.markdown:NotesLightItalic,@markup.heading.3.markdown:NotesLightItalic,@markup.heading.4.markdown:NotesLightItalic,@markup.heading.5.markdown:NotesLightItalic,@markup.heading.6.markdown:NotesLightItalic,@markup.heading:NotesLightItalic,markdownCode:NotesWhiteItalic,@markup.raw.markdown_inline:NotesWhiteItalic,@text.literal.markdown_inline:NotesWhiteItalic,@markup.strong.markdown_inline:NotesLightItalic,markdownItalic:NotesLightItalic,markdownItalicDelimiter:NotesLightItalic,@text.emphasis:NotesLightItalic,@text.strong:NotesLightItalic,@markup.italic.markdown_inline:NotesLightItalic,@markup.bold.markdown_inline:NotesLightItalic,@markup.link.label:NotesBlue,@markup.link:NotesBlue,@keyword.directive:NotesWhiteItalic,@property:NotesYamlKey,@property.yaml:NotesYamlKey,@string.yaml:NotesYamlString'

    local function is_notes_file(filename)
      return vim.bo.filetype == "markdown" and filename:match(NOTES_PATH_PATTERN)
    end

    local autocmds = {
      { "BufWritePre", "*.md", function()
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
      end },
      { { "BufEnter", "BufWinEnter" }, "*", function()
        local filename = vim.api.nvim_buf_get_name(0)
        if is_notes_file(filename) then
          vim.opt_local.conceallevel = 2
          vim.opt_local.wrap = true
          vim.opt_local.linebreak = true
          vim.wo.winhighlight = NOTES_HIGHLIGHTS
        end
      end },
      { "BufLeave", "*", function()
        local filename = vim.api.nvim_buf_get_name(0)
        if is_notes_file(filename) then
          vim.wo.winhighlight = ''
        end
      end },
      { { "BufRead", "BufNewFile", "WinEnter", "ColorScheme" }, "*", function()
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
      end },
      { { "BufEnter", "BufWinEnter" }, { "*.yaml", "*.yml" }, function()
        local filename = vim.api.nvim_buf_get_name(0)
        if not filename:match(NOTES_PATH_PATTERN) then
          vim.wo.winhighlight = ''
        end
      end }
    }

    for _, autocmd in ipairs(autocmds) do
      vim.api.nvim_create_autocmd(autocmd[1], { pattern = autocmd[2], callback = autocmd[3] })
    end

    local obsidian_config = {}
    vim.g.obsidian_current_workspace = WORKSPACES[1].name
    local tag_cache, cache_timestamp = {}, 0

    local function get_workspace()
      for _, workspace in ipairs(WORKSPACES) do
        if workspace.name == vim.g.obsidian_current_workspace then
          return vim.fn.expand(workspace.path)
        end
      end
      return vim.fn.expand(WORKSPACES[1].path)
    end

    local function telescope_config(title, cwd)
      return require("telescope.themes").get_ivy({
        prompt_title = title .. " (" .. vim.g.obsidian_current_workspace .. ")",
        cwd = cwd,
        previewer = false,
        layout_config = { height = 0.31 },
      })
    end

    local function make_file_display(file_path, workspace_path)
      local relative_path = file_path:gsub("^" .. vim.pesc(workspace_path) .. "/", "")
      local folder = vim.fn.fnamemodify(relative_path, ":h")
      local filename = vim.fn.fnamemodify(relative_path, ":t")

      if folder and folder ~= "." then
        local entry_display = require("telescope.pickers.entry_display")
        local displayer = entry_display.create {
          separator = "/",
          items = { { width = nil }, { width = nil } },
        }
        return displayer { folder, { filename, "ObsidianParentDir" } }
      end
      return filename
    end

    local function picker(title, items, on_select, is_files, mappings)
      require("telescope.pickers").new(telescope_config(title, nil), {
        finder = require("telescope.finders").new_table({
          results = items,
          entry_maker = function(entry)
            if is_files then
              local workspace_path = get_workspace()
              local relative_path = entry:gsub("^" .. vim.pesc(workspace_path) .. "/", "")
              local folder = vim.fn.fnamemodify(relative_path, ":h")
              local filename = vim.fn.fnamemodify(relative_path, ":t")
              return {
                value = entry,
                display = make_file_display(entry, workspace_path),
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
            if selection and on_select then on_select(selection.value) end
          end)
          if mappings then mappings(prompt_bufnr, map) end
          return true
        end,
      }):find()
    end

    local function get_tags()
      local now = os.time()
      if tag_cache.data and (now - cache_timestamp) < 30 then return tag_cache.data end

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
          if tag and tag ~= "" then tag_set[tag] = true end
        end
      end

      local tags = {}
      for tag, _ in pairs(tag_set) do table.insert(tags, tag) end
      table.sort(tags)
      tag_cache.data, cache_timestamp = tags, now
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
          if file ~= "" then table.insert(files, file) end
        end
      end
      return files
    end

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
      require("telescope.pickers").new(telescope_config("Search Notes", get_workspace()), {
        finder = require("telescope.finders").new_job(function(prompt)
          if not prompt or prompt == "" then return nil end
          return { "rg", "--with-filename", "--line-number", "--column", "--smart-case", prompt, get_workspace(),
            "--type", "md" }
        end, function(entry)
          local make_entry = require("telescope.make_entry")
          local default_entry = make_entry.gen_from_vimgrep({})(entry)
          if not default_entry then return end
          default_entry.display = make_file_display(default_entry.filename, get_workspace())
          return default_entry
        end, 120),
        sorter = require("telescope.config").values.generic_sorter({}),
      }):find()
    end

    function obsidian_config.find_notes()
      local workspace_path = get_workspace()
      local cmd = vim.fn.executable('fd') == 1 and string.format("fd -e md -t f . '%s'", workspace_path) or
          vim.fn.executable('rg') == 1 and string.format("rg --files --type md '%s'", workspace_path) or
          string.format("find '%s' -name '*.md' -type f", workspace_path)

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

      picker("Find Notes", files, function(file) vim.cmd("edit " .. file) end, true, function(prompt_bufnr, map)
        map("i", "<C-d>", function()
          local selection = require("telescope.actions.state").get_selected_entry()
          if selection and selection.value then
            os.remove(selection.value)
            local current_line = require("telescope.actions.state").get_current_line()
            require("telescope.actions").close(prompt_bufnr)
            vim.schedule(function()
              obsidian_config.find_notes()
              if current_line ~= "" then vim.api.nvim_feedkeys(current_line, "n", false) end
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
          if line ~= "" then table.insert(results, line) end
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
            return {
              value = entry,
              display = make_file_display(file_path, get_workspace()),
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
          if line ~= "" then table.insert(results, line) end
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
            return {
              value = entry,
              display = link_content or text,
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
            local back_to_tags = function()
              require("telescope.actions").close(prompt_bufnr)
              vim.schedule(show_tags)
            end
            map("i", "<Esc>", back_to_tags)
            map("n", "<Esc>", back_to_tags)
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
        tag_cache, cache_timestamp = {}, 0
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
              return
            end

            -- If it's an image file, open it
            if cfile:match('%.png$') or cfile:match('%.jpg$') or cfile:match('%.jpeg$') then
              local full_path = vim.fn.expand('%:p:h:h') .. '/attachments/' .. cfile
              vim.fn.system('open ' .. vim.fn.shellescape(full_path))
              return
            end

            -- If it's a YAML file, open it from configs directory
            if cfile:match('%.ya?ml$') then
              local full_path = vim.fn.expand('%:p:h:h') .. '/configs/' .. cfile
              if vim.fn.filereadable(full_path) == 1 then
                vim.cmd('edit ' .. vim.fn.fnameescape(full_path))
              else
                print("YAML file not found: " .. full_path)
              end
              return
            end

            -- For everything else, use obsidian default
            require("obsidian").util.gf_passthrough()
          end,
          opts = { noremap = false, expr = false, buffer = true },
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
