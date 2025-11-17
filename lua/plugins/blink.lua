return {
  "saghen/blink.cmp",
  dependencies = {
    "rafamadriz/friendly-snippets",
    "echasnovski/mini.icons",
    { "Kaiser-Yang/blink-cmp-git", dependencies = { "nvim-lua/plenary.nvim" } },
  },

  version = "*",
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = { preset = "super-tab" },

    appearance = {
      nerd_font_variant = "mono",
    },

    sources = {
      default = { "lsp", "path", "buffer", "snippetsc" },

      providers = {
        lsp = {
          name = "LSP",
          module = "blink.cmp.sources.lsp",
          transform_items = function(_, items)
            local types = require "blink.cmp.types"
            return vim.tbl_filter(function(item) return item.kind ~= types.CompletionItemKind.Keyword end, items)
          end,
        },
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",

          score_offset = 100,
        },
        snippetsc = {
          name = "SNIPPETS",
          module = "blink.cmp.sources.snippets",
          opts = {},

          enabled = true,
          async = false,
          timeout_ms = 2000,
          transform_items = nil,
          should_show_items = true,
          max_items = nil,
          min_keyword_length = 0,

          fallbacks = {},
          score_offset = 0,
          override = nil,
        },

        git = {
          module = "blink-cmp-git",
          name = "Git",

          enabled = function() return vim.tbl_contains({ "octo", "gitcommit", "markdown" }, vim.bo.filetype) end,
          --- @module 'blink-cmp-git'
          --- @type blink-cmp-git.Options
          opts = {
            commit = {},
            git_centers = {
              github = {},
              gitlab = {},
            },
          },
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
            kind = {
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
