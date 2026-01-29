return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    ---@module "conform"
    ---@type conform.setupOpts
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        sql = { "sqruff" },
        fish = { "fish_indent" },
        -- Optimized order: Fix -> Organize -> Format -> Docstrings
        python = { "ruff_fix", "ruff_organize_imports", "ruff_format", "docformatter" },
        nginx = { "nginxfmt" },
        nu = { "topiary_nu" },
        -- Add support for common config/web files
        json = { "prettierd" },
        yaml = { "prettierd" },
        markdown = { "prettierd" },
        javascript = { "prettierd" },
        typescript = { "prettierd" },
      },
      formatters = {
        topiary_nu = {
          command = "topiary",
          args = { "format", "--language", "nu" },
        },
        prettierd = {
          command = "prettierd",
        },
      },
      default_format_opts = {
        lsp_format = "fallback",
      },
      -- Increased timeout to preventing aborting on larger files
      format_on_save = { timeout_ms = 2500 },
    },
  },
}
