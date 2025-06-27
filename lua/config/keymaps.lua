local opts = { remap = true, silent = true }
local function extend_opts(additional_opts)
	return vim.tbl_deep_extend("force", opts, additional_opts)
end

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected line(s) down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected line(s) up" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down half a page and center cursor" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up half a page and center cursor" })

vim.keymap.set("n", "n", "nzzzv", { desc = "Search next and center cursor" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Search previous and center cursor" })

vim.keymap.set("v", "<", "<gv", extend_opts({ desc = "Indent left and keep selection" }))
vim.keymap.set("v", ">", ">gv", extend_opts({ desc = "Indent right and keep selection" }))

vim.keymap.set("x", "<leader>p", [["_dP]], extend_opts({ desc = "Paste without replacing clipboard" }))
vim.keymap.set("v", "p", '"_dp', opts)
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], extend_opts({ desc = "Delete without keeping contents" }))

vim.keymap.set("n", "<C-c", ":nohl<CR>", extend_opts({ desc = "Clear search highlight" }))

vim.keymap.set("n", "<leader>rf", vim.lsp.buf.format, extend_opts({ desc = "[LSP] [r]e[f]ormat code" }))

vim.keymap.set("n", "x", '"_x', { silent = true })
vim.keymap.set("n", "X", '"_X', { silent = true })

vim.keymap.set("n", "<leader>sr", ":%s/<C-r><C-w>//g<Left><Left>",
	{ noremap = true, desc = "[s]earch and [r]eplace at cursor" })
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", extend_opts({ desc = "Set E[x]ecutable bit on current file" }))

-- Tab commands
vim.keymap.set("n", "<leader>to", "<cmd>tabnew<CR>")
vim.keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>")
vim.keymap.set("n", "<leader>tn", "<cmd>tabn<CR>")
vim.keymap.set("n", "<leader>tp", "<cmd>tabp<CR>")
vim.keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>")

-- Split commands
vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Splits window vertically" })
vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Splits window horizontally" })
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
vim.keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- Buffer commands
vim.keymap.set("n", "<leader>cf", function()
	local file_path = vim.fn.expand("%:~")
	vim.fn.setreg("+", file_path)
	print("File path copied to clipboard: " .. file_path)
end, { desc = "Copy file path to clipboard" })
