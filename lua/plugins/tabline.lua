return {
  "willothy/nvim-cokeline",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "echasnovski/mini.icons",
  },
  config = function()
    require("mini.icons").setup()
    MiniIcons.mock_nvim_web_devicons()

    require("cokeline").setup {
      show_if_buffers_are_at_least = 1,

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
    }
  end,
}
