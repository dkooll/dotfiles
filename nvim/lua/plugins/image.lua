return {
  {
    "3rd/image.nvim",
    ft = { "markdown" },
    event = {
      "BufReadPre *.png",
      "BufReadPre *.jpg",
      "BufReadPre *.jpeg",
    },
    config = function()
      local image = require("image")

      image.setup({
        backend = "kitty",
        integrations = {
          markdown = {
            enabled = true,
            download_remote_images = true,
            only_render_image_at_cursor = true,
            filetypes = { "markdown" }
          },
        },
        max_width = nil,  -- Maximum width of the image (nil means no limit)
        max_height = nil, -- Maximum height of the image
      })
    end,
  },
}
