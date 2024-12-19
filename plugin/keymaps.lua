local set = vim.keymap.set

-- disable sapce to do stuff in normal mode
set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- lets me move stuff up and down
set("v", "J", ":m '>+1<CR>gv=gv")
set("v", "K", ":m '<-2<CR>gv=gv")

-- like normal j but with out dropping down
set("n", "J", "mzJ`z")

-- center screen after jumping
set("n", "<C-d>", "<C-d>zz")
set("n", "<C-u>", "<C-u>zz")
set("n", "n", "nzzzv")
set("n", "N", "Nzzzv")

-- next greatest remap ever : asbjornHaland
set({ "n", "v" }, "<leader>y", [["+y]])

-- This is going to get me cancelled
set("i", "<C-c>", "<Esc>")

set("n", "Q", "<nop>")
set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- rename word under cursor
set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Basic movement keybinds, these make navigating splits easy for me
set("n", "<C-j>", "<c-w><c-j>")
set("n", "<C-k>", "<c-w><c-k>")
set("n", "<C-l>", "<c-w><c-l>")
set("n", "<C-h>", "<c-w><c-h>")

-- Remap for dealing with word wrap
set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
set("v", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
set("v", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- execute lua
set("v", "<space>x", ":lua<CR>")

-- source file
set("n", "<space><space>x", "<cmd>source %<CR>")
