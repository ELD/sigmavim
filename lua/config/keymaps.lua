local opts = { remap = true, silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected line(s) down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected line(s) up" })

vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines and keep cursor in the same position" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down half a page and center cursor" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up half a page and center cursor" })

vim.keymap.set("n", "n", "nzzzv", { desc = "Search next and center cursor" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Search previous and center cursor" })
