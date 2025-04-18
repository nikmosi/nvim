vim.g.mapleader = " "

-- Move between buffers using keys
vim.keymap.set("n", "L", vim.cmd.bnext, { noremap = true, silent = true, desc = "Next buffer" })
vim.keymap.set("n", "H", vim.cmd.bprev, { noremap = true, silent = true, desc = "Previous buffer" })

vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<A-j>", "V:m '>+1<CR>gv=gv<Esc>", { silent = true, desc = "Move line down" })
vim.keymap.set("n", "<A-k>", "V:m '<-2<CR>gv=gv<Esc>", { silent = true, desc = "Move line up" })

vim.keymap.set("n", "q:", ":q<CR>", { noremap = true, silent = true })

-- clips
vim.keymap.set("n", "<leader>c", "\"+yy", { desc = "Copy operator to clipboard" })
vim.keymap.set("n", "<leader>v", "\"+p", { desc = "paste operator from clipboard" })
vim.keymap.set("v", "<leader>v", "\"+p", { desc = "paste operator from clipboard" })
vim.keymap.set("x", "<leader>p", "\"_dP", { desc = "Delete to void" })
vim.keymap.set("v", "<leader>c", "\"+y", { desc = "Copy visual selection to clipboard" })
