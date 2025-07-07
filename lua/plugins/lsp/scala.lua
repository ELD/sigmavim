return {
	"scalameta/nvim-metals",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	ft = { "scala", "sbt", "java" },
	opts = function()
		local metals_config = require("metals").bare_config()
		metals_config.settings = {
			showImplicitArguments = true,
			showInferredType = true,
			excludedPackages = {
				"akka.actor.typed.javadsl",
				"com.github.swagger.akka.javadsl",
				"akka.stream.javadsl",
			},
			fallbackScalaVersion = "2.13.7",
			javaHome = "/Library/Java/JavaVirtualMachines/amazon-corretto-11.jdk/Contents/Home"
		}
		metals_config.init_options.statusBarProvider = false

		return metals_config
	end,
	config = function(self, metals_config)
		local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
		vim.api.nvim_create_autocmd("FileType", {
			pattern = self.ft,
			callback = function()
				require("metals").initialize_or_attach(metals_config)
				vim.keymap.set("n", "<leader>mm", require("metals").commands, { silent = true, desc = "Metals Command Picker" })
			end,
			group = nvim_metals_group,
		})
	end
}
