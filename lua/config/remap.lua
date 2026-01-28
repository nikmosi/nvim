vim.g.mapleader = " "

vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<A-j>", "V:m '>+1<CR>gv=gv<Esc>", { silent = true, desc = "Move line down" })
vim.keymap.set("n", "<A-k>", "V:m '<-2<CR>gv=gv<Esc>", { silent = true, desc = "Move line up" })

vim.keymap.set("n", "q:", ":q<CR>", { noremap = true, silent = true })

-- clips
vim.keymap.set({ "n", "v" }, "<leader>y", "\"+y", { desc = "Yank to clipboard" })
vim.keymap.set("n", "<leader>Y", "\"+yy", { desc = "Yank line to clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>p", "\"+p", { desc = "Paste from clipboard" })
vim.keymap.set("x", "<leader>P", "\"_dP", { desc = "Delete to void" })

vim.keymap.set("n", "<leader>W", function() vim.cmd "noautocmd w" end, { desc = "Write without formatting" })
vim.keymap.set("n", "<leader>w", function() vim.cmd "w" end, { desc = "Write formatting" })

vim.api.nvim_set_keymap("t", "<Esc>", [[<C-\><C-n>]], { noremap = true })
