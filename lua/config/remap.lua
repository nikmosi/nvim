vim.g.mapleader = " "

-- Move between buffers using keys
vim.keymap.set("n", "L", vim.cmd.bnext, { noremap = true, silent = true }) -- Next buffer
vim.keymap.set("n", "H", vim.cmd.bprev, { noremap = true, silent = true }) -- Previous buffer
