return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("codecompanion").setup({
			strategies = {
				chat = {
					adapter = "copilot", -- Use GitHub Copilot for chat interactions
				},
				inline = {
					adapter = "copilot", -- Use GitHub Copilot for inline suggestions
				},
			},
			-- If needed, you can also override adapter defaults:
			adapters = {
				copilot = function()
					return require("codecompanion.adapters").extend("copilot", {
						-- You can add Copilot-specific options here, such as model settings
					})
				end,
			},
		})
	end,
}
