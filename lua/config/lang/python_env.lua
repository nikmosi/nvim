local M = {}

local path = require("lspconfig.util").path

local function get_python_dir(root_dir)
  -- Ищем .venv в корне проекта
  local venv_path = vim.fs.joinpath(root_dir, ".venv")
  local stat = vim.uv.fs_stat(venv_path)
  if stat and stat.type == "directory" then
    return venv_path
  end

  -- Если .venv не найден в корне, ищем в поддиректориях
  for _, dir in ipairs(vim.fn.readdir(root_dir)) do
    local subdir = vim.fs.joinpath(root_dir, dir)
    local subdir_stat = vim.uv.fs_stat(subdir)
    if subdir_stat and subdir_stat.type == "directory" then
      local sub_venv = vim.fs.joinpath(subdir, ".venv")
      local sub_venv_stat = vim.uv.fs_stat(sub_venv)
      if sub_venv_stat and sub_venv_stat.type == "directory" then
        return sub_venv
      end
    end
  end

  return nil
end

local function py_bin_dir(env) return path.join(env, "bin:") end

M.env = function(root_dir)
  if vim.env.VIRTUAL_ENV and vim.env.VIRTUAL_ENV ~= "" then
    return
  end

  local _virtual_env = get_python_dir(root_dir)
  if not _virtual_env then
    return
  end

  vim.notify("using venv: " .. _virtual_env)

  vim.env.VIRTUAL_ENV = _virtual_env
  vim.env.PATH = py_bin_dir(_virtual_env) .. vim.env.PATH

  if vim.env.PYTHONHOME then
    vim.env.old_PYTHONHOME = vim.env.PYTHONHOME
    vim.env.PYTHONHOME = ""
  end
end

return M
