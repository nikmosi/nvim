local function load_server_configs()
  local lsp_dir = vim.fn.stdpath "config" .. "/after/lsp"
  local ok_dir, files = pcall(vim.fn.readdir, lsp_dir)
  if not ok_dir or not files then
    return
  end

  for _, file in ipairs(files) do
    if file:match "%.lua$" then
      local name = file:gsub("%.lua$", "")
      local ok_conf, config = pcall(dofile, lsp_dir .. "/" .. file)
      if ok_conf and type(config) == "table" then
        vim.lsp.config[name] = config
      end
    end
  end
end

local function register_lsp_sugar()
  vim.api.nvim_create_user_command("LspInfo", function()
    local buf = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_clients { bufnr = buf }
    if #clients == 0 then
      vim.notify("No active LSP clients for this buffer", vim.log.levels.WARN)
      return
    end

    local info = { "# Active Clients:" }
    for _, client in ipairs(clients) do
      table.insert(
        info,
        string.format("- %s (id: %d, root: %s)", client.name, client.id, client.config.root_dir or "none")
      )
    end
    vim.notify(table.concat(info, "\n"), vim.log.levels.INFO, { title = "LSP Status" })
  end, { desc = "Show active LSP clients" })

  vim.api.nvim_create_user_command("LspStop", function(opts)
    local clients = vim.lsp.get_clients { bufnr = 0 }
    for _, client in ipairs(clients) do
      if opts.args == "" or client.name == opts.args then
        client.stop()
        vim.notify("Stopped LSP: " .. client.name)
      end
    end
  end, {
    desc = "Stop LSP client(s)",
    nargs = "?",
    complete = function()
      return vim.iter(vim.lsp.get_clients { bufnr = 0 }):map(function(c) return c.name end):totable()
    end,
  })

  vim.api.nvim_create_user_command("LspStart", function(opts)
    if opts.args ~= "" then
      vim.lsp.enable(opts.args)
      vim.notify("Starting LSP: " .. opts.args)
    else
      vim.notify("Please specify a server name", vim.log.levels.ERROR)
    end
  end, {
    desc = "Start a specific LSP server",
    nargs = 1,
    complete = function() return { "pyright", "ruff", "nixd", "lua_ls", "yamlls", "xonsh_lsp" } end,
  })

  vim.api.nvim_create_user_command("LspLog", function()
    local log_path = vim.lsp.get_log_path()
    vim.cmd("edit " .. log_path)
  end, { desc = "Open LSP log" })

  vim.api.nvim_create_user_command("LspRestart", function()
    local buf = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_clients { bufnr = buf }
    for _, client in ipairs(clients) do
      local name = client.name
      client.stop()
      vim.defer_fn(function()
        vim.lsp.enable(name)
        vim.notify("Restarted: " .. name)
      end, 500)
    end
  end, { desc = "Restart LSP for current buffer" })
end

local function tune_python_clients(bufnr)
  if vim.bo[bufnr].filetype ~= "python" then
    return
  end

  local clients = vim.lsp.get_clients { bufnr = bufnr }
  local has_pyright = vim.iter(clients):any(function(client) return client.name == "pyright" end)

  for _, client in ipairs(clients) do
    if client.name == "ruff" then
      client.server_capabilities.hoverProvider = false
    end

    if has_pyright and client.name == "ty" then
      client.server_capabilities.renameProvider = false
      client.server_capabilities.referencesProvider = false
      client.server_capabilities.definitionProvider = false
      client.server_capabilities.declarationProvider = false
      client.server_capabilities.implementationProvider = false
      client.server_capabilities.typeDefinitionProvider = false
      client.server_capabilities.documentSymbolProvider = false
      client.server_capabilities.workspaceSymbolProvider = false
      client.server_capabilities.hoverProvider = false
    end
  end
end

load_server_configs()

local capabilities = vim.tbl_deep_extend(
  "force",
  vim.lsp.protocol.make_client_capabilities(),
  require("blink.cmp").get_lsp_capabilities({}, false)
)
---@diagnostic disable: missing-fields
capabilities.textDocument.semanticTokens = {
  multilineTokenSupport = true,
}
capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true
---@diagnostic enable: missing-fields

vim.lsp.config("*", {
  capabilities = capabilities,
  root_markers = { ".git" },
})

local servers = {
  "docker_compose_language_service",
  "dockerls",
  "helm_ls",
  "lua_ls",
  "nginx_language_server",
  "nixd",
  "nushell",
  "terraformls",
  "ty",
  "xonsh_lsp",
  "pyright",
  "ruff",
  "yamlls",
}

for _, server in ipairs(servers) do
  pcall(vim.lsp.enable, server)
end

register_lsp_sugar()

vim.keymap.set("n", "<leader>lsr", vim.cmd.LspRestart, { noremap = true, silent = true, desc = "LSP Restart" })

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP actions",
  callback = function(event)
    local local_opts = { buffer = event.buf }

    tune_python_clients(event.buf)

    vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", local_opts, { desc = "Hover" }))
    vim.keymap.set(
      "n",
      "gi",
      vim.lsp.buf.implementation,
      vim.tbl_extend("force", local_opts, { desc = "Go to Implementation" })
    )
    vim.keymap.set(
      "n",
      "go",
      vim.lsp.buf.type_definition,
      vim.tbl_extend("force", local_opts, { desc = "Go to Type Definition" })
    )
    vim.keymap.set(
      "n",
      "gs",
      vim.lsp.buf.signature_help,
      vim.tbl_extend("force", local_opts, { desc = "Signature Help" })
    )
    vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, vim.tbl_extend("force", local_opts, { desc = "Rename" }))
    vim.keymap.set(
      "n",
      "<leader>cd",
      function() vim.diagnostic.open_float() end,
      { noremap = true, silent = true, desc = "Line Diagnostics" }
    )
    vim.keymap.set(
      { "n", "x" },
      "<leader>cf",
      function() vim.lsp.buf.format { async = true } end,
      vim.tbl_extend("force", local_opts, { desc = "Format Buffer" })
    )
    vim.keymap.set(
      "n",
      "<leader>ca",
      vim.lsp.buf.code_action,
      vim.tbl_extend("force", local_opts, { desc = "Code Action" })
    )
  end,
})
