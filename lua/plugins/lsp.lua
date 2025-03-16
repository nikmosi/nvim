return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function()
      -- Add cmp_nvim_lsp capabilities settings to lspconfig
      local lspconfig_defaults = require "lspconfig".util.default_config
      lspconfig_defaults.capabilities = vim.tbl_deep_extend(
        "force",
        lspconfig_defaults.capabilities,
        require "cmp_nvim_lsp".default_capabilities()
      )
      require "lspconfig".lua_ls.setup {
        settings = {
          Lua = {
            format = {
              enable = true,                     -- Enable Lua formatting
              defaultConfig = {
                indent_style = "space",          -- Use spaces for indentation
                indent_size = "2",               -- Use 2 spaces for indentation
                quote_style = "double",          -- Prefer single quotes
                call_arg_parentheses = "remove", -- Remove parentheses in function calls
              },
            },
            diagnostics = {
              globals = { "vim" }, -- Treat 'vim' as a global (for Neovim API)
            },
            workspace = {
              checkThirdParty = false, -- Disable third-party library checks
            },
          },
        },
      }

      require "lspconfig".docker_compose_language_service.setup { filetypes = { "compose.yml" } }
      require "lspconfig".dockerls.setup {}
      require "lspconfig".nil_ls.setup {
        settings = {
          ["nil"] = {
            formatting = {
              command = { "nixfmt" },
            }
          }
        }
      }
      require "lspconfig".pyright.setup {
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,        -- Automatically search for modules
              diagnosticMode = "workspace",  -- Set to workspace to analyze all files
              typeCheckingMode = "off",      -- Disable strict type checking (can be set to 'basic' or 'strict')
              useLibraryCodeForTypes = true, -- Use library code for type inference
              completeFunctionParens = true, -- Auto-complete function parentheses
            },
          },
        },
        on_new_config = function(new_config, new_root_dir)
          local py = require "lang.python"
          py.env(new_root_dir)
          new_config.settings.python.pythonPath = vim.fn.exepath "python"
          -- new_config.cmd_env.PATH = py.env(new_root_dir) .. new_config.cmd_env.PATH
          vim.notify(vim.inspect(py.pep582(new_root_dir)))
        end,
      }
      require "lspconfig".pylsp.setup {}
      require "lspconfig".ruff.setup {}
      require "lspconfig".yamlls.setup {
        settings = {
          yaml = {
            schemas = {
              ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
              ["../path/relative/to/file.yml"] = "/.github/workflows/*",
              ["/path/from/root/of/project"] = "/.github/workflows/*",
            },
          },
        } }
      -- Autocommand for LSP actions
      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "LSP actions",
        callback = function(event)
          local opts = { buffer = event.buf }

          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)
          vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts)
          vim.keymap.set("n", "<leader>ld", function()
            vim.diagnostic.open_float()
          end, { noremap = true, silent = true })
          vim.keymap.set({ "n", "x" }, "<F3>", function() vim.lsp.buf.format { async = true } end, opts)
          vim.keymap.set("n", "<F4>", vim.lsp.buf.code_action, opts)

          -- 🟩 Format on Save Integration
          if vim.lsp.buf.format then
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = event.buf,
              callback = function()
                vim.lsp.buf.format { async = false }
              end,
            })
          end
        end,
      })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require "cmp"

      cmp.setup {
        sources = {
          { name = "nvim_lsp" },
        },
        snippet = {
          expand = function(args)
            -- You need Neovim v0.10 to use vim.snippet
            vim.snippet.expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert {},
      }
    end
  }, -- Ensure cmp is also loaded
}
