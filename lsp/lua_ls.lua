vim.lsp.config.lua_ls = {
	settings = {
		Lua = {
			runtime = {
				verison = "LuaJIT",
				path = "$VIMRUNTIME/lua",
			},
			diagnostics = {
				globals = { "vim" },
				neededFileStatus = {
					["codestyle-check"] = "Any",
				},
			},
			format = {
				enable = true,
				defaultConfig = {
					indent_style = "tab",
					indent_size = "2",
					quote_style = "double",
					max_line_length = "120",
				},
			},
		},
	},
}
