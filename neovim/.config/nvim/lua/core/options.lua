-- Set highlight on search
vim.o.hlsearch = false

-- see :h fo-table for comment options
vim.o.formatoptions = 'cr'

-- wrapping and force wrap
vim.o.wrap = true
vim.o.textwidth = 80
vim.o.tw = 80
vim.o.colorcolumn = "81"

vim.o.linebreak = true

vim.o.hidden = true


vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true


-- line numbers
vim.opt.nu = true
vim.wo.relativenumber = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true
vim.o.smartindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 250

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'
vim.o.termguicolors = true

-- Set cursor to block in normal mode and beam in insert mode
vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50"

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
