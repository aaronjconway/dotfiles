local keymap = vim.keymap.set

local currentDir = vim.fn.expand('%:p:h')
print(currentDir)

--create tab with input
function CreateTabWithInput()
  local input_text = vim.fn.input('Enter tab name: ')
  vim.cmd('tabnew ' .. input_text)
end

keymap('n', '<leader>e', ':Ntree ' .. currentDir .. '<CR>')
keymap('n', '<leader>q', ':q<CR>')
keymap('n', '<leader>w', ':w!<CR>')
keymap('n', '<leader>s', ':source<CR>')
keymap('n', '<leader>n', ':lua CreateTabWithInput()<CR>', { silent = true, noremap = true })
keymap('n', '<C-i>', '<C-i>', { silent = true, noremap = true })
keymap('n', '<leader>l', ':LspInfo<CR>', { silent = true, noremap = true })
keymap('n', '<leader>m', ':Mason<CR>', { silent = true, noremap = true })


vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")


--don't do anything on space
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })


vim.keymap.set('n', '<leader>Q', ":q<CR>", { desc = "quit file" })
vim.keymap.set('n', '<leader>w', ":w<CR>", { desc = "save file" })

--leave insert quickly
vim.keymap.set('i', 'kj', "<ESC>l", { desc = "escap insert mode" })
--comment
keymap('v', '<C-/>', 'gc', { silent = true, noremap = true })

--rust
keymap('n', '<leader>r', ':RustRun<CR>', { silent = true, noremap = true })

--debugger
keymap('n', '<F1>', ':DapContinue<CR>', { silent = true, noremap = true })

-- Select (charwise) the contents of the current line, excluding indentation.
keymap("n", "vv", "^vg_")

-- Obfuscate
keymap("n", "<f3>", "mmggg?G`m")
