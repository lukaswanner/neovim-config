return {
  "nvim-telescope/telescope.nvim",

  tag = "0.1.5",

  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      -- NOTE: If you are having trouble with this installation,
      --       refer to the README for telescope-fzf-native for more instructions.
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
  },

  config = function()
    local actions = require('telescope.actions')

    require('telescope').setup({
      defaults = {
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
          },
        }
      }
    })

    pcall(require('telescope').load_extension, 'fzf')
    local builtin = require('telescope.builtin')

    vim.keymap.set('n', '<leader>D', builtin.lsp_type_definitions)
    vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
    vim.keymap.set('n', '<C-p>', builtin.git_files, {})
    vim.keymap.set('n', '<leader>pw', builtin.grep_string)

    vim.keymap.set('n', '<leader>ps', function()
      builtin.grep_string({ search = vim.fn.input("Grep > ") })
    end)
    vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
  end
}
