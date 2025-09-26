return {
  -- Treesitter для синтаксического анализа
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufRead",
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = { "c", "python", "git_rebase", "gitcommit" },
        sync_install = false,
        auto_install = true,
        ignore_install = {},
        modules = {},
        highlight = {
          enable = true,
          disable = {},
          additional_vim_regex_highlighting = { "gitcommit", "git_rebase" },
        },
        -- Включение выделения scope текущей функции
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<leader>tn", -- Начало выделения
            node_incremental = "<leader>tn", -- Расширение выделения
            scope_incremental = "<leader>tc", -- Выделение scope (области)
            node_decremental = "<leader>tm", -- Сужение выделения
          },
        },
      }
      vim.treesitter.language.register("yaml", "compose.yml")
    end,
  },

  -- Treesitter Context для отображения области функции вверху экрана
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufRead",
    opts = {
      enable = true, -- Включение плагина
      max_lines = 2, -- Максимальное количество строк для отображения
      mode = "cursor", -- Режим отображения (по курсору)
    },
  },
}
