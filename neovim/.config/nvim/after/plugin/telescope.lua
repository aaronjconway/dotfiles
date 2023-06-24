local actions = require('telescope.actions')

require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
        ['<ESC>'] = actions.close,
      },
    },
  },
}
pcall(require('telescope').load_extension, 'fzf')


vim.keymap.set('n', '<leader>sf',
  function()
    require('telescope.builtin').find_files({ hidden = 'true' })
  end,
  { desc = 'old files' })

vim.keymap.set('n', '<leader>sr', require('telescope.builtin').oldfiles, { desc = 'old files' })

--use lua func with hidden opt on live grep
vim.keymap.set('n', '<leader>sg',

  function()
    require('telescope.builtin').live_grep({ hidden = true })
  end,

  --opts
  { desc = 'live grep' }
)

vim.keymap.set('n', '<leader>sb', require('telescope.builtin').buffers, { desc = 'search buffers' })
vim.keymap.set('n', '<leader>st', ':Telescope<CR>', { desc = 'Telescope' })
