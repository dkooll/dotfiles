return {
  "dkooll/bouncer.nvim",
  cmd = { "BounceModuleToLocal", "BounceModuleToRegistry", "BounceModulesToRegistry" },
  config = function()
    require("bouncer").setup({
      namespace = "cloudnationhq",
    })
  end
}
