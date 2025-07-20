return {
  "monaqa/dial.nvim",
  keys = {
    {
      "<C-a>",
      function() require("dial.map").manipulate("increment", "normal") end,
      mode = "n",
      desc = "Dial Increment",
    },
    {
      "<C-x>",
      function() require("dial.map").manipulate("decrement", "normal") end,
      mode = "n",
      desc = "Dial Decrement",
    },
  },
  config = function()
    local augend = require "dial.augend"
    require("dial.config").augends:register_group {
      default = {
        augend.constant.new { elements = { "true", "false" }, word = true, cyclic = true },
        augend.constant.new { elements = { "True", "False" }, word = true, cyclic = true },
        augend.constant.new { elements = { "on", "off" }, word = true, cyclic = true },
        augend.constant.new { elements = { "yes", "no" }, word = true, cyclic = true },
        augend.constant.new { elements = { "enable", "disable" }, word = true, cyclic = true },
        augend.integer.alias.decimal,
        augend.date.alias["%Y/%m/%d"],
      },
    }
  end,
}
