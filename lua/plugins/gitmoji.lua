return {
  "Dynge/gitmoji.nvim",
  event = { "BufNewFile", "BufRead *.git/COMMIT_EDITMSG" }, -- Load when opening a git commit message file
  ft = "gitcommit",
  dependencies = {
    "Saghen/blink.cmp",
  },
  config = function()
    require("gitmoji").setup {
      -- Your preferred options here. For now, keep it simple.
      -- e.g., icons_enabled = true,
    }
  end,
}
