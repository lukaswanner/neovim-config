function ColorMyPencils(color)
	color = color or "tokyonight"
	vim.cmd.colorscheme(color)

	-- set bg to terminal bg color
	-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

	-- set line number
	vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#9ECE6A" })
end

return {
	{
		"folke/tokyonight.nvim",
		name = "tokyonight",
		config = function()
			require("tokyonight").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
				transparent = false, -- Enable this to disable setting the background color
				terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
				styles = {
					-- Style to be applied to different syntax groups
					-- Value is any valid attr-list value for `:help nvim_set_hl`
					comments = { italic = true },
					keywords = { italic = true },
					-- Background styles. Can be "dark", "transparent" or "normal"
					sidebars = "dark", -- style for sidebars, see below
					floats = "dark", -- style for floating windows
				},
			})
		end,
	},

	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({
				variant = "dawn",
				disable_background = false,
			})

			vim.cmd("colorscheme rose-pine")

			ColorMyPencils()
		end,
	},
}
