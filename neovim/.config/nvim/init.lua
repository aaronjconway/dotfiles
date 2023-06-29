vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require('core.options')
require('core.keymaps')
require('core.plugins')

vim.cmd.colorscheme('vscode')
vim.cmd('autocmd FileType help wincmd T')
vim.cmd('autocmd FileType man wincmd T')
