return {
	"dgox16/oldworld.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("oldworld").setup({
			terminal_colors = true,
			variant = "default",
			styles = {
				comments = { italic = true },
				keywords = { bold = true },
				identifiers = {},
				functions = { bold = true },
				variables = {},
				booleans = {},
			}
		})
		-- vim.cmd.colorscheme([[oldworld]])
	end,
}
