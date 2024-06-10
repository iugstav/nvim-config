require "iugstav.remap"
require "iugstav.set"
require "iugstav.lazy_init"

local augroup = vim.api.nvim_create_augroup
local iugstavGroup = augroup('Iugstav', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

vim.filetype.add({
	extension = {
		templ = 'templ',
	}
})

autocmd({ "BufWritePre" }, {
	group = iugstavGroup,
	pattern = "*",
	command = [[%s/\s\+$//e]],
})

autocmd('TextYankPost', {
	group = yank_group,
	pattern = '*',
	callback = function()
		vim.highlight.on_yank({
			higroup = 'IncSearch',
			timeout = 40,
		})
	end,
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
