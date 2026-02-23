return {
  settings = {
    python = {
      analysis = {
        autoImportCompletions = true,
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
    local py = require "config.lang.python_env"
    local bin = py.env(config.root_dir)
    -- config.settings.python.pythonPath = bin
    local tabl = vim.tbl_deep_extend(
      "force",
      config.settings.python,
      { pythonPath = bin, analysis = { diagnosticMode = "workspace" } }
    )
    config.settings.python = tabl
  end,
}
