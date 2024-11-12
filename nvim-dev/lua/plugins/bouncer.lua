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
      "cloudnationhq/kv/azure",
      "cloudnationhq/aa/azure",
      "cloudnationhq/ca/azure",
      "cloudnationhq/fd/azure",
      "cloudnationhq/fw/azure",
      "cloudnationhq/lb/azure",
      "cloudnationhq/nw/azure",
      "cloudnationhq/pe/azure",
      "cloudnationhq/sb/azure",
      "cloudnationhq/vm/azure",
      "cloudnationhq/vmss/azure",
      "cloudnationhq/acr/azure",
      "cloudnationhq/aks/azure",
      "cloudnationhq/agw/azure",
      "cloudnationhq/app/azure",
      "cloudnationhq/dbw/azure",
      "cloudnationhq/dcr/azure",
      "cloudnationhq/evh/azure",
      "cloudnationhq/fwp/azure",
      "cloudnationhq/fdfwp/azure",
      "cloudnationhq/wafwp/azure",
      "cloudnationhq/mag/azure",
      "cloudnationhq/pip/azure",
      "cloudnationhq/rsv/azure",
      "cloudnationhq/sql/azure",
      "cloudnationhq/syn/azure",
      "cloudnationhq/apim/azure",
      "cloudnationhq/appi/azure",
      "cloudnationhq/func/azure",
      "cloudnationhq/pdns/azure",
      "cloudnationhq/costs/azure",
      "cloudnationhq/dnspr/azure",
      "cloudnationhq/mysql/azure",
      "cloudnationhq/redis/azure",
      "cloudnationhq/sqlmi/azure",
      "cloudnationhq/bastion/azure",
      "cloudnationhq/cosmosdb/azure",
    }

    local modules = {}
    for _, source in ipairs(module_sources) do
      table.insert(modules, { registry_source = source })
    end

    require("bouncer").setup(modules)
  end
}
