require("config.options")
require("config.keymaps")
require("config.autocmds")
--require("plugins")
require("config.lazy")

-- Require the built-in LSP client
-- TODO: move this
local lsp = require('lspconfig')

-- Configure the gopls language server
lsp.gopls.setup {}
--.TODO: phase out zero lsp and replace it with mason.lua in plugins/lsp/mason.lua , https://www.youtube.com/watch?v=6pAG3BHurdM&t=4037s
--  https://github.com/adibhanna/nvim/blob/main/lua/plugins/lsp.lua uses plugin.lsp.servers
-- then move plugin from modules into plugins
