return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    enabled = true,
    anti_conceal = {
      enabled = true,
      ignore = {
        code_background = true,
        sign = true,
        dash = true,
      },
      above = 0,
      below = 0,
    },
    file_types = { "markdown", "chatgpt", "chatgpt-input", "codecompanion" },
    render_modes = true,
    win_options = {
      conceallevel = { rendered = 2 },
      concealcursor = { rendered = "nc" },
    },
    heading = {
      width = "full",
      sign = false,
    },
    dash = {
      width = 80,
      render_modes = true,
    },
    bullet = {
      icons = { "", "•", "", "-", "-" },
    },
    checkbox = {
      unchecked = { icon = "" },
      checked = { icon = "", scope_highlight = "@markup.strikethrough" },
      custom = {
        doing = {
          raw = "[_]",
          rendered = "󰄮",
          highlight = "RenderMarkdownDoing",
        },
        wontdo = {
          raw = "[~]",
          rendered = "󰅗",
          highlight = "RenderMarkdownWontdo",
        },
      },
    },
    document = {
      enabled = true,
      render_modes = false,
      conceal = {
        char_patterns = {},
        line_patterns = {},
      },
    },
    code = {
      width = "block",
      border = "thick",
      min_width = 80,
      highlight_language = "LineNr",
    },
    quote = { icon = "▐" },
    pipe_table = { cell = "raw" },
    link = {
      enabled = true,
      render_modes = true,
      footnote = {
        enabled = true,
        superscript = false,
        prefix = "",
        suffix = "",
      },
      wiki = { icon = "󱗖 ", highlight = "RenderMarkdownWikiLink" },
      custom = {
        gdrive = {
          pattern = "drive%.google%.com/drive",
          icon = " ",
        },
        spreadsheets = {
          pattern = "docs%.google%.com/spreadsheets",
          icon = "󰧷 ",
        },
        document = {
          pattern = "docs%.google%.com/document",
          icon = "󰈙 ",
        },
        presentation = {
          pattern = "docs%.google%.com/presentation",
          icon = "󰈩 ",
        },
      },
    },
    latex = { enabled = false },
    html = { comment = { conceal = false } },
    overrides = {
      filetype = {
        -- CodeCompanion
        codecompanion = {
          heading = {
            icons = { "󰪥 ", "  ", " ", " ", " ", "" },
            custom = {
              codecompanion_input = {
                pattern = "^## Me$",
                icon = " ",
                background = "CodeCompanionInputHeader",
              },
            },
          },
          html = {
            tag = {
              buf = {
                icon = "󰌹 ",
                highlight = "Comment",
              },
              file = {
                icon = "󰨸 ",
                highlight = "Comment",
              },
              url = {
                icon = " ",
                highlight = "Comment",
              },
            },
          },
        },
      },
    },
  },
}
