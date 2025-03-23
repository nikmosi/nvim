vim.g.mapleader = " "

-- Move between buffers using keys
vim.keymap.set("n", "L", vim.cmd.bnext, { noremap = true, silent = true }) -- Next buffer
vim.keymap.set("n", "H", vim.cmd.bprev, { noremap = true, silent = true }) -- Previous buffer
vim.keymap.set("x", "<leader>p", "\"_dp", { noremap = true, silent = true, desc = "Delete to void" })
