return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	dependencies = {
		"mason-org/mason.nvim",
		"mason-org/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	},
	build = ":MasonToolsInstall",
	opts = {
		ensure_installed = {
			"bashls",
			"codelldb",
			"goimports",
			"gopls",
			"html-lsp",
			"lua_ls",
			"prettier",
			"rust_analyzer",
			"shellcheck",
			"shfmt",
			"stylua",
			"tailwindcss",
			"ts_ls",
		},
		lsps = {
			"bashls",
			"gopls",
			"html-lsp",
			"lua_ls",
			"tailwindcss",
			"ts_ls",
		},
	},
	config = function(_, opts)
		require("mason").setup()
		require("mason-tool-installer").setup(opts)
		vim.lsp.enable(opts.lsps)
	end,
}
