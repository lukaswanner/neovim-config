local opt = vim.opt
local wo = vim.wo

opt.guicursor = ""

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
