vim.g.mapleader = " "

-- Move between buffers using keys
vim.keymap.set("n", "L", vim.cmd.bnext, { noremap = true, silent = true, desc = "Next buffer" })
vim.keymap.set("n", "H", vim.cmd.bprev, { noremap = true, silent = true, desc = "Previous buffer" })
vim.keymap.set("x", "<leader>p", "\"_dP", { noremap = true, silent = true, desc = "Delete to void" })
vim.keymap.set("n", "<leader>v", "\"+p", { noremap = true, silent = true, desc = "Paste from system clip" })
vim.keymap.set({ "n", "v" }, "<C-V>", "\"+p", { noremap = true, silent = true, desc = "Paste from system clip" })
vim.keymap.set("i", "<C-V>", "<esc>\"+pa", { noremap = true, silent = true, desc = "Paste from system clip" })
vim.keymap.set("n", "<leader>V", "\"+p", { noremap = true, silent = true, desc = "Paste from system clip" })

vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<A-j>", "V:m '>+1<CR>gv=gv<Esc>")
vim.keymap.set("n", "<A-k>", "V:m '<-2<CR>gv=gv<Esc>")

vim.keymap.set("n", "<CR>", [[{-> v:hlsearch ? ":nohl\<CR>" : "\<CR>"}()]], { silent = true, expr = true })
