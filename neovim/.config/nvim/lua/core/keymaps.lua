local keymap = vim.keymap.set

-- local currentDir = vim.fn.expand('%:p:h')
-- print(currentDir)

--remap for tmux send c-i vs tab
keymap('n', '<C-i>', '<C-i>', { silent = true, noremap = true })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<C-o>", "<C-o>zz")
vim.keymap.set("n", "<C-i>", "<C-i>zz")
vim.keymap.set("n", "<s-g>", "<s-g>zz")

--swap windows
vim.keymap.set("n", "<C-l>", "<C-w>w")

--don't do anything on space
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

--leave insert quickly
vim.keymap.set('i', 'kj', "<ESC>l", { desc = "escap insert mode" })

-- Select (charwise) the contents of the current line, excluding indentation.
keymap("n", "vv", "^vg_")

-- Obfuscate
keymap("n", "<f3>", "mmggg?G`m")


