return {
  "neovim/nvim-lspconfig",
  lazy = false,
  dependencies = { "saghen/blink.cmp" },
  keys = {
    { "<leader>lsr", vim.cmd.LspRestart, mode = "n", noremap = true, silent = true, desc = "Restart lsp" },
  },
  opts = {
    servers = {
      "docker_compose_language_service",
      "dockerls",
      "lua_ls",
      "nginx_language_server",
      "nil_ls",
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
    ---@diagnostic enable: missing-fields

    vim.lsp.config("*", {
      capabilities = capabilities,
      root_markers = { ".git" },
    })

    for _, server in pairs(opts.servers) do
      vim.lsp.enable(server)
    end

    -- Autocommand for LSP actions
    vim.api.nvim_create_autocmd("LspAttach", {
      desc = "LSP actions",
      callback = function(event)
        local local_opts = { buffer = event.buf }

        vim.keymap.set("n", "K", vim.lsp.buf.hover, local_opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, local_opts)
        vim.keymap.set("n", "go", vim.lsp.buf.type_definition, local_opts)
        vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, local_opts)
        vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, local_opts)
        vim.keymap.set("n", "<leader>ld", function() vim.diagnostic.open_float() end, { noremap = true, silent = true })
        vim.keymap.set({ "n", "x" }, "<F3>", function() vim.lsp.buf.format { async = true } end, local_opts)
        vim.keymap.set("n", "<F4>", vim.lsp.buf.code_action, local_opts)
      end,
    })
  end,
}
