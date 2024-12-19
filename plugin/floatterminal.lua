-- State to track the floating terminal
local state = {
	floating = {
		buf = -1,
		win = -1,
	},
}

-- Function to open a floating window
local function open_floating_window(opts)
	local ui = vim.api.nvim_list_uis()[1] -- Get UI dimensions

	local width = math.floor(ui.width * 0.8) -- 80% of screen width
	local height = math.floor(ui.height * 0.8) -- 80% of screen height

	local col = math.floor((ui.width - width) / 2) -- Center column
	local row = math.floor((ui.height - height) / 2) -- Center row

	-- Window win_config
	local win_config = {
		relative = "editor",
		width = width,
		height = height,
		col = col,
		row = row,
		style = "minimal",
		border = "rounded", -- Optional: "single", "double", "rounded", "solid", etc.
	}

	-- Create a new buffer
	local buf = nil
	if vim.api.nvim_buf_is_valid(opts.buf) then
		buf = opts.buf
	else
		buf = vim.api.nvim_create_buf(false, true)
	end

	-- Open the floating window
	local win = vim.api.nvim_open_win(buf, true, win_config)

	return { buf = buf, win = win }
end

-- Toggle the floating terminal
local toggle_terminal = function()
	if not vim.api.nvim_win_is_valid(state.floating.win) then
		state.floating = open_floating_window({ buf = state.floating.buf })
		if vim.bo[state.floating.buf].buftype ~= "terminal" then
			vim.cmd.terminal()
		end
	else
		vim.api.nvim_win_hide(state.floating.win)
	end
end

-- Kill the floating terminal
local kill_terminal = function()
	if vim.api.nvim_buf_is_valid(state.floating.buf) then
		if vim.api.nvim_win_is_valid(state.floating.win) then
			vim.api.nvim_win_hide(state.floating.win)
		end
		vim.api.nvim_buf_delete(state.floating.buf, { force = true })
	end
end

-- Ensure toggle and kill functions are available
vim.api.nvim_create_user_command("Floatterminal", toggle_terminal, {})

vim.api.nvim_create_user_command("Floatterminalkill", kill_terminal, {})

vim.keymap.set({ "n" }, "<space>tt", "<cmd>Floatterminal<CR>")
vim.keymap.set({ "n" }, "<space>tk", "<cmd>Floatterminalkill<CR>")
