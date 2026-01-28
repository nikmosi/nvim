return {
  "willothy/nvim-cokeline",
  event = "UIEnter",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "echasnovski/mini.icons",
  },
  keys = {
    { "L", "<Plug>(cokeline-focus-next)", mode = "n", remap = true, silent = true, desc = "Next buffer" },
    { "H", "<Plug>(cokeline-focus-prev)", mode = "n", remap = true, silent = true, desc = "Previous buffer" },
  },
  config = function()
    local get_hex = require("cokeline.hlgroups").get_hl_attr
    local green = vim.g.terminal_color_2
    local yellow = vim.g.terminal_color_3
    require("cokeline").setup {
      show_if_buffers_are_at_least = 2,
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
