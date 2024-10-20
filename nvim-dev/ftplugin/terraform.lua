 --Check if the required modules are available
local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_ok then
  return
end

-- Set up the Terraform LSP
if lspconfig.terraformls then
  lspconfig.terraformls.setup {
    on_attach = function(_, bufnr)
      -- Set up formatting keymap
      local opts = {
        mode = "n",
        prefix = "<leader>",
        buffer = bufnr,
        silent = true,
        noremap = true,
        nowait = true,
      }

      local mappings = {
        l = {
          f = {
            function()
              vim.lsp.buf.format({ async = true })
            end,
            "Format file"
          },
        },
      }

      which_key.register(mappings, opts)
    end,
  }
end

local bufnr = vim.api.nvim_get_current_buf()
local clients = vim.lsp.get_clients({ name = "terraformls", bufnr = bufnr })
local client = clients[1]

if not client then
  local lsp_client = vim.lsp.start({ name = "terraformls", cmd = { "terraform-ls", "serve" } })
  if lsp_client then
    vim.lsp.buf_attach_client(bufnr, lsp_client)
  end
end
