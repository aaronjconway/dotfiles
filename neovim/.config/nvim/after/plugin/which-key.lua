-- make sick bindings
local status, wk = pcall(require, 'which-key')
if not status then print('problem with which key') end

wk.setup()

wk.add( {
    { "<leader>Q", ":qa!<CR>", desc = "Quit so Hard" },
    { "<leader>W", ":wq!<CR>", desc = "save nice" },
    { "<leader>e", ":Texplore<CR>", desc = "Ntree" },
    { "<leader>m", ":Mason<CR>", desc = "Mason" },
    { "<leader>ss", ":source<CR>", desc = "Source" },
    { "<leader>t", ":TroubleToggle<Cr>", desc = "Toggle Trouble" },
    { "<leader>w", ":w<CR>", desc = "save nice" },
   })

wk.add({
    { "<leader>", group = "VISUAL <leader>", mode = "v" },
    { "<leader>h", desc = "Git [H]unk", mode = "v" },
 })


wk.add({
    { "<leader>d", group = "Database" },
    { "<leader>do", ":DBUIToggle<CR>", desc = "Toggle DBUI" },
    { "<leader>t", group = "Tabs & Buffer" },
    { "<leader>to", ":botright vsp new<CR>", desc = "Open a buffer" },
  })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz")
