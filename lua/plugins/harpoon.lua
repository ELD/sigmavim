return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")
		harpoon:setup()

		vim.keymap.set("n", "<leader>h", function() harpoon:list():add() end, { desc = "Harpoon: Add to list", silent = true })
		vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon: List", silent = true })

		vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end, { desc = "Harpoon: Quick Jump: 1", silent = true })
		vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end, { desc = "Harpoon: Quick Jump: 2", silent = true })
		vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end, { desc = "Harpoon: Quick Jump: 3", silent = true })
		vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end, { desc = "Harpoon: Quick Jump: 4", silent = true })

		vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end, { desc = "Harpoon: Previous", silent = true })
		vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end, { desc = "Harpoon: Next", silent = true })
	end,
}
