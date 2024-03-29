local actions = require('telescope.actions')
local wk = require('which-key')

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'neoclip')

require('telescope').setup {

  defaults = {
    -- default grep args
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--glob',
      '!/dist'

    },
    file_ignore_patterns = { "node_modules", '.git' },
    path_display = {
      absolute = false,
    },
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
      f = { ":Telescope find_files hidden=true<CR>", 'find files' },
      h = { ":Telescope help_tags<CR>", 'help tags' },
      k = { ":Telescope keymaps<CR>", 'keymaps' },
      o = { ":Telescope oldfiles hidden=true<CR>", 'old files' },
      p = { ":Telescope projects<CR>", 'projects' },
      t = { ":Telescope<CR>", 'Telescope' },
      g = { ":Telescope live_grep<CR>", 'grep' },
      b = { ":Telescope buffers<CR>", 'buffers' },
      c = { ":Telescope commands<CR>", 'commands' },
      r = { ":Telescope resume<CR>", 'resume the last search' },
    }
  },
  { prefix = '<leader>' }
)


vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    prompt_title = 'Fuzzy Search File',
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })


--grep everything
vim.keymap.set('n', '<leader>sG', function()
  require('telescope').setup {
    defaults = {
      vimgrep_arguments = {
        'rg',
        '--color=never',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
        '--smart-case',
        '-uuu',
      },
      file_ignore_patterns = {},
    }
  }

  require('telescope.builtin').live_grep({
    prompt_title = 'Unhinged Grep',
  })
end
)
