local actions = require("telescope.actions")

require("telescope").setup({
	extensions = {
		wrap_results = true,
		["ui-select"] = {
			require("telescope.themes").get_dropdown(),
		},
		fzf = {},
		smart_history = {},
	},
	defaults = {
		mappings = {
			i = {
				["<C-k>"] = actions.move_selection_previous,
				["<C-j>"] = actions.move_selection_next,
			},
		},
	},
})

pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "smart_history")
require("telescope").load_extension("ui-select")

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<space>ff", builtin.find_files)
vim.keymap.set("n", "<space>fa", function()
	builtin.find_files({ hidden = true, no_ignore = true })
end)
vim.keymap.set("n", "<space>fb", function()
	builtin.git_branches()
end)
vim.keymap.set("n", "<space>fh", builtin.help_tags)
vim.keymap.set("n", "<leader>fw", builtin.grep_string)
vim.keymap.set("n", "<space>/", function()
	builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end)

vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

vim.keymap.set("n", "<space>gw", builtin.grep_string)

vim.keymap.set("n", "<leader>fn", function()
	builtin.find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = "Search Neovim files" })

-- highlighting on yanks <3
local yank_group = vim.api.nvim_create_augroup("HighlightYank", {})
vim.api.nvim_create_autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 40,
		})
	end,
})
