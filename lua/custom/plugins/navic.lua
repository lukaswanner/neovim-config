return {
	"SmiteshP/nvim-navic",
	config = function()
		-- Setup nvim-navic
		require("nvim-navic").setup({
			highlight = true,
			separator = " > ",
			depth_limit = 5,
		})
	end,
}
