-- Diagnostics {{{
local severity = vim.diagnostic.severity
vim.diagnostic.config({
	underline = {
		severity = {
			min = severity.WARN,
		},
	},
	signs = {
		severity = {
			min = severity.WARN,
		},
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.INFO] = "",
			[vim.diagnostic.severity.HINT] = "",
		},
		numhl = {
			[vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
			[vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
			[vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
			[vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
		},
	},
	virtual_text = false,
	virtual_lines = true,
	update_in_insert = true,
	severity_sort = true,
	float = {
		source = "if_many",
		border = "rounded",
		show_header = false,
	},
})
-- }}}
