return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"folke/neodev.nvim",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",

			{ "j-hui/fidget.nvim", opts = {} },

			-- Autoformatting
			"stevearc/conform.nvim",

			-- Schema information
			"b0o/SchemaStore.nvim",
		},
		config = function()
			require("neodev").setup({
				-- library = {
				--   plugins = { "nvim-dap-ui" },
				--   types = true,
				-- },
			})

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			require("mason").setup()
			local ensure_installed = {
				"stylua",
				"lua_ls",
				"delve",
				"ts_ls",
				"zls",
			}

			local servers = {
				bashls = true,
				gopls = true,
				lua_ls = true,
				rust_analyzer = true,
				svelte = true,
				templ = true,
				cssls = true,
				pyright = true,
				eslint = true,
				html = true,
				tailwindcss = true,
				sqlls = true,
				zls = true,

				-- Probably want to disable formatting for this lang server
				ts_ls = true,

				jsonls = {
					settings = {
						json = {
							schemas = require("schemastore").json.schemas(),
							validate = { enable = true },
						},
					},
				},

				yamlls = {
					settings = {
						yaml = {
							schemaStore = {
								enable = false,
								url = "",
							},
							schemas = require("schemastore").yaml.schemas(),
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

			vim.list_extend(ensure_installed, servers_to_install)
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			local lspconfig = require("lspconfig")

			for name, config in pairs(servers) do
				if config == true then
					config = {}
				end
				config = vim.tbl_deep_extend("force", {}, {
					capabilities = capabilities,
				}, config)

				lspconfig[name].setup(config)
			end

			local disable_semantic_tokens = {
				lua = true,
			}

			-- Autoformatting Setup
			require("conform").setup({
				-- add formatters for each language
				formatters_by_ft = {
					lua = { "stylua" },
					javascript = { "prettier" },
					javascriptreact = { "prettier" },
					typescript = { "prettier" },
					typescriptreact = { "prettier" },
				},
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local bufnr = args.buf
					local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

					local map = function(mode, keys, func)
						vim.keymap.set(mode, keys, func, { buffer = args.buf })
					end

					vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
					map("n", "gd", vim.lsp.buf.definition)
					map("n", "gI", vim.lsp.buf.implementation)
					map("n", "gr", vim.lsp.buf.references)
					map("n", "gD", vim.lsp.buf.declaration)
					map("n", "gT", vim.lsp.buf.type_definition)
					map("n", "K", vim.lsp.buf.hover)

					map("n", "<C-k>", vim.lsp.buf.signature_help)
					map("i", "<C-k>", vim.lsp.buf.signature_help)

					map("n", "<space>rn", vim.lsp.buf.rename)
					map("n", "<space>ca", vim.lsp.buf.code_action)
					map("n", "<leader>e", function()
						vim.diagnostic.open_float()
					end)
					map("n", "<leader>f", function()
						require("conform").format({ async = true, lsp_fallback = true })
					end)

					local filetype = vim.bo[bufnr].filetype
					if disable_semantic_tokens[filetype] then
						client.server_capabilities.semanticTokensProvider = nil
					end

					-- The following autocommand is used to enable inlay hints in your
					-- code, if the language server you are using supports them
					--
					-- This may be unwanted, since they displace some of your code
					if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
						map("n", "<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
						end)
					end
				end,
			})
		end,
	},
}
