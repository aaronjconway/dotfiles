vim.o.hlsearch = false
vim.o.formatoptions = 'cr'
vim.o.wrap = true
vim.o.textwidth = 80
vim.o.tw = 80
vim.o.colorcolumn = "80"
vim.o.linebreak = true
vim.o.hidden = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.number = true
vim.wo.relativenumber = true
vim.o.mouse = 'a'
vim.o.clipboard = 'unnamedplus'
vim.o.breakindent = true
vim.o.smartindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.swapfile = false
vim.o.backup = false
vim.o.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.o.undofile = true

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 250

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'
vim.o.termguicolors = true

-- Set cursor to block in normal mode and beam in insert mode
vim.o.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50"

vim.o.scrolloff = 8
vim.o.signcolumn = "yes"
vim.opt.isfname:append("@,48-57,/,.,-,_,+,,,#,$,%,{,},[,],@-@,!,~,=")
