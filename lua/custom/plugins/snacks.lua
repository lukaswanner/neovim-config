return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	config = function()
		local opts = {
			bigfile = { enabled = true },
			indent = { enabled = true },
			notifier = { enabled = true },
			quickfile = { enabled = true },
			words = { enabled = true, notify_jump = true },
		}
		require("snacks").setup(opts)

		vim.keymap.set("n", "<leader>p", function()
			require("snacks").words.jump(-1, true)
		end)

		vim.keymap.set("n", "<leader>n", function()
			require("snacks").words.jump(1, true)
		end)
	end,
}
