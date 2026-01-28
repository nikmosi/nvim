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
      "lua_ls",
      "nginx_language_server",
      -- "nil_ls", -- Use nixd instead
      "nixd",
      "nushell",
      "ty",
      "pyright",
      "ruff",
      "yamlls",
    },
  },
  config = function(_, opts)
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
      local ok, conf = pcall(require, "lsp." .. server)
      local server_config = vim.tbl_deep_extend("force", {}, default_config, ok and conf or {})

      vim.lsp.config(server, server_config)
      vim.lsp.enable(server)
    end

    -- Autocommand for LSP actions
    vim.api.nvim_create_autocmd("LspAttach", {
      desc = "LSP actions",
      callback = function(event)
        local local_opts = { buffer = event.buf }

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
