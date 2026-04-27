return {
	{
		"zenbones-theme/zenbones.nvim",
		-- Optionally install Lush. Allows for more configuration or extending the colorscheme
		-- If you don't want to install lush, make sure to set g:zenbones_compat = 1
		-- In Vim, compat mode is turned on as Lush only works in Neovim.
		dependencies = "rktjmp/lush.nvim",
		lazy = false,
		priority = 1000,
		-- you can set set configuration options here
		config = function()
			require("lush")(require("iugstav.colors.custom_zenbones"))

			-- vim.g.zenbones_darkness = "stark"
			-- vim.g.zenbones_darken_comments = 40
			-- vim.g.zenbones_lighten_text = 100
			-- vim.cmd.colorscheme("zenbones")
		end,
	},
}
