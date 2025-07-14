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

wk.add({
  { "<leader>sg", require('telescope.builtin').live_grep,  desc = "grep" },
  { "<leader>s",  group = "Search" },
  { "<leader>sf", ":Telescope find_files hidden=true<CR>", desc = "old files" },
  { "<leader>so", ":Telescope oldfiles<CR>",               desc = "old files" },
  { "<leader>sb", ":Telescope buffers<CR>",                desc = "buffers" },
  { "<leader>st", ":Telescope<CR>",                        desc = "Telescope" },
  { "<leader>sc", ":Telescope commands<CR>",               desc = "commands" },
  { "<leader>sh", ":Telescope help_tags<CR>",              desc = "help tags" },
  { "<leader>sk", ":Telescope keymaps<CR>",                desc = "keymaps" },
  { "<leader>sp", ":Telescope projects<CR>",               desc = "projects" },
  { "<leader>sr", ":Telescope resume<CR>",                 desc = "resume the last search" },

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


vim.api.nvim_create_autocmd("User", {
  pattern = "TelescopePreviewerLoaded",
  callback = function()
    vim.wo.wrap = true
  end,
})
