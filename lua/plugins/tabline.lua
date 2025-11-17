return {
  "willothy/nvim-cokeline",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "echasnovski/mini.icons",
  },
  config = function()
    require("mini.icons").setup()
    MiniIcons.mock_nvim_web_devicons()
    vim.keymap.set("n", "L", "<Plug>(cokeline-focus-next)", { silent = true, desc = "Next buffer" })
    vim.keymap.set("n", "H", "<Plug>(cokeline-focus-prev)", { silent = true, desc = "Previous buffer" })
    local get_hex = require("cokeline.hlgroups").get_hl_attr
    local green = vim.g.terminal_color_2
    local yellow = vim.g.terminal_color_3
    require("cokeline").setup {
      show_if_buffers_are_at_least = 0,
      buffers = {
        filter_valid = false,
        filter_visible = false,
        focus_on_delete = "prev",
        new_buffers_position = "last",
        delete_on_right_click = true,
      },
      mappings = {
        cycle_prev_next = true,
        disable_mouse = false,
      },
      history = {
        enabled = false,
      },
      rendering = {
        max_buffer_width = 999,
      },
      pick = {
        use_filename = true,
        letters = "asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERTYQP",
      },
      sidebar = {
        filetype = { "snacks_picker_list" },
        components = {},
      },
      default_hl = {
        fg = function(buffer) return buffer.is_focused and get_hex("Normal", "fg") or get_hex("Comment", "fg") end,
        bg = get_hex("ColorColumn", "bg"),
      },
      components = {
        {
          text = "｜",
          fg = function(buffer) return buffer.is_modified and yellow or green end,
        },
        {
          text = function(buffer) return buffer.devicon.icon .. " " end,
          fg = function(buffer) return buffer.devicon.color end,
        },
        {
          text = function(buffer) return buffer.is_modified and "● " or "" end,
          fg = yellow,
        },
        {
          text = function(buffer) return buffer.index .. ": " end,
        },
        {
          text = function(buffer) return buffer.unique_prefix end,
          fg = get_hex("Comment", "fg"),
          italic = true,
        },
        {
          text = function(buffer) return buffer.filename .. " " end,
          bold = function(buffer) return buffer.is_focused end,
        },
        {
          text = " ",
        },
      },
    }
  end,
}
