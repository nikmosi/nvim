return {
  "L3MON4D3/LuaSnip",
  config = function()
    local luasnip = require "luasnip"

    luasnip.config.set_config {
      history = true,
      updateevents = "TextChanged,TextChangedI",
    }

    require("luasnip.loaders.from_vscode").lazy_load()
  end,
}
