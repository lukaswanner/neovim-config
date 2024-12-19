return {
	"kawre/leetcode.nvim",
	build = ":TSUpdate html", -- if you have `nvim-treesitter` installed
	branch = "dev",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		-- "ibhagwan/fzf-lua",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},
	opts = {
		-- configuration goes here
	},
}
