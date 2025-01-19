return {
  "AstroNvim/astrolsp",
  -- we must use the function override because table merging
  -- does not play nicely with list-like tables
  ---@param opts AstroLSPOpts
  opts = function(plugin, opts)
    -- safely extend the servers list
    opts.servers = opts.servers or {}
    vim.list_extend(opts.servers, {
      "ruff",
      "nil_ls",
      "docker_compose_language_service",
      "pylsp",
      "pyright",
      "lua_ls",
      "dockerls",
    })

    opts.config = opts.config or {}
    opts.config["nil_ls"] = {
      settings = {
        ["nil"] = {
          formatting = {
            command = { "nixfmt" },
          },
        },
      },
    }
  end,
}
