local opt = vim.opt
local wo = vim.wo
local g = vim.g
local env = vim.env

opt.guicursor = ""
opt.termguicolors = true

-- numbers
opt.number = true
opt.relativenumber = true

-- tab settings
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

-- undo settings
opt.undofile = true

-- search settings
opt.hlsearch = false
opt.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

opt.termguicolors = true
opt.scrolloff = 10
opt.signcolumn = "yes"
opt.colorcolumn = "120"

-- to get a cursorline + current line number
opt.cursorline = true
opt.cursorlineopt = "number,line"

-- preview substitutions live (:s)
opt.inccommand = "split"
-- split settings
-- opt.splitbelow = true
-- opt.splitright = true

-- Decrease update time
opt.updatetime = 250

-- Don't show the mode since we have it in lualine anyways
opt.showmode = false

-- enable break indent so broken lines have the same indention level
wo.wrap = true
wo.linebreak = true
opt.breakindent = true

-- remove stuff from terminal
vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
	callback = function()
		opt.number = false
		opt.relativenumber = false
	end,
})

-- enable osc52 clipboard support
g.clipboard = {
	name = "OSC 52",
	copy = {
		["+"] = require("vim.ui.clipboard.osc52").copy("+"),
		["*"] = require("vim.ui.clipboard.osc52").copy("*"),
	},
	paste = {
		["+"] = require("vim.ui.clipboard.osc52").paste("+"),
		["*"] = require("vim.ui.clipboard.osc52").paste("*"),
	},
}

if env.TMUX ~= nil then
	local copy = { "tmux", "load-buffer", "-w", "-" }
	local paste = { "bash", "-c", "tmux refresh-client -l && sleep 0.05 && tmux save-buffer -" }
	g.clipboard = {
		name = "tmux",
		copy = {
			["+"] = copy,
			["*"] = copy,
		},
		paste = {
			["+"] = paste,
			["*"] = paste,
		},
		cache_enabled = 0,
	}
end
