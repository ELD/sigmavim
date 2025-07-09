return {
	{ "L3MON4D3/LuaSnip", keys = {} },
	{
		"saghen/blink.cmp",
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
		version = "*",
		config = function()
			require("blink.cmp").setup({
				snippets = { preset = "luasnip" },
				signature = { enabled = true },
				appearance = {
					use_nvim_cmp_as_default = false,
					nerd_font_variant = "normal",
				},
				sources = {
					default = { "lsp", "path", "snippets", "buffer" },
					providers = {
						lsp = {
							score_offset = 100,
						},
						path = {
							score_offset = 75,
						},
						snippets = {
							score_offset = 50,
						},
						cmdline = {
							min_keyword_length = 2,
							score_offset = 10,
						},
						buffer = {
							score_offset = 0,
						},
					},
				},
				keymap = {
					preset = "default",
				},
				cmdline = {
					enabled = true,
					keymap = {
						["<CR>"] = { "accept_and_enter", "fallback" },
					},
				},
				completion = {
					menu = {
						border = "double",
						scrolloff = 1,
						scrollbar = false,
						draw = {
							treesitter = { "lsp" },
							columns = {
								{ "kind_icon", gap = 1 },
								{ "label", gap = 10 },
								{ "kind" },
								{ "label_description" },
								{ "source_name" },
							},
						},
					},
					documentation = {
						window = {
							border = "double",
							scrollbar = true,
							winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc",
						},
						auto_show = true,
						auto_show_delay_ms = 500,
					},
				},
			})

			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},
}
