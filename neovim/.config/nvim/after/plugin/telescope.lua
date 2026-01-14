local wk = require('which-key')
require('telescope').setup {
  defaults = {
    layout_config = {
      horizontal = {
        preview_width = .5
      }
    },
    file_ignore_patterns = {},
    vimgrep_arguments = {
      'rg',
      '--hidden',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
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

local glob_pattern = {
  -- VCS folders
  "!.git/**",
  "!.svn/**",
  "!.hg/**",

  -- Node / JS / package manager
  "!node_modules/**",
  "!pnpm-lock.yaml",
  "!package-lock.json",
  "!yarn.lock",

  -- Build / output
  "!dist/**",
  "!build/**",
  "!out/**",
  "!coverage/**",

  -- Python / cache
  "!__pycache__/**",
  "!*.pyc",
  "!*.pyo",

  -- OS / editor files
  "!.DS_Store",
  "!.vscode/**",
  "!.idea/**",
  "!*.swp",
  "!*.swo",
  "!*.tmp",

  -- Logs / locks
  "!*.log",
  "!*.lock",

  -- Misc
  "!.obsidian/**",
  "!*.bak",
  "!*.cache",

  -- Golang files
  "!go.mod",
  "!go.sum",
}

local function grep()
  require('telescope.builtin').live_grep({
    glob_pattern = glob_pattern
  })
end

local function find_files()
  require('telescope.builtin').find_files({
    glob_pattern = glob_pattern
  })
end

local function grep_all()
  require('telescope.builtin').live_grep()
end

wk.add({
  { "<leader>s",  group = "Search" },
  { "<leader>sg", grep,                       desc = "Grep" },
  { "<leader>sG", grep_all,                   desc = "Grep All" },
  { "<leader>sf", find_files,                 desc = "Find Files" },
  { "<leader>so", ":Telescope oldfiles<CR>",  desc = "Old Files" },
  { "<leader>sb", ":Telescope buffers<CR>",   desc = "Buffers" },
  { "<leader>st", ":Telescope<CR>",           desc = "Telescope" },
  { "<leader>sc", ":Telescope commands<CR>",  desc = "Commands" },
  { "<leader>sh", ":Telescope help_tags<CR>", desc = "Help Tags" },
  { "<leader>sk", ":Telescope keymaps<CR>",   desc = "Keymaps" },
  { "<leader>sp", ":Telescope projects<CR>",  desc = "Projects" },
  { "<leader>sr", ":Telescope resume<CR>",    desc = "Resume" },

  {
    '<leader>/',
    function()
      require("telescope.builtin").current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        previewer = false,
      })
    end,
    desc = '[/] Fuzzily search in current buffer'
  }
})
