return {
  {
    "arborist-ts/arborist.nvim",
    dependencies = { "neovim-treesitter/treesitter-parser-registry" },
    event = "BufRead",
    opts = {
      auto_install = true,
      parsers = {
        vim = false,
      },
      overrides = {},
    },
    config = function()
      local parser_install_dir = vim.fn.stdpath "data" .. "/treesitter"
      vim.fn.mkdir(parser_install_dir, "p")
      vim.opt.runtimepath:prepend(parser_install_dir)

      vim.treesitter.language.register("python", "xonsh")
      vim.treesitter.language.register("yaml", "yaml.docker-compose")
    end,
  },
}
