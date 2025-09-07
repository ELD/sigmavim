vim.filetype.add({
	extension = {
		stitch = "templ",
	},
})

vim.treesitter.language.register("templ", "stitch")
