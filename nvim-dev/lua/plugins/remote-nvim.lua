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
      { "<leader>rl", "<cmd>RemoteList<cr>",  desc = "Remote List" },
    },
    config = function()
      require("remote-nvim").setup({
        devpod = {
          binary = "devpod",
          docker_binary = "docker",
          search_style = "current_dir_only",
          dotfiles = {
            path = "https://github.com/dkooll/dotfiles-devpod",
            install_script = "install.sh"
          },
          --gpg_agent_forwarding = true,
          container_list = "running_only",
        },
        client_callback = function(port, _)
          require("remote-nvim.ui").float_term(
            ("nvim --server localhost:%s --remote-ui"):format(port),
            function(exit_code)
              if exit_code ~= 0 then
                vim.notify(("Local client failed with exit code %s"):format(exit_code), vim.log.levels.ERROR)
              end
            end,
            {
              border = "none",
              width = vim.o.columns,
              height = vim.o.lines,
              row = 0,
              col = 0,
            }
          )
        end,
      })
    end,
  }
}
