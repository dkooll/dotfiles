return {
  {
    "dnlhc/glance.nvim",
    cmd = "Glance",
    config = function()
      local hi = vim.api.nvim_set_hl

      hi(0, "GlanceListFilepath", { fg = "#9E8069" })
      hi(0, "GlanceWinBarFilename", { fg = "#9E8069" })
      hi(0, "GlanceWinBarFilepath", { fg = "#9E8069" })
      hi(0, "GlanceListCursorLine", { bg = "NONE" })
      hi(0, "GlancePreviewMatch", { fg = "#9E8069", bg = "NONE" }) --
      hi(0, "GlancePreviewCursorLine", { bg = "NONE" })
      hi(0, "GlanceMatch", { fg = "NONE", bg = "NONE" })
      hi(0, "GlanceListMatch", { fg = "#9E8069", bg = "NONE" })
      hi(0, "GlancePreviewNormal", { fg = "NONE", bg = "NONE" })
      hi(0, "GlancePreview", { fg = "NONE", bg = "NONE" })
      hi(0, "GlanceNormal", { fg = "NONE", bg = "NONE" })
      hi(0, "GlancePreviewLineNr", { fg = "NONE", bg = "NONE" })
      hi(0, "GlancePreviewKeyword", { fg = "#808080", bg = "#808080" })

      require("glance").setup({
        height = 30,
        border = {
          enable = true,
          characters = {
            '╭', '─', '╮',
            '│', '│',
            '╰', '─', '╯'
          },
        },
        preview_win_opts = {
          cursorline = true,
          number = false,
          wrap = true,
        },
        list = {
          position = 'right',
          width = 0.33,
        },
        theme = {
          enable = false,
        },
        indent_lines = {
          enable = true,
          icon = '│',
        },
        folds = {
          fold_closed = '',
          fold_open = '',
          folded = true,
        },
        winbar = {
          enable = true,
        }
      })
    end
  }
}
