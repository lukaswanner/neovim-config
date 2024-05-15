return {
    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",

        config = function()
            local gitsigns = require('gitsigns')
            gitsigns.setup({
                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns

                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Actions
                    map('n', '<leader>ph', gs.preview_hunk)
                    map('n', '<leader>bl', function() gs.blame_line { full = true } end)
                    map('n', '<leader>tb', gs.toggle_current_line_blame)
                end
            })
        end,
    },
}

