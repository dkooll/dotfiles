--return {
--{
--"amitds1997/remote-nvim.nvim",
--version = "*",                      -- Pin to GitHub releases
--dependencies = {
--"nvim-lua/plenary.nvim",          -- For standard functions
--"MunifTanjim/nui.nvim",           -- To build the plugin UI
--"nvim-telescope/telescope.nvim",  -- For picking b/w different remote methods
--},
--config = true,
--}
--}

return {
  {
    "amitds1997/remote-nvim.nvim",
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-telescope/telescope.nvim",
    },
    cmd = {
      "RemoteStart",
      "RemoteList",
      "RemoteReload",
      "RemoteStop",
      "RemoteInfo",
      "RemoteLog",
    },
    keys = {
      { "<leader>rs", "<cmd>RemoteStart<cr>", desc = "Remote Start" },
      { "<leader>rl", "<cmd>RemoteList<cr>", desc = "Remote List" },
    },
    config = function()
      require("remote-nvim").setup({
        devpod = {
          binary = "devpod",
          docker_binary = "docker",
          search_style = "current_dir_only",
          dotfiles = {
            path = "https://github.com/dkooll/dotfiles",
            install_script = "install.sh"
          },
          gpg_agent_forwarding = false,
          container_list = "running_only",
        },
      })
    end,
  }
}

--return {
  --{
    --"amitds1997/remote-nvim.nvim",
    --version = "*",                     -- Pin to GitHub releases
    --dependencies = {
      --"nvim-lua/plenary.nvim",         -- For standard functions
      --"MunifTanjim/nui.nvim",          -- To build the plugin UI
      --"nvim-telescope/telescope.nvim", -- For picking b/w different remote methods
    --},
    --config = function()
      --require("remote-nvim").setup({
        --devpod = {
          --binary = "devpod",
          --docker_binary = "docker",
          --search_style = "current_dir_only",
          --dotfiles = {
            --path = "https://github.com/dkooll/dotfiles",
            --install_script = "install.sh"
          --},
          --gpg_agent_forwarding = false,
          --container_list = "running_only",
        --},
      --})
    --end,
  --}
--}
