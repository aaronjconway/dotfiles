local wk = require('which-key')
local utils = require('core.utils')
local project_root = utils.find_project_root()

require('telescope').setup {
  defaults = {
    file_ignore_patterns = {
      "package.json",
      "/.svelte-kit/*",
      "package-lock.json",
      "tsconfig.json",
      "public",
      "dist",
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

-- Enable proje
pcall(require('telescope').load_extension, 'projects')


local builtin = require 'telescope.builtin'
wk.add({
  { "<leader>s",  group = "Search" },
  { "<leader>sb", ":Telescope buffers<CR>",  desc = "buffers" },
  { "<leader>sc", ":Telescope commands<CR>", desc = "commands" },
  -- { "<leader>sf", ":Telescope find_files hidden=true<CR>", desc = "find files" },
  {
    "<leader>sf",
    function()
      builtin.find_files({
        cwd = project_root,
        hidden = true
      })
    end,
    desc = "find files"
  },
  { "<leader>sg", require "core.rip",                    desc = "grep" },
  { "<leader>sh", ":Telescope help_tags<CR>",            desc = "help tags" },
  { "<leader>sk", ":Telescope keymaps<CR>",              desc = "keymaps" },
  { "<leader>so", ":Telescope oldfiles hidden=true<CR>", desc = "old files" },
  { "<leader>sp", ":Telescope projects<CR>",             desc = "projects" },
  { "<leader>sr", ":Telescope resume<CR>",               desc = "resume the last search" },
  { "<leader>st", ":Telescope<CR>",                      desc = "Telescope" }
})



vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    prompt_title = 'Fuzzy Search File',
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })
