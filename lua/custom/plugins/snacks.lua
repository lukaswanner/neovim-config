return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	config = function()
		local opts = {
			bigfile = { enabled = true },
			indent = { enabled = true, animate = { enabled = false } },
			notifier = { enabled = true },
			quickfile = { enabled = true },
		}
		require("snacks").setup(opts)
	end,
}
