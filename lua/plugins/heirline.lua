return {
  "rebelot/heirline.nvim",
  dependencies = { "Zeioth/heirline-components.nvim" },
  event = "UIEnter", -- OK to lazy-load here. :contentReference[oaicite:3]{index=3}
  opts = function()
    local lib = require "heirline-components.all"
    local has_statuscol = vim.fn.has "nvim-0.10" == 1

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
        lib.component.tabline_conditional_padding(),
        lib.component.tabline_buffers(),
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

    -- show tabline only when >1 listed buffer
    -- vim.api.nvim_create_autocmd("User", {
    --   pattern = "HeirlineComponentsTablineBuffersUpdated",
    --   callback = function() vim.o.showtabline = (#vim.t.bufs > 1) and 2 or 1 end,
    -- }) -- event documented in plugin README. :contentReference[oaicite:6]{index=6}
  end,
}
