local kind_icons = {
	Text = "",
	Method = "󰆧",
	Function = "󰊕",
	Constructor = "",
	Field = "󰇽",
	Variable = "󰂡",
	Class = "󰠱",
	Interface = "",
	Module = "",
	Property = "󰜢",
	Unit = "",
	Value = "󰎠",
	Enum = "",
	Keyword = "󰌋",
	Snippet = "",
	Color = "󰏘",
	File = "󰈙",
	Reference = "",
	Folder = "󰉋",
	EnumMember = "",
	Constant = "󰏿",
	Struct = "",
	Event = "",
	Operator = "󰆕",
	TypeParameter = "󰅲",
}

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"j-hui/fidget.nvim",
	},
	branch = "master",

	opts = {
		autoformat = false,
	},

	config = function()
		local cmp = require("cmp")
		local cmp_lsp = require("cmp_nvim_lsp")
		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			cmp_lsp.default_capabilities()
		)

		local capabilities = nil
		if pcall(require, "cmp_nvim_lsp") then
			capabilities = require("cmp_nvim_lsp").default_capabilities()
		end

		local lspconfig = require("lspconfig")

		local servers = {
			clangd = {
				cmd = {
					"clangd",
					"--fallback-style=Webkit",
				},
			},
			gopls = {
				settings = {
					gopls = {
						hints = {
							assignVariableTypes = true,
							compositeLiteralFields = true,
							compositeLiteralTypes = true,
							constantValues = true,
							functionTypeParameters = true,
							parameterNames = true,
							rangeVariableTypes = true,
						},
						semanticTokens = true,
					},
				},
			},
			lua_ls = {
				single_file_support = true,
				settings = {
					Lua = {
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},
					},
				},
				server_capabilities = {
					semanticTokensProvider = vim.NIL,
				},
			},
			cssls = true,
			tailwindcss = {
				filetypes = {
					"astro",
					"astro-markdown",
					"blade",
					"django-html",
					"ejs",
					"gohtml",
					"handlebars",
					"hbs",
					"html",
					"liquid",
					"mustache",
					"njk",
					"nunjucks",
					"razor",
					"slim",
					"twig",
					"css",
					"less",
					"postcss",
					"sass",
					"scss",
					"stylus",
					"sugarss",
					"javascript",
					"javascriptreact",
					"reason",
					"rescript",
					"typescript",
					"typescriptreact",
					"vue",
					"svelte",
				},
				root_dir = require("lspconfig").util.root_pattern(
					"tailwind.config.cjs",
					"tailwind.config.js",
					"tailwind.config.ts",
					"postcss.config.cjs",
					"postcss.config.js",
					"postcss.config.ts",
					"package.json",
					"node_modules",
					".git"
				),
			},
			html = {
				filetypes = {
					"html",
					"js",
					"ts",
					"njk",
				},
			},

			tsserver = {
				server_capabilities = {
					documentFormattingProvider = false,
				},
			},

			ocamllsp = {
				manual_install = true,
				settings = {
					codelens = { enable = true },
					inlayHints = { enable = true },
				},

				filetypes = {
					"ocaml",
					"ocaml.interface",
					"ocaml.menhir",
					"ocaml.cram",
				},
			},

			-- hls = {
			-- 	settings = {
			-- 		codelens = { enable = true },
			-- 	},
			-- },

			basedpyright = {
				settings = {
					basedpyright = {
						analysis = {
							typeCheckingMode = "recommended",
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
							autoImportCompletions = true,
							diagnosticSeverityOverrides = {
								reportUnknownMemberType = false,
								reportUnknownArgumentType = false,
								-- reportUnusedClass = "warning",
								-- reportUnusedFunction = "warning",
								reportUndefinedVariable = true,
							},
						},
					},
				},
			},

			jsonls = {
				on_new_config = function(new_config)
					new_config.settings.json.schemas = new_config.settings.json.schemas or {}
					vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
				end,
				settings = {
					json = {
						format = {
							enable = true,
						},
						validate = { enable = true },
					},
				},
			},

			yamlls = {
				settings = {
					yaml = {
						schemaStore = {
							url = "https://www.schemastore.org/api/json/catalog.json",
							enable = true,
						},
					},
				},
			},
		}

		local servers_to_install = vim.tbl_filter(function(key)
			local t = servers[key]
			if type(t) == "table" then
				return not t.manual_install
			else
				return t
			end
		end, vim.tbl_keys(servers))

		require("fidget").setup({})

		require("mason").setup({})

		local ensure_installed = {
			"stylua",
			"lua_ls",
			"delve",
			"tailwindcss-language-server",
		}

		vim.list_extend(ensure_installed, servers_to_install)
		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

		for name, config in pairs(servers) do
			if config == true then
				config = {}
			end
			config = vim.tbl_deep_extend("force", {}, {
				capabilities = capabilities,
			}, config)

			lspconfig[name].setup(config)
		end

		lspconfig.vala_ls.setup({
			cmd = { "vala-language-server" },
			filetypes = { "vala", "genie" },
			root_dir = lspconfig.util.root_pattern("meson.build", ".git"),
			single_file_support = true,
		})

		-- local mason_root = vim.fn.stdpath("data") .. "/mason/packages/" --[[@as string]]
		-- lspconfig.omnisharp.setup({
		-- 	cmd = { "dotnet", mason_root .. "omnisharp/libexec/OmniSharp.dll" },
		-- 	settings = {
		-- 		FormattingOptions = {
		-- 			OrganizeImports = true,
		-- 		},
		-- 	},
		-- })

		lspconfig.gdscript.setup({})
		lspconfig.hls.setup({})

		local cmp_select = { behavior = cmp.SelectBehavior.Select }

		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(e)
				local client = assert(vim.lsp.get_client_by_id(e.data.client_id), "must have valid client")
				vim.bo[e.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

				local settings = servers[client.name]
				if type(settings) ~= "table" then
					settings = {}
				end

				local opts = { buffer = e.buf }
				vim.keymap.set("n", "gd", function()
					vim.lsp.buf.definition()
				end, opts)
				vim.keymap.set("n", "K", function()
					vim.lsp.buf.hover()
				end, opts)
				vim.keymap.set("n", "<leader>vws", function()
					vim.lsp.buf.workspace_symbol()
				end, opts)
				vim.keymap.set("n", "<leader>vd", function()
					vim.diagnostic.open_float()
				end, opts)
				vim.keymap.set("n", "<leader>vca", function()
					vim.lsp.buf.code_action()
				end, opts)
				vim.keymap.set("n", "<leader>vrr", function()
					vim.lsp.buf.references()
				end, opts)
				vim.keymap.set("n", "<leader>vrn", function()
					vim.lsp.buf.rename()
				end, opts)
				vim.keymap.set("i", "<C-h>", function()
					vim.lsp.buf.signature_help()
				end, opts)
				vim.keymap.set("n", "[d", function()
					vim.diagnostic.goto_next()
				end, opts)
				vim.keymap.set("n", "]d", function()
					vim.diagnostic.goto_prev()
				end, opts)

				if settings.server_capabilities then
					for k, v in pairs(settings.server_capabilities) do
						if v == vim.NIL then
							---@diagnostic disable-next-line: cast-local-type
							v = nil
						end

						client.server_capabilities[k] = v
					end
				end
			end,
		})
		cmp.setup({
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
				end,
			},

			experimental = {
				ghost_text = false,
			},

			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},

			mapping = cmp.mapping.preset.insert({
				["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
				["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
				["<CR>"] = cmp.mapping.confirm({ select = false }),
				["<C-Space>"] = cmp.mapping.complete(),
			}),

			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" }, -- For luasnip users.
			}, {
				{ name = "buffer" },
				{ name = "path" },
			}),

			formatting = {
				format = function(entry, vim_item)
					-- Kind icons
					vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind) -- This concatenates the icons with the name of the item kind
					-- Source
					vim_item.menu = ({
						buffer = "[Buffer]",
						nvim_lsp = "[LSP]",
						luasnip = "[LuaSnip]",
						nvim_lua = "[Lua]",
						latex_symbols = "[LaTeX]",
					})[entry.source.name]
					return vim_item
				end,
			},
		})

		vim.diagnostic.config({
			-- update_in_insert = true,
			virtual_text = {
				source = "always",
			},
			signs = true,
			severity_sort = false,
			underline = true,
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		})
	end,
}
