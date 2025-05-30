--remap for tmux send c-i vs tab
vim.keymap.set('n', '<C-i>', '<C-i>', { silent = true, noremap = true })

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

--maps backspace and c-H in insert to delete word
-- have to do this since tmux and normal shell I think send different keys
vim.keymap.set("i", "<C-BS>", "<C-W>")
vim.keymap.set("i", "<C-H>", "<C-W>")
vim.keymap.set("c", "<C-H>", "<C-W>")

--swap windows
vim.keymap.set("n", "<C-l>", "<C-w>w")

--don't do anything on space
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

--leave insert quickly
vim.keymap.set('i', 'kj', "<ESC>l")
--leave visual quickly
vim.keymap.set('v', 'kj', "<ESC>")

-- Select (charwise) the contents of the current line, excluding indentation.
vim.keymap.set("n", "vv", "^vg_")

-- Obfuscate
vim.keymap.set("n", "<f3>", "mmggg?G`m")
