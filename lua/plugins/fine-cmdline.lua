return {
  "VonHeikemen/fine-cmdline.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  cmd = "FineCmdline",
  keys = {
    { ":", "<cmd>FineCmdline<cr>", desc = "Cmdline" },
  },
  opts = {
    cmdline = {
      enable_keymaps = true,
      smart_history = true,
      prompt = " ",
    },
    popup = {
      position = {
        row = "20%",
        col = "50%",
      },
      size = {
        width = "60%",
      },
      border = {
        style = "rounded",
        text = {
          top = " Command ",
          top_align = "center",
        },
      },
      win_options = {
        winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder",
      },
    },
    hooks = {
      before_mount = function(input)
        -- code
      end,
      after_mount = function(input)
        -- code
      end,
      set_keymaps = function(imap, feedkeys)
        -- code
      end,
    },
  },
}
