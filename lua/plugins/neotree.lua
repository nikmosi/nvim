return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  config = function()
    vim.keymap.set("n", "<leader>e", vim.cmd.Neotree)
    require "neo-tree".setup {
      filesystem = {
        filtered_items = {
          visible = true, -- Показывать скрытые файлы
          hide_dotfiles = false,
          hide_gitignored = true,
        },
      },
      default_component_configs = {
        git_status = {
          symbols = {
            added     = "✚", -- или "➕"
            modified  = "", -- или "●"
            deleted   = "✖", -- или "❌"
            renamed   = "➜",
            untracked = "★", -- или "U"
            ignored   = "◌",
            unstaged  = "✗",
            staged    = "✓",
            conflict  = "",
          }
        },
        diagnostics = {
          symbols = {
            hint = "",
            info = "",
            warn = "",
            error = "",
          },
          highlights = {
            hint = "DiagnosticHint",
            info = "DiagnosticInfo",
            warn = "DiagnosticWarn",
            error = "DiagnosticError",
          },
        },
      },
      window = {
        position = "right",
        width = 40,
      },
    }
  end
}
