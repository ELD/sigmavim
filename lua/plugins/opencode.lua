return {
	"NickvanDyke/opencode.nvim",
	dependencies = {
		"folke/snacks.nvim",
	},
	opts = {
		terminal = {
			win = {
				position = "bottom",
			},
		},
		prompts = {
			codereview = {
				description = "Review this code for correctness, idiomaticness, and general readability",
				prompt = "Review the following code and based on the language of the code, review its correctness, idiomaticness, readibility, and future maintainability. Key in on any code smells, maintenance red-flags, or things that may make it more difficult to extend later. Also, identify any places where the code could be made more idiomatic. Finally, do a rough performance evaluation of the code and identify easy performance wins that don't hinder readability or maintainability.",
				key = "<leader>ocr",
			}
		},
	},
	keys = {
		{ "<leader>oa", function() require("opencode").ask() end,                                                         desc = "Ask opencode",                    mode = { "n", "v" }, },
		{ "<leader>oA", function() require("opencode").ask("@file ") end,                                                 desc = "Ask opencode about current file", mode = { "n", "v" }, },
		{ "<leader>oe", function() require("opencode").prompt("Explain @cursor and its context") end,                     desc = "Explain code near cursor" },
		{ "<leader>or", function() require("opencode").prompt("Review @file for correctness and readability") end,        desc = "Review file", },
		{ "<leader>of", function() require("opencode").prompt("Fix these @diagnostics") end,                              desc = "Fix errors", },
		{ "<leader>oo", function() require("opencode").prompt("Optimize @selection for performance and readability") end, desc = "Optimize selection",              mode = "v", },
		{ "<leader>od", function() require("opencode").prompt("Add documentation comments for @selection") end,           desc = "Document selection",              mode = "v", },
		{ "<leader>ot", function() require("opencode").prompt("Add tests for @selection") end,                            desc = "Test selection",                  mode = "v", },
		{ "<leader>oT", function() require("snacks.terminal").toggle("opencode", { win = { position = "right", }, }) end, desc = "Toggle Opencode" },
	},
}
