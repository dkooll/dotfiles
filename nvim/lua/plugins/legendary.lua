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
    })
  end,
}
