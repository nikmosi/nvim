vim.opt.termguicolors = true
require "config.opt"
require "config.yank_highlight"
require "config.filetypes"
require "config.lazy"
require "config.remap"
require "config.diagnostic"

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "gitcommit", "git_rebase" },
  desc = "Use vim regex syntax for git files (treesitter grammar is incomplete)",
  callback = function(args) vim.bo[args.buf].syntax = "on" end,
})

require "config.lsp"

vim.cmd.colorscheme "tokyonight-night"
