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
			terminal = { enabled = true },
		}
		require("snacks").setup(opts)

		vim.keymap.set("n", "<leader>p", function()
			require("snacks").words.jump(-1, true)
		end)

		vim.keymap.set("n", "<leader>n", function()
			require("snacks").words.jump(1, true)
		end)

		vim.keymap.set("n", "<leader>to", function()
			-- if i ever need a specific command i can post this here instead of nil, example would be ls
			require("snacks").terminal.toggle(nil, { win = { position = "float" } })
		end)
	end,
}
