--remove any other autocmd's with
vim.cmd("autocmd!")

vim.wo.fillchars = 'eob: '
vim.wo.signcolumn = 'yes'

vim.o.mouse = 'a'

--not sure why need
vim.o.termguicolors = true

--netrw/ntree
vim.g.netrw_liststyle = 3


--good undo
vim.opt.undofile = true

vim.opt.cursorline = true

vim.opt.winblend = 0
vim.opt.wildoptions = 'pum'
vim.opt.pumblend = 5

-- line number
vim.wo.number = true
vim.wo.relativenumber = true

vim.opt.title = true

--copies indent from previous line when making a new one
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.o.completeopt = 'menuone,noselect'
vim.opt.hlsearch = true

vim.opt.showcmd = true

vim.opt.cmdheight = 1
vim.opt.laststatus = 2
vim.opt.expandtab = true

vim.opt.scrolloff = 10
vim.opt.shell = 'fish'
vim.opt.inccommand = 'split'
vim.opt.ignorecase = true
vim.opt.smarttab = true

vim.opt.breakindent = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.wrap = true
vim.opt.linebreak = true

--update times
vim.opt.updatetime = 200
vim.opt.timeout = true
vim.opt.timeoutlen = 250


--clipboard
vim.opt.clipboard:prepend { 'unnamed', 'unnamedplus' }

-- Add asterisks in block comments
vim.opt.formatoptions:append { 'r' }
