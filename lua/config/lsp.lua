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

-- Improve LSPs UI {{{
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.buf.signature_help({
	border = "rounded",
	close_events = { "CursorMoved", "BufHidden", "InsertCharPre" }
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.buf.hover({
	{ border = "rounded", close_events = { "CursorMoved", "BufHidden" } }
})


local icons = {
	Class = " ",
	Color = " ",
	Constant = " ",
	Constructor = " ",
	Enum = " ",
	EnumMember = " ",
	Event = " ",
	Field = " ",
	File = " ",
	Folder = " ",
	Function = "󰊕 ",
	Interface = " ",
	Keyword = " ",
	Method = "ƒ ",
	Module = "󰏗 ",
	Property = " ",
	Snippet = " ",
	Struct = " ",
	Text = " ",
	Unit = " ",
	Value = " ",
	Variable = " ",
}

local completion_kinds = vim.lsp.protocol.CompletionItemKind
for i, kind in ipairs(completion_kinds) do
	completion_kinds[i] = icons[kind] and icons[kind] .. kind or kind
end
-- }}}

-- LSP capabilities {{{
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
	dynamicRegistration = true,
	lineFoldingOnly = true,
}
capabilities.textDocument.semanticTokens.multilineTokenSupport = true
capabilities.textDocument.completion.completionItem.snippetSupport = true

local loaded_blink, blink = xpcall(require, debug.traceback, "blink.cmp")
if loaded_blink then
	capabilities = blink.get_lsp_capabilities(capabilities)
end

vim.lsp.config("*", {
	capabilities = capabilities,
})
-- }}}

-- Servers {{{
---@type table<string, vim.lsp.ClientConfig>
local servers = {
	-- LuaLS {{{
	lua_ls = {
		cmd = { "lua-language-server" },
		root_markers = {
			".luarc.json",
			".luarc.jsonc",
			".luacheckrc",
			".stylua.toml",
			"stylua.toml",
			"selene.toml",
			"selene.yml",
			".git",
			vim.uv.cwd(),
		},
		filetypes = { "lua" },
		on_init = function(client)
			local path = client.workspace_folders and client.workspace_folders[1].name or "."
			if vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc") then
				return
			end

			client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
				runtime = {
					verison = "LuaJIT",
					path = "$VIMRUNTIME/lua",
				},
				hint = {
					enable = true,
				},
				diagnostics = {
					globals = { "_G", "vim" },
					neededFileStatus = {
						["codestyle-check"] = "Any",
					},
				},
				workspace = {
					preloadFileSize = 500,
					checkThirdParty = false,
					library = vim.api.nvim_get_runtime_file("", true)
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
			})
		end,
		settings = {
			Lua = {
				telemetry = {
					enable = false,
				},
			},
		},
	},
	-- }}}
	-- Nix {{{
	nil_ls = {
		cmd = { "nil" },
		root_markers = { "flake.nix", ".git", vim.uv.cwd() },
		filetypes = { "nix" },
	},
	-- }}}
	-- TSServer {{{
	tsserver = {
		cmd = { "typescript-language-server", "--stdio" },
		root_markers = { "tsconfig.json", "jsonconfig.json", "package.json", ".git" },
		filetypes = {
			"javascript",
			"javascriptreact",
			"javascript.jsx",
			"typescript",
			"typescriptreact",
			"typescript.tsx",
		},
		init_options = {
			hostInfo = "neovim",
		},
	},
	-- }}}
	-- TailwindCSS {{{
	tailwindcssls = {
		cmd = { "tailwindcss-language-server", "--stdio" },
		root_markers = {
			"tailwind.config.js",
			"tailwind.config.cjs",
			"tailwind.config.mjs",
			"tailwind.config.ts",
			"postcss.config.js",
			"postcss.config.cjs",
			"postcss.config.mjs",
			"postcss.config.ts",
			"package.json",
			"node_modules",
			".git",
		},
		filetypes = {
			"aspnetcorerazor",
			"astro",
			"astro-markdown",
			"blade",
			"clojure",
			"django-html",
			"htmldjango",
			"edge",
			"eelixir",
			"elixir",
			"ejs",
			"erb",
			"eruby",
			"gohtml",
			"gohtmltmpl",
			"haml",
			"handlebars",
			"hbs",
			"html",
			"htmlangular",
			"html-eex",
			"heex",
			"jade",
			"leaf",
			"liquid",
			"markdown",
			"mdx",
			"mustache",
			"njk",
			"nunjucks",
			"php",
			"razor",
			"slim",
			"twig",
			"css",
			"less",
			"postcss",
			"sass",
			"scss",
			"stylus",
			"sugarss",
			"javascript",
			"javascriptreact",
			"reason",
			"rescript",
			"typescript",
			"typescriptreact",
			"vue",
			"svelte",
			"templ",
		},
		settings = {
			tailwindCSS = {
				classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
				includeLanguages = {
					eelixir = "html-eex",
					eruby = "erb",
					htmlangular = "html",
					templ = "html",
					askama = "html",
				},
				lint = {
					cssConflict = "warning",
					invalidApply = "error",
					invalidConfigPath = "error",
					invalidScreen = "error",
					invalidTailwindDirective = "error",
					invalidVariant = "error",
					recommendedVariantOrder = "warning",
				},
				validate = true,
			},
		},
	},
	-- }}}
	-- HTML {{{
	htmlls = {
		name = "html",
		cmd = { "vscode-html-language-server", "--stdio" },
		root_markers = { "package.json", ".git" },
		filetypes = { "html", "askama", "templ" },
		init_options = {
			configurationSection = { "html", "css", "javascript" },
			embeddedLanguages = {
				css = true,
				javascript = true,
			},
			provideFormatter = true,
		},
	},
	-- }}}
	-- ZLS {{{
	zls = {
		name = "zig",
		cmd = { "zls" },
		root_markers = { ".git" },
		filetypes = { "zig" },
	},
	-- }}}
}
local server_names = vim.tbl_keys(servers)
for _, server_name in ipairs(server_names) do
	vim.lsp.config[server_name] = servers[server_name]
end

vim.lsp.enable(server_names)
-- }}}                     s

