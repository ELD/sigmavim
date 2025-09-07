vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.stitch",
	callback = function()
		vim.bo.filetype = "stitch"
	end,
})
