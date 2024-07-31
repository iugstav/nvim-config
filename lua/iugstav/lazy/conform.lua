return {

	{
		"stevearc/conform.nvim",
		keys = {
			{
				-- Customize or remove this keymap to your liking
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = "",
				desc = "Format buffer",
			},
		},

		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				ocaml = { "ocamlformat" },
			},

			format_on_save = function()
				vim.g.disable_autoformat = true
			end,
		},
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
	},
}
