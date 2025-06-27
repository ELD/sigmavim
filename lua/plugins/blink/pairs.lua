return {
	"saghen/blink.pairs",
	version = "*",
	dependencies = "saghen/blink.download",
	opts = {
		mappings = {
			enabled = true,
			disabled_filetypes = {},
			pairs = {},
		},
		highlights = {
			enabled = true,
			groups = {
				"BlinkPairsOrange",
				"BlinkPairsPurple",
				"BlinkPairsBlue",
			},
			matchparen = {
				enabled = true,
				group = "MatchParen",
			},
		},
		debug = false,
	},
}
