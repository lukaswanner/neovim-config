return {
	"nvim-telescope/telescope.nvim",

	tag = "0.1.6",

	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
	},

	config = function()
		require("custom.telescope")
	end,
}
