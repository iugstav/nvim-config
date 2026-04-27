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
				ocaml = { "ocamlformat" },
				python = { "black" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				svelte = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "mdformat" },
				graphql = { "prettier" },
				liquid = { "prettier" },
				lua = { "stylua" },
				sql = { "sql_formatter" },
			},

			format_on_save = function()
				vim.g.disable_autoformat = true
			end,
		},
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
	},
}
