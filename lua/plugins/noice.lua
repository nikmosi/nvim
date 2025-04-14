return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    notify = {
      enabled = false,
    },
    lsp = {
      progress = {
        enabled = false,
      },
      override = {
        -- override the default lsp markdown formatter with Noice
        ["vim.lsp.util.convert_input_to_markdown_lines"] = false,
        -- override the lsp markdown formatter with Noice
        ["vim.lsp.util.stylize_markdown"] = false,
        -- override cmp documentation with Noice (needs the other options to work)
        ["cmp.entry.get_documentation"] = false,
      },
      hover = {
        enabled = true,
        silent = false, -- set to true to not show a message if hover is not available
        view = nil, -- when nil, use defaults from documentation
        ---@type NoiceViewOptions
        opts = {}, -- merged with defaults from documentation
      },
      signature = {
        enabled = true,
        auto_open = {
          enabled = true,
          trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
          luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
          throttle = 50, -- Debounce lsp signature help request by 50ms
        },
        view = nil, -- when nil, use defaults from documentation
        ---@type NoiceViewOptions
        opts = {}, -- merged with defaults from documentation
      },
      message = {
        -- Messages shown by lsp servers
        enabled = false,
        view = "notify",
        opts = {},
      },
      -- defaults for hover and signature help
      documentation = {
        view = "hover",
        ---@type NoiceViewOptions
        opts = {
          lang = "markdown",
          replace = true,
          render = "plain",
          format = { "{message}" },
          win_options = { concealcursor = "n", conceallevel = 3 },
        },
      },
    },
  },
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
}
