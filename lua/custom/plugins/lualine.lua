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

            local hide_in_width = function()
                return vim.fn.winwidth(0) > 80
            end


            --- returns me the file name with max depth 1 -> parentdir/filename
            ---@param filename string string the current path / filename
            ---@return string truncated string
            local function truncate_filename(filename)
                local start, _ = string.find(filename, ".([^/]+/[^/]+)$")
                if not start then
                    return filename
                end
                return string.sub(filename, start + 1)
            end

            local branch = {
                "branch",
                icon = "",
                fmt = truncate_branch_name,
            }

            local diff = {
                "diff",
                colored = true,
                diff_color = {
                    added = { fg = "#2DA44E" },
                    modified = { fg = "#A555C2" },
                    removed = { fg = "#FA4549" },
                },
                symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
                cond = hide_in_width,
            }

            local diagnostics = {
                "diagnostics",
                sections = { "warn", "error" },
                colored = true,
                symbols = { error = " ", warn = " " },
                always_visible = true,
            }

            local filename = {
                "filename", path = 1, fmt = truncate_filename
            }

            local filetype = {
                "filetype"
            }

            local location = {
                "location",
                padding = 1,
            }

            require("lualine").setup({
                options = {
                    theme = "auto",
                    globalstatus = true,
                    section_separators = "",
                    component_separators = "󰇙",
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { branch },
                    lualine_c = { filename },

                    lualine_x = { diff, diagnostics, filetype },
                    lualine_y = { location },
                    lualine_z = { "progress" },
                },
            })
        end,
    },
}

