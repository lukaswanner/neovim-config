return {

	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		-- adapters
		"nvim-neotest/neotest-go",
	},
	config = function()
		local neotest = require("neotest")

		---@diagnostic disable-next-line: missing-fields
		neotest.setup({
			-- your neotest config here
			adapters = {
				require("neotest-go"),
			},
		})

		vim.keymap.set("n", "<leader>tn", function()
			neotest.run.run()
		end, { desc = "Run nearest" })

		vim.keymap.set("n", "<leader>to", function()
			neotest.output.open({ enter = true, auto_close = true })
		end, { desc = "Open output panel" })

		vim.keymap.set("n", "<leader>ts", function()
			neotest.summary.toggle()
		end, { desc = "Toggle test summary" })
	end,
}
