local wk = require('which-key')

require('telescope').setup {
  defaults = {
    file_ignore_patterns = {
      "package.json",
      "/.svelte-kit/*",
      "package-lock.json",
      "tsconfig.json",
      "public", "dist",
      "node_modules",
      "pnpm-lock.yaml",
      ".json",
      ".git",
      ".csv"
    },
    mappings = {
      n = {
        ["q"] = require("telescope.actions").close,
      },
      i = {
        ["<Esc>"] = require("telescope.actions").close,
      },
    },
  },
  extensions = {
    fzf = {},
    wrap_results = true,
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')


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
