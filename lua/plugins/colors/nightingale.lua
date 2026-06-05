return {
	"xeind/nightingale.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("nightingale").setup({
			transparent = true,
		})
		-- vim.cmd.colorscheme([[nightingale]])
	end,
}
