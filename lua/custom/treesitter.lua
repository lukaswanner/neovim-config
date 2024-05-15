-- local treesitter = require "nvim-treesitter"

local M = {}

M.setup = function()
	local group = vim.api.nvim_create_augroup("custom-treesitter", { clear = true })

	require("nvim-treesitter").setup()

	-- can add local languages here
	local syntax_on = {}

	vim.api.nvim_create_autocmd("FileType", {
		group = group,
		callback = function(args)
			local bufnr = args.buf
			local ft = vim.bo[bufnr].filetype
			pcall(vim.treesitter.start)

			if syntax_on[ft] then
				vim.bo[bufnr].syntax = "on"
			end
		end,
	})

	vim.api.nvim_create_autocmd("User", {
		pattern = "TSUpdate",
		callback = function()
			local parsers = require("nvim-treesitter.parsers")

			parsers.lua = {
				tier = 0,

				---@diagnostic disable-next-line: missing-fields
				install_info = {
					url = "https://github.com/vrischmann/tree-sitter-templ.git",
					files = { "src/parser.c", "src/scanner.c" },
					branch = "master",
				},
			}
		end,
	})
end

M.setup()

return M
