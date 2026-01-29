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
    local conditions = require "heirline.conditions"

    -------------------------------------------------------------------------
    -- TABLINE LOGIC (Manual Cache)
    -------------------------------------------------------------------------
    local buflist_cache = {}
    local get_bufs = function()
      return vim.tbl_filter(
        function(bufnr) return vim.api.nvim_get_option_value("buflisted", { buf = bufnr }) end,
        vim.api.nvim_list_bufs()
      )
    end

    local function update_buflist()
      vim.schedule(function()
        local buffers = get_bufs()
        for i, v in ipairs(buffers) do
          buflist_cache[i] = v
        end
        for i = #buffers + 1, #buflist_cache do
          buflist_cache[i] = nil
        end
        vim.cmd.redrawtabline()
      end)
    end

    update_buflist()
    vim.api.nvim_create_autocmd({ "VimEnter", "UIEnter", "BufAdd", "BufDelete" }, {
      callback = update_buflist,
    })

    local TablineBufnode = {
      init = function(self)
        self.filename = vim.api.nvim_buf_get_name(self.bufnr)
        self.is_modified = vim.api.nvim_get_option_value("modified", { buf = self.bufnr })
        self.is_active = vim.api.nvim_get_current_buf() == self.bufnr
      end,
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
        { provider = function(self) return self.is_modified and "● " or "" end, hl = { fg = "yellow" } },
        { provider = function(self) return self.bufnr .. ": " end },
        {
          provider = function(self)
            return self.filename == "" and "[No Name]" or vim.fn.fnamemodify(self.filename, ":t") .. " "
          end,
          hl = function(self)
            return {
              bold = self.is_active,
              fg = self.is_active and utils.get_highlight("Normal").fg or utils.get_highlight("Comment").fg,
            }
          end,
        },
      },
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
          end,
          minwid = function(self) return self.bufnr end,
          name = "heirline_tabline_close_buffer_callback",
        },
      },
      { provider = " " },
    }

    local BufferLine = utils.make_buflist(
      TablineBufnode,
      { provider = "", hl = { fg = "gray" } },
      { provider = "", hl = { fg = "gray" } },
      function() return buflist_cache end,
      false
    )

    -------------------------------------------------------------------------
    -- NEW COMPONENTS
    -------------------------------------------------------------------------

    -- 1. Macro Recording Indicator
    local MacroRec = {
      condition = function() return vim.fn.reg_recording() ~= "" and vim.o.cmdheight == 0 end,
      provider = " ",
      hl = { fg = "orange", bold = true },
      utils.surround({ "[", "]" }, nil, {
        provider = function() return vim.fn.reg_recording() end,
        hl = { fg = "green", bold = true },
      }),
      update = { "RecordingEnter", "RecordingLeave" },
    }

    -- 2. Search Count
    local SearchCount = {
      condition = function() return vim.v.hlsearch ~= 0 and vim.o.cmdheight == 0 end,
      init = function(self)
        local ok, search = pcall(vim.fn.searchcount)
        if ok and search.total then
          self.search = search
        end
      end,
      provider = function(self)
        local search = self.search
        return string.format("[%d/%d]", search.current, math.min(search.total, search.maxcount))
      end,
    }

    -- 3. Spell
    local Spell = {
      condition = function() return vim.wo.spell end,
      provider = "SPELL ",
      hl = { bold = true, fg = "orange" },
    }

    -- 4. ShowCmd
    local ShowCmd = {
      condition = function() return vim.o.cmdheight == 0 end,
      provider = ":%3.5(%S%)",
    }

    -- 5. DAP (Debug) Status
    local DapStatus = {
      condition = function() return package.loaded["dap"] and require("dap").session() end,
      provider = function() return "  " .. require("dap").status() end,
      hl = { fg = "red", bold = true },
    }

    -------------------------------------------------------------------------
    -- WINBAR (Breadcrumbs)
    -------------------------------------------------------------------------
    local WinBar = {
      lib.component.breadcrumbs(),
      lib.component.fill(),
    }

    -------------------------------------------------------------------------
    -- FINAL CONFIG
    -------------------------------------------------------------------------
    return {
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
              "toggleterm",
            },
          }, buf)
        end,
      },
      tabline = {
        BufferLine,
        lib.component.fill { hl = { bg = "tabline_bg" } },
        lib.component.tabline_tabpages(),
      },
      -- winbar = WinBar, -- Activated!
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
        MacroRec,
        ShowCmd,
        SearchCount,
        Spell,
        DapStatus,
        lib.component.fill(),
        lib.component.lsp(),
        lib.component.virtual_env(),
        lib.component.nav(),
        lib.component.mode { surround = { separator = "right" } },
      },
    }
  end,
  config = function(_, opts)
    vim.opt.showcmdloc = "statusline"
    local heirline = require "heirline"
    local hc = require "heirline-components.all"
    hc.init.subscribe_to_events()
    heirline.load_colors(hc.hl.get_colors())
    heirline.setup(opts)
  end,
}
