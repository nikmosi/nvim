return {
    -- Treesitter для синтаксического анализа
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {},
                sync_install = false,
                auto_install = false,
                ignore_install = {},
                modules = {};
                highlight = {
                    enable = true,
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
            })
        end,
    },

    -- Treesitter Context для отображения области функции вверху экрана
    {
        "nvim-treesitter/nvim-treesitter-context",
        config = function()
            require("treesitter-context").setup({
                enable = true,   -- Включение плагина
                max_lines = 3,   -- Максимальное количество строк для отображения
                mode = "cursor", -- Режим отображения (по курсору)
            })
        end,
    },
}
