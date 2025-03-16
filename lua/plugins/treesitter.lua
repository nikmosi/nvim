return {
  -- Treesitter для синтаксического анализа
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require "nvim-treesitter.configs".setup {
        ensure_installed = { "c", "python", "git_rebase" },
        sync_install = false,
        auto_install = true,
        ignore_install = { "gitcommit", },
        modules = {},
        highlight = {
          enable = true,
          disable = { "git_rebase" },
          additional_vim_regex_highlighting = { "gitcommit" },
        },
        -- Включение выделения scope текущей функции
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",    -- Начало выделения
            node_incremental = "grn",  -- Расширение выделения
            scope_incremental = "grc", -- Выделение scope (области)
            node_decremental = "grm",  -- Сужение выделения
          },
        },
      }
      vim.treesitter.language.register("yaml", "compose.yml")
    end,
  },

  -- Treesitter Context для отображения области функции вверху экрана
  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = {
      enable = true,   -- Включение плагина
      max_lines = 2,   -- Максимальное количество строк для отображения
      mode = "cursor", -- Режим отображения (по курсору)
    }
  },
}
