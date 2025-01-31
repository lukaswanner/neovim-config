return {
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		config = function()
			local function truncate_branch_name(branch)
				if not branch or branch == "" then
					return ""
				end

				return branch
			end

			local function split(inputstr, sep)
				if sep == nil then
					sep = "%s"
				end
				local t = {}
				for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
					table.insert(t, str)
				end
				return t
			end

			--- returns me the file name with max depth 1 -> parentdir/filename
			---@param filename string string the current path / filename
			---@return string truncated string
			local function truncate_path(filename)
				local a = split(filename, "/")
				local final_str = ""
				for _, line in ipairs(a) do
					if string.len(line) >= 5 then
						final_str = final_str .. "/" .. string.sub(line, 1, 5)
					else
						final_str = final_str .. "/" .. line
					end
				end
				return final_str
			end

			local branch = {
				"branch",
				icon = "",
				fmt = truncate_branch_name,
			}

			local diagnostics = {
				"diagnostics",
				sections = { "warn", "error" },
				colored = true,
				symbols = { error = " ", warn = " " },
				always_visible = true,
			}

			local filename = {
				"filename",
				path = 2,
				fmt = truncate_path,
			}

			local filetype = {
				"filetype",
			}

			local mode_map = {
				["NORMAL"] = "N",
				["O-PENDING"] = "N?",
				["INSERT"] = "I",
				["VISUAL"] = "V",
				["V-BLOCK"] = "V-B",
				["V-LINE"] = "V-L",
				["V-REPLACE"] = "V-R",
				["REPLACE"] = "R",
				["COMMAND"] = "!",
				["SHELL"] = "SH",
				["TERMINAL"] = "T",
				["EX"] = "X",
				["S-BLOCK"] = "S-B",
				["S-LINE"] = "S-L",
				["SELECT"] = "S",
				["CONFIRM"] = "Y?",
				["MORE"] = "M",
			}

			require("lualine").setup({
				options = {
					theme = "auto",
					globalstatus = true,
					section_separators = "",
					component_separators = "󰇙",
				},
				sections = {
					lualine_a = {
						{
							"mode",
							fmt = function(s)
								return mode_map[s] or s
							end,
						},
					},
					lualine_b = { branch },
					lualine_c = { filename },
					lualine_x = { diagnostics, filetype },
				},
			})
		end,
	},
}
