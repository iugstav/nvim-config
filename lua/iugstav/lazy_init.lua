local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.env.GIT_DIR = nil
	vim.env.GIT_WORK_TREE = nil
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local ok, lazy = pcall(require, "lazy")
if ok then
	lazy.setup({
		import = "lazy" ,
		spec = "iugstav.lazy",
		change_detection = { notify = false },
	})
else
	vim.notify("unable to load lazy")
end
