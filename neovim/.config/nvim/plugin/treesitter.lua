local status, configs = pcall(require, 'nvim-treesitter.configs')
if (not status) then
  error('-----------------Error with Treesitter ------------')
  return
end

vim.api.nvim_set_keymap('n', '<C-n>',
  [[:lua require'nvim-treesitter.textobjects.move'.goto_next_start('@function.outer')<CR>zz]],
  { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<C-p>',
  [[:lua require'nvim-treesitter.textobjects.move'.goto_previous_start('@function.outer')<CR>zz]],
  { noremap = true, silent = true })


configs.setup({
  auto_install = true,
  ignore_install = {},
  modules = {},
  ensure_installed = {
    "c",
    "lua",
    "bash",
    "vim",
    "vimdoc",
    "query",
    "elixir",
    "heex",
    "javascript",
    "html"
  },
  sync_install = false,
  indent = { enable = true },

  highlight = {
    enable = true, -- false will disable the whole extension
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<M-space>',
    },
  },
  textobjects = {
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ['<C-Down>'] = '@function.outer',
      },
      goto_previous_start = {
        ['<C-Up>'] = '@function.outer',
      },
    },
  },
})
