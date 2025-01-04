return {
  "mrjones2014/legendary.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  keys = {
    {
      "<S-l>",
      function()
        require("legendary").find()
        vim.api.nvim_feedkeys("i", "n", false)
      end,
      desc = "Open Legendary Command Menu (Insert Mode)",
    },
  },
  config = function()
    require("legendary").setup({
      lazy_nvim = {
        auto_register = true,
      },
      include_builtin = false,
      include_legendary_cmds = false,
      select_prompt = "Legendary",
      col_separator_char = '',
      sort = {
        most_recent_first = false,
        user_items_first = false,
      },
      extensions = {
        lazy_nvim = true,
      },
      keymaps = {
        {
          itemgroup = "Core",
          description = "Custom keybindings",
          keymaps = {
            -- window navigation - showing intuitive keys but executing vim commands
            { "<C-w> Left",  "<C-w>h", description = "Move to left window" },
            { "<C-w> Down",  "<C-w>j", description = "Move to window below" },
            { "<C-w> Up",    "<C-w>k", description = "Move to window above" },
            { "<C-w> Right", "<C-w>l", description = "Move to right window" },
          }
        },
        {
          itemgroup = "Tmux",
          description = "Tmux Key Mapping Reference Only",
          keymaps = {
            { "<C-a> o",          "Cycle through panes",       mode = { "n" }, description = "Tmux: cycle through panes" },
            { "<C-a> Left",       "Move to left pane",         mode = { "n" }, description = "Tmux: move to left pane" },
            { "<C-a> Right",      "Move to right pane",        mode = { "n" }, description = "Tmux: move to right pane" },
            { "<C-a> Up",         "Move to pane above",        mode = { "n" }, description = "Tmux: move to pane above" },
            { "<C-a> Down",       "Move to pane below",        mode = { "n" }, description = "Tmux: move to pane below" },
            { "<C-a> Left/Right", "Switch tmux sessions",      mode = { "n" }, description = "Tmux: switch between sessions" },
            { "<C-a> |",          "Split window vertically",   mode = { "n" }, description = "Tmux: vertical split" },
            { "<C-a> -",          "Split window horizontally", mode = { "n" }, description = "Tmux: horizontal split" },
            { "<C-a> z",          "Toggle zoom pane",          mode = { "n" }, description = "Tmux: toggle zoom current pane" },
            { "<C-a> c",          "New window",                mode = { "n" }, description = "Tmux: create new window" },
            { "<C-a> t",          "Toggle status bar",         mode = { "n" }, description = "Tmux: toggle status bar" },
          }
        }
      },
    })
  end,
}
