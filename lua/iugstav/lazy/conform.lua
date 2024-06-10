return {

	{
		"stevearc/conform.nvim",
		keys = {
			{
				"<leader>F",
				function()
					require("conform").format({})
				end,
				desc = "Format",
			},
		},
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
	}
}

