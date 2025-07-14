-- Search
vim.o.hlsearch = false
vim.o.ignorecase = true
vim.o.smartcase = true

-- Indentation
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.breakindent = true

-- Display
vim.o.wrap = true
vim.o.linebreak = true
vim.o.colorcolumn = "80"
vim.o.number = true

-- Text formatting
vim.o.textwidth = 80
vim.o.formatoptions = "tcr" -- Enable auto-wrap (t), continue comments (c), auto-remove comment leader on Enter (r)

-- Files
vim.o.swapfile = false
vim.o.backup = false
vim.o.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.o.undofile = true
vim.o.hidden = true

-- Clipboard & Mouse
vim.o.clipboard = "unnamedplus"
vim.o.mouse = "a"

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
vim.opt.iskeyword:remove("_")
