local actions = require('telescope.actions')
local wk = require('which-key')
require('telescope').setup {
  defaults = {
    file_ignore_patterns = { "node_modules" },
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
        ['<ESC>'] = actions.close,
      },
    },
  },
}

wk.register(
  {
    s = {
      name = 'Search',
      o = { ":Telescope find_files<CR>", 'find files' },
      F = { ":Telescope find_files hidden=true<CR>", 'find files' },
      f = { ":Telescope oldfiles hidden=true<CR>", 'old files' },
      p = { ":Telescope projects<CR>", 'projects' },
      t = { ":Telescope<CR>", 'Telescope' },
      g = { ":Telescope live_grep hidden=true<CR>", 'grep' },
      b = { ":Telescope buffers<CR>", 'buffers' },
      c = { ":Telescope commands<CR>", 'commands' },
    }
  },
  { prefix = '<leader>' }
)
