-- Autoformatting Setup
require("conform").setup({
	-- add formatters for each language
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { "prettier" },
		javascriptreact = { "prettier" },
		typescript = { "prettier" },
		typescriptreact = { "prettier" },
		sql = { "pg_format" },
	},

	formatters = {
		pg_format = {
			command = "pg_format",
			args = { "-" },
			stdin = true,
		},
	},
})

vim.keymap.set("n", "<leader>f", function()
	require("conform").format({ async = true, lsp_fallback = true })
end, { buffer = 0 })
