vim.g.mapleader = ' '
vim.g.mapocalleader = ' '

require('core.options')
require('core.keymaps')
require('core.plugins')
require('core')


-- colors
vim.cmd.colorscheme('vscode')
vim.cmd.highlight('FlashLabel guifg=#FFC921')

--open man and help in full page
vim.cmd('autocmd FileType help wincmd T')
vim.cmd('autocmd FileType man wincmd T')
