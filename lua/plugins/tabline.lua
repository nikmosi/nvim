return {
  "willothy/nvim-cokeline",
  lazy = false,
  dependencies = { "nvim-lua/plenary.nvim", "echasnovski/mini.icons" },
  config = function()
    require("mini.icons").setup()
    MiniIcons.mock_nvim_web_devicons()

    local get_hex = require("cokeline.hlgroups").get_hl_attr
    local function fg(group) return get_hex(group, "fg") end
    local function bg(group) return get_hex(group, "bg") end

    local green = vim.g.terminal_color_2 or fg "DiffAdd" or "#00ff87"
    local yellow = vim.g.terminal_color_3 or fg "DiagnosticWarn" or "#ffd866"

    vim.keymap.set("n", "L", "<Plug>(cokeline-focus-next)", { silent = true, desc = "Next buffer" })
    vim.keymap.set("n", "H", "<Plug>(cokeline-focus-prev)", { silent = true, desc = "Previous buffer" })
    -- vim.keymap.set("n", "gb", "<Plug>(cokeline-pick-focus)", { silent = true, desc = "Pick buffer" })
    -- vim.keymap.set("n", "gB", "<Plug>(cokeline-pick-close)", { silent = true, desc = "Pick close" })

    require("cokeline").setup {
      show_if_buffers_are_at_least = 1,

      buffers = {
        -- do not filter anything
        filter_valid = function(_) return true end,
        filter_visible = function(_) return true end,
        focus_on_delete = "prev",
        new_buffers_position = "last",
        delete_on_right_click = true,
      },

      mappings = {
        cycle_prev_next = true,
        disable_mouse = false,
      },

      history = { enabled = false },

      rendering = {
        max_buffer_width = 80, -- prevents single names from starving others
      },

      pick = {
        use_filename = true,
        letters = "asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERTYQP",
      },

      sidebar = {
        filetype = { "snacks_picker_list" }, -- add others if you use them, e.g. "neo-tree"
        components = {},
      },

      default_hl = {
        fg = function(buf) return buf.is_focused and fg "Normal" or fg "Comment" end,
        bg = bg "TabLineFill" or bg "StatusLine" or bg "Normal",
      },

      components = {
        { text = "｜", fg = function(buf) return buf.is_modified and yellow or green end },
        {
          text = function(buf) return (buf.devicon.icon or "") .. " " end,
          fg = function(buf) return buf.devicon.color end,
        },
        { text = function(buf) return buf.is_modified and "● " or "" end, fg = yellow },
        -- use buffer.number if you want bufnr; keep index if you prefer tabline position
        { text = function(buf) return buf.index .. ": " end },
        { text = function(buf) return buf.unique_prefix end, fg = fg "Comment", italic = true },
        { text = function(buf) return buf.filename end, bold = function(buf) return buf.is_focused end },
        { text = " " },
      },
    }
  end,
}
