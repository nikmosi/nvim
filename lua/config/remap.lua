vim.g.mapleader = " "

-- Move between buffers using keys
vim.keymap.set("n", "L", vim.cmd.bnext, { noremap = true, silent = true, desc = "Next buffer" })
vim.keymap.set("n", "H", vim.cmd.bprev, { noremap = true, silent = true, desc = "Previous buffer" })
vim.keymap.set("x", "<leader>p", "\"_dP", { noremap = true, silent = true, desc = "Delete to void" })
