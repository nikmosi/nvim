return {
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true, -- Automatically search for modules
        diagnosticMode = "workspace", -- Set to workspace to analyze all files
        typeCheckingMode = "strict", -- Disable strict type checking (can be set to 'basic' or 'strict')
        useLibraryCodeForTypes = true, -- Use library code for type inference
        completeFunctionParens = true, -- Auto-complete function parentheses
      },
    },
  },
  on_new_config = function(new_config, new_root_dir)
    local py = require "lang.python"
    py.env(new_root_dir)
    new_config.settings.python.pythonPath = vim.fn.exepath "python"
  end,
}
