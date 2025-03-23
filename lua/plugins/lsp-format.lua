return {
  "lukas-reineke/lsp-format.nvim",
  event = "VimEnter",
  config = function()
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

    vim.api.nvim_create_autocmd("BufWritePost", {
      pattern = "*.lua",
      callback = function()
        local bufnr = vim.api.nvim_get_current_buf()
        local clients = vim.lsp.get_clients { bufnr = bufnr }
        local formatted = false

        for _, client in ipairs(clients) do
          if client.name == "lua_ls" then
            vim.system({ "stylua", "%", vim.api.nvim_buf_get_name(bufnr) }, nil, function()
              vim.schedule(function()
                pcall(function() vim.cmd "edit" end)
              end)
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
}
