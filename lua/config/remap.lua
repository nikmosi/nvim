vim.g.mapleader = " "
vim.keymap.set("n", "<leader>bc", function()
  local current_buf = vim.api.nvim_get_current_buf()
  local bufs = vim.api.nvim_list_bufs()

  for _, buf in ipairs(bufs) do
    if buf ~= current_buf then
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  end
end, { noremap = true, silent = true })
vim.keymap.set("i", "jk", "<Esc>")

-- Move between buffers using keys
vim.keymap.set("n", "L", vim.cmd.bnext, { noremap = true, silent = true })           -- Next buffer
vim.keymap.set("n", "H", vim.cmd.bprev, { noremap = true, silent = true })           -- Previous buffer
vim.keymap.set("n", "<leader>C", vim.cmd.bdelete, { noremap = true, silent = true }) -- Delete current buffer

-- lsp
vim.keymap.set("n", "<leader>lsr", vim.cmd.LspRestart, { noremap = true, silent = true })
