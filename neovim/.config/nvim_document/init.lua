vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require('core')
require('core.options')
require('core.keymaps')
require('core.plugins')

vim.cmd.highlight('FlashLabel guifg=#FFC921')
vim.cmd.highlight('EndOfBuffer guifg=black ctermfg=black ctermbg=black')

vim.cmd('autocmd FileType man wincmd T')

local autocmd = vim.api.nvim_create_autocmd

vim.cmd([[
  augroup after_neovim_load
    autocmd!
    autocmd VimEnter * :ZenMode
  augroup END
]])

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0

vim.filetype.add({
  extension = {
    mdx = 'markdown.mdx'
  },
  filename = {},
  pattern = {},
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
