return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "macchiato",
			background = {
				dark = "macchiato",
				light = "latte",
			},
			styles = {
				comments = { "italic" }, -- Change the style of comments
				conditionals = { "italic" },
				loops = {},
				functions = { "bold" },
				keywords = { "bold" },
				strings = { "italic" },
				variables = {},
				numbers = {},
				booleans = {},
				properties = {},
				types = {},
				operators = {},
			},
			default_integrations = true,
			integrations = {
				blink_cmp = {
					style = "bordered",
				},
				gitsigns = true,
				nvimtree = true,
				treesitter = true,
				notify = false,
				mini = {
					enabled = true,
					indentscope_color = "",
				},
			},
		})
		vim.cmd.colorscheme([[catppuccin]])
	end,
}
