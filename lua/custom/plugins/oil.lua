return {

	"stevearc/oil.nvim",

	---@module 'oil'
	---@type oil.SetupOpts
	opts = {},
	-- Optional dependencies
	dependencies = { { "nvim-tree/nvim-web-devicons" } },
	config = function()
		require("oil").setup({
			view_options = {
				show_hidden = true,
			},
			columns = {
				"icon",
				"permissions",
			},
		})

		-- Open parent directory in current window
		vim.keymap.set("n", "-", "<CMD>Oil<CR>")

		-- Open parent directory in floating window
		vim.keymap.set("n", "<space>-", require("oil").toggle_float)
	end,
}
