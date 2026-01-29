return {
  "rebelot/heirline.nvim",
  dependencies = { "Zeioth/heirline-components.nvim" },
  event = "UIEnter",
  keys = {
    { "L", "<cmd>bnext<cr>", desc = "Next buffer" },
    { "H", "<cmd>bprev<cr>", desc = "Previous buffer" },
  },
  opts = function()
    local conditions = require "heirline.conditions"
    local utils = require "heirline.utils"
    local lib = require "heirline-components.all"
    local has_statuscol = vim.fn.has "nvim-0.10" == 1

    -------------------------------------------------------------------------
    -- COLORS
    -------------------------------------------------------------------------
    local function setup_colors()
      local function get_hl_fg(name)
        local hl = utils.get_highlight(name)
        return hl and hl.fg
      end

      return {
        bright_bg = utils.get_highlight("Folded").bg,
        bright_fg = utils.get_highlight("Folded").fg,
        red = utils.get_highlight("DiagnosticError").fg,
        dark_red = utils.get_highlight("DiffDelete").bg,
        green = utils.get_highlight("String").fg,
        blue = utils.get_highlight("Function").fg,
        gray = utils.get_highlight("NonText").fg,
        orange = utils.get_highlight("Constant").fg,
        purple = utils.get_highlight("Statement").fg,
        cyan = utils.get_highlight("Special").fg,
        diag_warn = utils.get_highlight("DiagnosticWarn").fg,
        diag_error = utils.get_highlight("DiagnosticError").fg,
        diag_hint = utils.get_highlight("DiagnosticHint").fg,
        diag_info = utils.get_highlight("DiagnosticInfo").fg,
        git_del = get_hl_fg "diffDeleted" or get_hl_fg "DiffDelete" or get_hl_fg "GitSignsDelete",
        git_add = get_hl_fg "diffAdded" or get_hl_fg "DiffAdd" or get_hl_fg "GitSignsAdd",
        git_change = get_hl_fg "diffChanged" or get_hl_fg "DiffChange" or get_hl_fg "GitSignsChange",
      }
    end

    -------------------------------------------------------------------------
    -- COMPONENTS
    -------------------------------------------------------------------------

    -- ViMode
    local ViMode = {
      init = function(self) self.mode = vim.fn.mode(1) end,
      static = {
        mode_names = {
          n = "NORMAL",
          no = "N?",
          nov = "N?",
          noV = "N?",
          ["no\22"] = "N?",
          niI = "Ni",
          niR = "Nr",
          niV = "Nv",
          nt = "Nt",
          v = "VISUAL",
          vs = "Vs",
          V = "V-LINE",
          Vs = "Vs",
          ["\22"] = "V-BLOCK",
          ["\22s"] = "^V",
          s = "S",
          S = "S_",
          ["\19"] = "^S",
          i = "INSERT",
          ic = "Ic",
          ix = "Ix",
          R = "REPLACE",
          Rc = "Rc",
          Rx = "Rx",
          Rv = "Rv",
          Rvc = "Rv",
          Rvx = "Rv",
          c = "COMMAND",
          cv = "Ex",
          r = "...",
          rm = "M",
          ["r?"] = "?",
          ["!"] = "!",
          t = "TERM",
        },
        mode_colors = {
          n = "blue",
          i = "green",
          v = "cyan",
          V = "cyan",
          ["\22"] = "cyan",
          c = "orange",
          s = "purple",
          S = "purple",
          ["\19"] = "purple",
          R = "orange",
          r = "orange",
          ["!"] = "red",
          t = "red",
        },
      },
      provider = function(self) return "  %2(" .. self.mode_names[self.mode] .. "%) " end,
      hl = function(self)
        local mode = self.mode:sub(1, 1)
        return { fg = "black", bg = self.mode_colors[mode], bold = true }
      end,
      update = {
        "ModeChanged",
        pattern = "*:*",
        callback = vim.schedule_wrap(function() vim.cmd "redrawstatus" end),
      },
    }

    -- FileNameBlock
    local FileNameBlock = {
      init = function(self) self.filename = vim.api.nvim_buf_get_name(0) end,
    }

    local FileIcon = {
      init = function(self)
        local filename = self.filename
        local extension = vim.fn.fnamemodify(filename, ":e")
        self.icon, self.icon_color =
          require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
      end,
      provider = function(self) return self.icon and (self.icon .. " ") end,
      hl = function(self) return { fg = self.icon_color } end,
    }

    local FileName = {
      provider = function(self)
        local filename = vim.fn.fnamemodify(self.filename, ":.")
        if filename == "" then
          return "[No Name]"
        end
        if not conditions.width_percent_below(#filename, 0.25) then
          filename = vim.fn.pathshorten(filename)
        end
        return filename
      end,
      hl = { fg = utils.get_highlight("Directory").fg },
    }

    local FileFlags = {
      {
        condition = function() return vim.bo.modified end,
        provider = "[+]",
        hl = { fg = "green" },
      },
      {
        condition = function() return not vim.bo.modifiable or vim.bo.readonly end,
        provider = "",
        hl = { fg = "orange" },
      },
    }

    local FileNameModifer = {
      hl = function()
        if vim.bo.modified then
          return { fg = "cyan", bold = true, force = true }
        end
      end,
    }

    FileNameBlock =
      utils.insert(FileNameBlock, FileIcon, utils.insert(FileNameModifer, FileName), FileFlags, { provider = "%<" })

    -- Git
    local Git = {
      condition = conditions.is_git_repo,
      init = function(self)
        self.status_dict = vim.b.gitsigns_status_dict
        self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
      end,
      hl = { fg = "orange" },
      {
        provider = function(self) return " " .. self.status_dict.head end,
        hl = { bold = true },
      },
      {
        condition = function(self) return self.has_changes end,
        provider = "(",
      },
      {
        provider = function(self)
          local count = self.status_dict.added or 0
          return count > 0 and ("+" .. count)
        end,
        hl = { fg = "git_add" },
      },
      {
        provider = function(self)
          local count = self.status_dict.removed or 0
          return count > 0 and ("-" .. count)
        end,
        hl = { fg = "git_del" },
      },
      {
        provider = function(self)
          local count = self.status_dict.changed or 0
          return count > 0 and ("~" .. count)
        end,
        hl = { fg = "git_change" },
      },
      {
        condition = function(self) return self.has_changes end,
        provider = ")",
      },
    }

    -- Diagnostics
    local Diagnostics = {
      condition = conditions.has_diagnostics,
      static = {
        error_icon = "E",
        warn_icon = "W",
        info_icon = "I",
        hint_icon = "H",
      },
      init = function(self)
        if vim.diagnostic.config().signs and vim.diagnostic.config().signs.text then
          self.error_icon = vim.diagnostic.config().signs.text[vim.diagnostic.severity.ERROR] or "E"
          self.warn_icon = vim.diagnostic.config().signs.text[vim.diagnostic.severity.WARN] or "W"
          self.info_icon = vim.diagnostic.config().signs.text[vim.diagnostic.severity.INFO] or "I"
          self.hint_icon = vim.diagnostic.config().signs.text[vim.diagnostic.severity.HINT] or "H"
        end
        self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
        self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
        self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
        self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
      end,
      update = { "DiagnosticChanged", "BufEnter" },
      {
        provider = "![",
      },
      {
        provider = function(self) return self.errors > 0 and (self.error_icon .. self.errors .. " ") end,
        hl = { fg = "diag_error" },
      },
      {
        provider = function(self) return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ") end,
        hl = { fg = "diag_warn" },
      },
      {
        provider = function(self) return self.info > 0 and (self.info_icon .. self.info .. " ") end,
        hl = { fg = "diag_info" },
      },
      {
        provider = function(self) return self.hints > 0 and (self.hint_icon .. self.hints) end,
        hl = { fg = "diag_hint" },
      },
      {
        provider = "]",
      },
    }

    -- LSP Active
    local LSPActive = {
      condition = conditions.lsp_attached,
      update = { "LspAttach", "LspDetach" },
      provider = function()
        local names = {}
        for _, server in pairs(vim.lsp.get_clients { bufnr = 0 }) do
          table.insert(names, server.name)
        end
        return " [" .. table.concat(names, " ") .. "]"
      end,
      hl = { fg = "green", bold = true },
    }

    -- DAP Messages
    local DAPMessages = {
      condition = function() return package.loaded["dap"] and require("dap").session() ~= nil end,
      provider = function() return "  " .. require("dap").status() end,
      hl = { fg = "red" },
    }

    -- MacroRec
    local MacroRec = {
      condition = function() return vim.fn.reg_recording() ~= "" and vim.o.cmdheight == 0 end,
      provider = " ",
      hl = { fg = "orange", bold = true },
      utils.surround({ "[", "]" }, nil, {
        provider = function() return vim.fn.reg_recording() end,
        hl = { fg = "green", bold = true },
      }),
      update = {
        "RecordingEnter",
        "RecordingLeave",
      },
    }

    -- SearchCount
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

    -- Spell
    local Spell = {
      condition = function() return vim.wo.spell end,
      provider = " SPELL ",
      hl = { bold = true, fg = "orange" },
    }

    local Align = { provider = "%=" }
    local Space = { provider = " " }

    local Ruler = { provider = "%7(%l/%3L%):%2c %P" }
    local ScrollBar = {
      static = { sbar = { " ", "▂", "▃", "▄", "▅", "▆", "▇", "█" } },
      provider = function(self)
        local curr_line = vim.api.nvim_win_get_cursor(0)[1]
        local lines = vim.api.nvim_buf_line_count(0)
        local i = math.floor((curr_line - 1) / lines * #self.sbar) + 1
        return string.rep(self.sbar[i], 2)
      end,
      hl = { fg = "blue", bg = "bright_bg" },
    }

    -------------------------------------------------------------------------
    -- TABLINE
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

    local TabPages = {
      condition = function() return #vim.api.nvim_list_tabpages() >= 2 end,
      { provider = "%=" },
      utils.make_tablist {
        provider = function(self) return "%" .. self.tabnr .. "T " .. self.tabpage .. " %T" end,
        hl = function(self) return { bold = self.is_active, fg = self.is_active and "green" or "gray" } end,
      },
    }

    -------------------------------------------------------------------------
    -- CONFIGURATION
    -------------------------------------------------------------------------
    local DefaultStatusline = {
      ViMode,
      Space,
      FileNameBlock,
      Space,
      Git,
      Space,
      Diagnostics,
      Align,
      DAPMessages,
      Space,
      MacroRec,
      Space,
      SearchCount,
      Space,
      Spell,
      Space,
      LSPActive,
      Space,
      Ruler,
      Space,
      ScrollBar,
    }

    -- local WinBar = {
    --   FileNameBlock,
    --   Align,
    -- }

    return {
      opts = {
        colors = setup_colors,
        disable_winbar_cb = function(args)
          return conditions.buffer_matches({
            buftype = { "terminal", "prompt", "nofile", "help", "quickfix" },
            filetype = { "NvimTree", "neo-tree", "dashboard", "Outline", "aerial" },
          }, args.buf)
        end,
      },
      statusline = DefaultStatusline,
      -- winbar = WinBar,
      tabline = { BufferLine, TabPages },
      statuscolumn = has_statuscol and {
        init = function(self) self.bufnr = vim.api.nvim_get_current_buf() end,
        lib.component.foldcolumn(),
        lib.component.numbercolumn(),
        lib.component.signcolumn(),
      } or nil,
    }
  end,
  config = function(_, opts)
    local heirline = require "heirline"
    local utils = require "heirline.utils"
    local hc = require "heirline-components.all"

    hc.init.subscribe_to_events()
    heirline.setup(opts)

    vim.api.nvim_create_augroup("Heirline", { clear = true })
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = function() utils.on_colorscheme(opts.opts.colors) end,
      group = "Heirline",
    })
  end,
}
