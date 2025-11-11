require("iugstav.remap")
require("iugstav.set")
require("iugstav.lazy_init")

local augroup = vim.api.nvim_create_augroup
local iugstavGroup = augroup("Iugstav", {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", {})

autocmd("BufWritePre", {
	group = iugstavGroup,
	pattern = "*",
	command = [[%s/\s\+$//e]],
})

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

autocmd("FileType", {
	group = yank_group,
	pattern = { "swift" },
	callback = function()
		local root_dir = "/usr/local/bin/sourcekit-lsp"
		local client = vim.lsp.start({
			name = "sourcekit-lsp",
			cmd = { "sourcekit-lsp" },
			root_dir = root_dir,
		})
		vim.lsp.buf_attach_client(0, client)
	end,
})

autocmd("FileType", {
	callback = function()
		local ext = vim.fn.fnamemodify(vim.fn.expand("%"), ":e")
		if ext == "m" then
			vim.bo.filetype = "octave"
		end
	end,
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

-- vim.opt.rtp:prepend("/home/iugstav/.opam/5.2.0/share/ocp-indent/vim")
-- local opamshare = vim.fn.system("opam var share"):gsub("\n$", "")
-- vim.opt.rtp:append(opamshare .. "/merlin/vim")
