return {
	enabled = false,
	"yetone/avante.nvim",
	event = "VeryLazy",
	version = false, -- Never set this value to "*"! Never!
	opts = {
		provider = "copilot4",
		cursor_applying_provider = "copilot4",
		auto_suggestions_provider = "copilot6",
		behaviour = {
			auto_suggestions = true, -- Experimental stage
			auto_suggestions_respect_ignore = true,
			auto_set_highlight_group = true,
			auto_set_keymaps = true,
			auto_apply_diff_after_generation = false,
			support_paste_from_clipboard = true,
			minimize_diff = true,
			enable_token_counting = true,
			enable_cursor_planning_mode = true,
			auto_focus_sidebar = false,
		},
		suggestion = {
			debounce = 1000,
			throttle = 1000,
		},
		web_search_engine = {
			provider = "perplexity",
		},
		providers = {
			copilot = {
				endpoint = "https://api.githubcopilot.com",
				proxy = nil,
				allow_insecure = false,
				timeout = 10 * 60 * 1000,
				max_completion_tokens = 1000000,
				reasoning_effort = "high",
				extra_request_body = {
					temperature = 0,
				},
			},
			copilot1 = {
				__inherited_from = "copilot",
				model = "claude-3.5-sonnet",
				display_name = "copilot/claude-3.5-sonnet",
			},
			copilot2 = {
				__inherited_from = "copilot",
				model = "claude-3.7-sonnet",
				display_name = "copilot/claude-3.7-sonnet",
			},
			copilot3 = {
				__inherited_from = "copilot",
				model = "claude-3.7-sonnet-thought",
				display_name = "copilot/claude-3.7-sonnet-thought",
			},
			copilot4 = {
				__inherited_from = "copilot",
				model = "claude-sonnet-4",
				display_name = "copilot/claude-sonnet-4",
			},
			copilot5 = {
				__inherited_from = "copilot",
				model = "o4-mini",
				display_name = "copilot/o4-mini",
			},
			copilot6 = {
				__inherited_from = "copilot",
				model = "gpt-4.1",
				display_name = "copilot/gpt-4.1",
			},
		},
	},
	-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
	build = "make",
	-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"stevearc/dressing.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		--- The below dependencies are optional but recommended for AI-assisted coding
		-- "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
		-- "ibhagwan/fzf-lua", -- for file_selector provider fzf
		"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
		"zbirenbaum/copilot.lua",
		{
			-- support for image pasting
			"HakonHarnes/img-clip.nvim",
			event = "VeryLazy",
			opts = {
				-- recommended settings
				default = {
					embed_image_as_base64 = false,
					prompt_for_file_name = false,
					drag_and_drop = {
						insert_mode = true,
					},
					-- required for Windows users
					use_absolute_path = true,
				},
			},
		},
	},
}
