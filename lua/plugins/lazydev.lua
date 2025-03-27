return {
  "folke/lazydev.nvim",
  ft = "lua", -- only load on lua files
  opts = {
    library = {
      "lazy.nvim",
      "snacks.nvim",
      "blink.cmp",
      "conform",
      "MiniIcons",
      -- It can also be a table with trigger words / mods
      -- Only load luvit types when the `vim.uv` word is found
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      -- always load the LazyVim library
      "LazyVim",
      -- Only load the lazyvim library when the `LazyVim` global is found
      { path = "LazyVim", words = { "LazyVim" } },
    },
    -- always enable unless `vim.g.lazydev_enabled = false`
    -- This is the default
    enabled = function(root_dir)
      if vim.g.lazydev_enabled == false then
        return false
      end
      return not vim.uv.fs_stat(root_dir .. "/.luarc.json")
    end,
  },
}
