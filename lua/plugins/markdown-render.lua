return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" }, -- if you use standalone mini plugins
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    completions = { lsp = { enabled = true } },
    render_modes = true,
    anti_conceal = {
      ignore = {
        code_language = true,
        code_background = true,
        code_border = true,
      },
    },
  },
}
