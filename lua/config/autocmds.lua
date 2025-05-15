local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local spartanvim_group = augroup("spartanvim", {})
local yank_group = augroup("highlightyank", {})

-- Turn off auto-commenting on newlines
autocmd("BufEnter", {
  group = spartanvim_group,
  pattern = { "*.md", "*.tex" },
  command = [[set formatoptions-=cro]]
})

-- Highlight on yank
autocmd("TextYankPost", {
  group = yank_group,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 40,
    })
  end,
})

-- Strip whitespace on save
autocmd("BufWritePre", {
  group = spartanvim_group,
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

-- Go to last location when opening buffer
autocmd("BufReadPost", {
  group = spartanvim_group,
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})
