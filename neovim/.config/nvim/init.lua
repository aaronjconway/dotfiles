vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require('core')
require('core.options')
require('core.keymaps')
require('core.plugins')

vim.cmd.highlight('FlashLabel guifg=#FFC921')

--open man and help in full page
-- vim.cmd('autocmd FileType help wincmd T')
vim.cmd('autocmd FileType man wincmd T')

local autocmd = vim.api.nvim_create_autocmd

autocmd({ "BufWritePre" }, {
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
