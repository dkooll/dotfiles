return {
  "dkooll/bouncer.nvim",
  event = "VeryLazy",
  config = function()
    local module_sources = {
      "cloudnationhq/sa/azure",
      "cloudnationhq/rg/azure",
      "cloudnationhq/vnet/azure",
      "cloudnationhq/eg/azure",
      "cloudnationhq/vwan/azure",
      "cloudnationhq/law/azure",
      "cloudnationhq/vgw/azure",
    }

    local modules = {}
    for _, source in ipairs(module_sources) do
      table.insert(modules, { registry_source = source })
    end

    require("bouncer").setup(modules)
  end
}
