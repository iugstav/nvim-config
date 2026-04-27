return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		-- No Neovim 0.12, tentamos carregar o módulo com segurança
		local status, configs = pcall(require, "nvim-treesitter.configs")

		if status then
			configs.setup({
				ensure_installed = {
					"c",
					"cpp",
					"lua",
					"rust",
					"bash",
					"vim",
					"vimdoc",
				},
				sync_install = false,
				auto_install = true,
				highlight = {
					enable = true,
					disable = { "latex" },
					additional_vim_regex_highlighting = false,
				},
				indent = { enable = false },
			})
		else
			-- Se o módulo sumiu (versões v1.0+), o Neovim 0.12
			-- já gerencia quase tudo nativamente.
			-- Você só precisa garantir que os parsers existam:
			vim.cmd("TSUpdate")
		end

		vim.treesitter.language.register("markdown", "mdx")
	end,
}
