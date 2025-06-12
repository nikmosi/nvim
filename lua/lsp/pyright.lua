return {
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true, -- Automatically search for modules
        extraPaths = { "src" },
        diagnosticMode = "workspace", -- Set to workspace to analyze all files
        typeCheckingMode = "strict", -- Disable strict type checking (can be set to 'basic' or 'strict')
        useLibraryCodeForTypes = true, -- Use library code for type inference
        completeFunctionParens = true, -- Auto-complete function parentheses
      },
    },
  },
  before_init = function(params, config)
    vim.notify "wow"
    local py = require "config.lang.python_env"
    py.env(config.root_dir)
    config.settings = vim.tbl_deep_extend("force", config.settings or {}, {
      python = {
        pythonPath = vim.fn.exepath "python",
      },
    })
  end,
}
