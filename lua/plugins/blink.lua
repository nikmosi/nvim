return {
  "saghen/blink.cmp",
  event = "BufRead",
  dependencies = { "rafamadriz/friendly-snippets", "echasnovski/mini.icons" },

  version = "*",
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
    -- 'super-tab' for mappings similar to vscode (tab to accept)
    -- 'enter' for enter to accept
    -- 'none' for no mappings
    --
    -- All presets have the following mappings:
    -- C-space: Open menu or open docs if already open
    -- C-n/C-p or Up/Down: Select next/previous item
    -- C-e: Hide menu
    -- C-k: Toggle signature help (if signature.enabled = true)
    --
    -- See :h blink-cmp-config-keymap for defining your own keymap
    keymap = { preset = "super-tab" },

    appearance = {
      nerd_font_variant = "mono",
    },

    sources = {
      default = { "lsp", "path", "snippets", "buffer" },

      providers = {
        lsp = {
          name = "LSP",
          module = "blink.cmp.sources.lsp",
          opts = {}, -- Passed to the source directly, varies by source

          --- NOTE: All of these options may be functions to get dynamic behavior
          --- See the type definitions for more information
          enabled = true, -- Whether or not to enable the provider
          async = false, -- Whether we should wait for the provider to return before showing the completions
          timeout_ms = 2000, -- How long to wait for the provider to return before showing completions and treating it as asynchronous
          transform_items = nil, -- Function to transform the items before they're returned
          should_show_items = true, -- Whether or not to show the items
          max_items = nil, -- Maximum number of items to display in the menu
          min_keyword_length = 0, -- Minimum number of characters in the keyword to trigger the provider
          -- If this provider returns 0 items, it will fallback to these providers.
          -- If multiple providers fallback to the same provider, all of the providers must return 0 items for it to fallback
          fallbacks = {},
          score_offset = -7, -- Boost/penalize the score of the items
          override = nil, -- Override the source's functions
        },
      },
    },

    fuzzy = { implementation = "prefer_rust_with_warning" },
    signature = { enabled = true, window = { border = "single" } },
    completion = {
      documentation = { auto_show = true, auto_show_delay_ms = 500, window = { border = "single" } },
      ghost_text = { enabled = true },
      menu = {
        border = "single",
        draw = {
          treesitter = { "lsp" },
          components = {
            kind_icon = {
              ellipsis = false,
              text = function(ctx)
                local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
                return kind_icon
              end,
              highlight = function(ctx)
                local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                return hl
              end,
            },
          },
        },
      },
    },
  },
  opts_extend = { "sources.default" },
}
