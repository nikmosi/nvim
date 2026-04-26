-- Блок регистрации сахарных команд
local function register_lsp_sugar()
  -- 1. LspInfo: Вывод активных клиентов для текущего буфера
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

  -- 2. LspStop: Остановка всех или конкретного клиента
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

  -- 3. LspStart: Ручной запуск сервера (используя твой список серверов)
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
    complete = function() return { "pyright", "ruff", "nixd", "lua_ls", "yamlls" } end, -- Список из твоего конфига
  })

  -- 4. LspLog: Быстрый доступ к логам (полезно для отладки твоих ошибок в /run/user/1000)
  vim.api.nvim_create_user_command("LspLog", function()
    local log_path = vim.lsp.get_log_path()
    vim.cmd("edit " .. log_path)
  end, { desc = "Open LSP log" })

  -- 5. LspRestart: Полный перезапуск (улучшенная версия)
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

return {
  "neovim/nvim-lspconfig",
  lazy = false,
  dependencies = { "saghen/blink.cmp" },
  keys = {
    { "<leader>lsr", vim.cmd.LspRestart, mode = "n", noremap = true, silent = true, desc = "LSP Restart" },
  },
  opts = {
    servers = {
      "docker_compose_language_service",
      "dockerls",
      "helm_ls",
      "lua_ls",
      "nginx_language_server",
      -- "nil_ls", -- Use nixd instead
      "nixd",
      "nushell",
      "terraformls",
      "ty",
      "pyright",
      "ruff",
      "yamlls",
    },
  },
  config = function(_, opts)
    local function tune_python_clients(bufnr)
      if vim.bo[bufnr].filetype ~= "python" then
        return
      end

      local clients = vim.lsp.get_clients { bufnr = bufnr }
      local has_pyright = vim.iter(clients):any(function(client) return client.name == "pyright" end)

      register_lsp_sugar()

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

    local default_config = {
      capabilities = capabilities,
      root_markers = { ".git" },
    }

    vim.lsp.config("*", default_config)

    for _, server in pairs(opts.servers) do
      vim.lsp.enable(server)
    end

    -- Autocommand for LSP actions
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
  end,
}