-- Disable default keybinds {{{
for _, bind in ipairs({ "grn", "gra", "gri", "grr" }) do
	vim.keymap.del("n", bind)
end
-- }}}

-- Create keybindings, commands, and autocommands on LSP attach {{{
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local bufnr = ev.buf
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if not client then
			return
		end
		if client.server_capabilities.completionProvider then
			vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
		end
		if client.server_capabilities.definitionProvider then
			vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
		end

		client.server_capabilities.semanticTokensProvider = nil

		local kbd = vim.keymap.set
		kbd("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover Documentation" })
		kbd("n", "<M-CR>", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code actions" })
		kbd("n", "<leader>rr", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename" })
		kbd("n", "<leader>ldl", function()
			vim.diagnostic.open_float({
				focusable = false,
				close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
				border = "rounded",
				source = "if_many",
				prefix = " ",
				scope = "cursor",
			})
		end, { buffer = bufnr, desc = "Show line dignostics" })
		kbd("n", "<leader>ldp", function()
			vim.diagnostic.jump({ count = -1, float = true })
		end, { buffer = bufnr, desc = "Goto previous diagnostic" })
		kbd("n", "<leader>ldn", function()
			vim.diagnostic.jump({ count = 1, float = true })
		end, { buffer = bufnr, desc = "Goto next diagnostic" })
		kbd("n", "<leader>lgd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Goto definition" })
		kbd("n", "<leader>lgD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "Goto declaration" })
		vim.keymap.set("n", "<M-CR>", vim.lsp.buf.code_action, { silent = true, buffer = bufnr })

		vim.api.nvim_create_augroup("Lsp", { clear = true })
		if client.name == "eslint" then
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = "Lsp",
				buffer = bufnr,
				command = "EslintFixAll",
			})
		end

		vim.api.nvim_create_user_command(
			"LspFormat",
			vim.lsp.buf.format,
			{ desc = "Format current buffer using LSP" }
		)
	end
})
-- }}}

-- Global commands (start, stop, restart, etc) {{{
if vim.fn.expand("%:e") ~= "rs" then
	-- Start {{{
	vim.api.nvim_create_user_command("LspStart", function()
		vim.cmd.e()
	end, { desc = "Starts LSP clients in the current buffer" })
	-- }}}

	-- Stop {{{
	vim.api.nvim_create_user_command("LspStop", function(opts)
		for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
			if opts.args == "" or opts.args == client.name then
				client:stop(true)
				vim.notify("[core.lsp] " .. client.name .. ": stopped")
			end
		end
	end, {
		desc = "Stop all LSP clients or a specific client attached to the current buffer",
		nargs = "?",
		complete = function(_, _, _)
			local clients = vim.lsp.get_clients({ bufnr = 0 })
			local client_names = {}
			for _, client in ipairs(clients) do
				table.insert(client_names, client.name)
			end
			return client_names
		end
	})
	-- }}}

	-- Restart {{{
	vim.api.nvim_create_user_command("LspRestart", function()
		local detach_clients = {}
		for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
			client:stop(true)
			if vim.tbl_count(client.attached_buffers) > 0 then
				detach_clients[client.name] = { client, vim.lsp.get_buffers_by_client_id(client.id) }
			end
		end
		local timer = vim.uv.new_timer()
		if not timer then
			return
		end
		timer:start(
			100,
			50,
			vim.schedule_wrap(function()
				for name, client in ipairs(detach_clients) do
					local client_id = vim.lsp.start(client[1].config, { attach = true })
					if client_id then
						for _, buf in ipairs(client[2]) do
							vim.lsp.buf_attach_client(buf, client_id)
						end
						vim.notify("[core.lsp] " .. name .. ": restarted")
					end
					detach_clients[name] = nil
				end
				if next(detach_clients) == nil and not timer:is_closing() then
					timer:close()
				end
			end)
		)
	end, {
		desc = "Restart all the LSP clients attached to the current buffer",
	})
	-- }}}

	-- Log {{{
	vim.api.nvim_create_user_command("LspLog", function()
		vim.cmd.vsplit(vim.lsp.log.get_filename())
	end, { desc = "Get all the LSP logs" })
	-- }}}

	--Info {{{
	vim.api.nvim_create_user_command("LspInfo", function()
		vim.cmd("silent checkhealth vim.lsp")
	end, { desc = "Get all the information about all LSP attached" })
	--}}}
end
-- }}}
