local M = {}

local path = require "lspconfig.util".path

local function get_python_dir(workspace)
  -- Find and use virtualenv in workspace directory.
  for _, pattern in ipairs { "*", ".*" } do
    local match = vim.fn.glob(path.join(workspace, pattern, "pyvenv.cfg"))
    if match ~= "" then
      return path.dirname(match)
    end
  end

  return ""
end

local _virtual_env = ""
local _package = ""

local function py_bin_dir()
  return path.join(_virtual_env, "bin:")
end

M.env = function(root_dir)
  if not vim.env.VIRTUAL_ENV or vim.env.VIRTUAL_ENV == "" then
    _virtual_env = get_python_dir(root_dir)
    vim.notify("python_dir: " .. _virtual_env)
  end

  if _virtual_env ~= "" then
    vim.env.VIRTUAL_ENV = _virtual_env
    vim.env.PATH = py_bin_dir() .. vim.env.PATH
  end

  if _virtual_env ~= "" and vim.env.PYTHONHOME then
    vim.env.old_PYTHONHOME = vim.env.PYTHONHOME
    vim.env.PYTHONHOME = ""
  end

  return _virtual_env ~= "" and py_bin_dir() or ""
end

return M
