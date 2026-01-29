return {
  "rebelot/heirline.nvim",
  dependencies = { "Zeioth/heirline-components.nvim" },
  event = "UIEnter",
  keys = {
    { "L", "<cmd>bnext<cr>", desc = "Next buffer" },
    { "H", "<cmd>bprev<cr>", desc = "Previous buffer" },
  },
  opts = function()
    local lib = require "heirline-components.all"
    local has_statuscol = vim.fn.has "nvim-0.10" == 1
    local utils = require "heirline.utils"

    local TablineBufnode = {
      init = function(self)
        self.filename = vim.api.nvim_buf_get_name(self.bufnr)
        self.is_modified = vim.api.nvim_get_option_value("modified", { buf = self.bufnr })
        self.is_active = vim.api.nvim_get_current_buf() == self.bufnr
      end,
      -- Buffer info part (Switch on left click, Close on right click)
      {
        on_click = {
          callback = function(_, minwid, _, button)
            if button == "l" then
              vim.api.nvim_win_set_buf(0, minwid)
            elseif button == "r" then
              if _G.Snacks then
                _G.Snacks.bufdelete(minwid)
              else
                vim.api.nvim_buf_delete(minwid, { force = false })
              end
              vim.cmd.redrawtabline()
            end
          end,
          minwid = function(self) return self.bufnr end,
          name = "heirline_tabline_buffer_callback",
        },
        {
          provider = "｜",
          hl = function(self) return { fg = self.is_modified and "yellow" or "green" } end,
        },
        {
          init = function(self)
            local extension = vim.fn.fnamemodify(self.filename, ":e")
            self.icon, self.icon_color =
              require("nvim-web-devicons").get_icon_color(self.filename, extension, { default = true })
          end,
          provider = function(self) return self.icon and (self.icon .. " ") end,
          hl = function(self) return { fg = self.icon_color } end,
        },
        {
          provider = function(self) return self.is_modified and "● " or "" end,
          hl = { fg = "yellow" },
        },
        {
          provider = function(self) return self.bufnr .. ": " end,
        },
        {
          provider = function(self)
            return self.filename == "" and "[No Name]" or vim.fn.fnamemodify(self.filename, ":t") .. " "
          end,
          hl = function(self)
            if self.is_active then
              return { bold = true, fg = utils.get_highlight("Normal").fg }
            else
              return { fg = utils.get_highlight("Comment").fg }
            end
          end,
        },
      },
      -- Close button part (Close on left click)
      {
        provider = "󰅖 ",
        hl = { fg = "gray" },
        on_click = {
          callback = function(_, minwid)
            if _G.Snacks then
              _G.Snacks.bufdelete(minwid)
            else
              vim.api.nvim_buf_delete(minwid, { force = false })
            end
            vim.cmd.redrawtabline()
          end,
          minwid = function(self) return self.bufnr end,
          name = "heirline_tabline_close_buffer_callback",
        },
      },
      { provider = " " },
    }

    local BufferLine = utils.make_buflist(
      TablineBufnode,
      { provider = "", hl = { fg = "gray" } }, -- left truncation
      { provider = "", hl = { fg = "gray" } } -- right truncation
    )

    return {
      -- note: this only matters if you define a winbar
      opts = {
        disable_winbar_cb = function(args)
          local buf = args.buf
          return lib.condition.buffer_matches({
            buftype = { "terminal", "prompt", "nofile", "help", "quickfix" },
            filetype = {
              "NvimTree",
              "neo%-tree",
              "dashboard",
              "Outline",
              "aerial",
              "snacks_picker_list",
              "snacks_explorer",
            },
          }, buf)
        end,
      },

      tabline = {
        BufferLine,
        lib.component.fill { hl = { bg = "tabline_bg" } },
        lib.component.tabline_tabpages(),
      },

      statuscolumn = has_statuscol and {
        init = function(self) self.bufnr = vim.api.nvim_get_current_buf() end,
        lib.component.foldcolumn(),
        lib.component.numbercolumn(),
        lib.component.signcolumn(),
      } or nil,

      statusline = {
        hl = { fg = "fg", bg = "bg" },
        lib.component.mode(),
        lib.component.git_branch(),
        lib.component.file_info { filetype = false, filename = {}, file_modified = false },
        lib.component.git_diff(),
        lib.component.diagnostics(),
        lib.component.fill(),
        lib.component.cmd_info(),
        lib.component.fill(),
        lib.component.lsp(),
        -- lib.component.compiler_state(), -- needs compiler.nvim/overseer :contentReference[oaicite:4]{index=4}
        lib.component.virtual_env(), -- needs venv-selector.nvim :contentReference[oaicite:5]{index=5}
        lib.component.nav(),
        lib.component.mode { surround = { separator = "right" } },
      },
    }
  end,
  config = function(_, opts)
    local heirline = require "heirline"
    local hc = require "heirline-components.all"

    hc.init.subscribe_to_events()
    heirline.load_colors(hc.hl.get_colors())
    heirline.setup(opts)
  end,
}
