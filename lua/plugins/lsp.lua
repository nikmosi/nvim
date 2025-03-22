return {
  {
    "lukas-reineke/lsp-format.nvim",
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    keys = {
      { "<leader>lsr", vim.cmd.LspRestart, mode = "n", noremap = true, silent = true },
    },
    opts = {
      servers = {
        docker_compose_language_service = require "config.lsp.docker_compose_language_service",
        dockerls = {},
        lua_ls = require "config.lsp.lua_ls",
        nginx_language_server = {},
        nil_ls = require "config.lsp.nil_ls",
        pylsp = {},
        pyright = require "config.lsp.pyright",
        ruff = {},
        yamlls = require "config.lsp.yamlls",
      },
    },
    config = function(_, opts)
      local lspconfig = require "lspconfig"
      -- Add cmp_nvim_lsp capabilities settings to lspconfig
      local lspconfig_defaults = lspconfig.util.default_config
      lspconfig_defaults.capabilities =
        vim.tbl_deep_extend("force", lspconfig_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

      for server, config in pairs(opts.servers) do
        lspconfig[server].setup(config)
      end

      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "Auto format",
        callback = function(event)
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client then
            require("lsp-format").on_attach(client, event.bufnr)
          else
            vim.notify("LSP client not found for buffer " .. event.bufnr, vim.log.levels.WARN)
          end
        end,
      })
      -- Autocommand for LSP actions
      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "LSP actions",
        callback = function(event)
          local opts = { buffer = event.buf }

          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          -- vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          -- vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
          -- vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)
          vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts)
          vim.keymap.set(
            "n",
            "<leader>ld",
            function() vim.diagnostic.open_float() end,
            { noremap = true, silent = true }
          )
          vim.keymap.set({ "n", "x" }, "<F3>", function() vim.lsp.buf.format { async = true } end, opts)
          vim.keymap.set("n", "<F4>", vim.lsp.buf.code_action, opts)
        end,
      })
      vim.api.nvim_create_autocmd("BufWritePost", {
        pattern = "*.lua",
        callback = function()
          local bufnr = vim.api.nvim_get_current_buf()
          local clients = vim.lsp.get_clients { bufnr = bufnr }
          local formatted = false

          for _, client in ipairs(clients) do
            if client.name == "lua_ls" then
              vim.system({ "stylua", "%", vim.api.nvim_buf_get_name(bufnr) }, nil, function()
                vim.schedule(function() vim.cmd "edit" end)
              end)
              formatted = true
            end
          end
          if not formatted then
            vim.buf.lsp.format { async = true }
          end
        end,
      })
    end,
  },
}
