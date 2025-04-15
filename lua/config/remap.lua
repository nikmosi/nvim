vim.g.mapleader = " "

-- Move between buffers using keys
vim.keymap.set("n", "L", vim.cmd.bnext, { noremap = true, silent = true, desc = "Next buffer" })
vim.keymap.set("n", "H", vim.cmd.bprev, { noremap = true, silent = true, desc = "Previous buffer" })

vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<A-j>", "V:m '>+1<CR>gv=gv<Esc>")
vim.keymap.set("n", "<A-k>", "V:m '<-2<CR>gv=gv<Esc>")

vim.keymap.set("n", "q:", ":q<CR>", { noremap = true, silent = true })
