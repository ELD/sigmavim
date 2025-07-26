-- For `plugins/markview.lua` users.
return {
	"OXY2DEV/markview.nvim",
	lazy = false,
	priority = 49,
	keys = {
		{ "<leader>mci", "<cmd>Checkbox Interactive<cr>", desc = "Markview Checkbox Interactive" },
		{ "<leader>mct", "<cmd>Checkbox toggle<cr>", desc = "Markview Checkbox Toggle" },
		{ "<leader>mcc", "<cmd>Editor create<cr>", desc = "Markview Create Code Block" },
		{ "<leader>mce", "<cmd>Editor edit<cr>", desc = "Markview Edit Code Block" }
	},
	config = function()
		require("markview.extras.checkboxes").setup()
		require("markview.extras.editor").setup()
		require("markview.extras.headings").setup()
	end,
};
