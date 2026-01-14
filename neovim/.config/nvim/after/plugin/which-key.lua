local status, wk = pcall(require, 'which-key')
if not status then print('problem with which key') end

wk.setup()

wk.add({
    { "<leader>Q",  ":qa!<CR>",                 desc = "Quit so Hard" },
    { "<leader>q",  ":qa!<CR>",                 desc = "Quit so Hard" },
    { "<leader>W",  ":wq!<CR>",                 desc = "save nice" },
    { "<leader>e",  ":Texplore<CR>",            desc = "Ntree" },
    { "<leader>m",  ":Mason<CR>",               desc = "Mason" },
    { "<leader>ss", ":source<CR>",              desc = "Source" },
    { "<leader>t",  ":Trouble diagnostics<Cr>", desc = "Toggle Trouble" },
    { "<leader>w",  ":w<CR>",                   desc = "save nice" },

    { "<leader>g",  ":tab Git<CR>",             desc = "open Git" },

    { "<leader>d",  group = "Database" },
    { "<leader>do", ":DBUIToggle<CR>",          desc = "Toggle DBUI" },

    { "<leader>t",  group = "Tabs & Buffer" },
    { "<leader>to", ":botright vsp new<CR>",    desc = "Open a buffer" },
    --diagnostics
    { "gd",         vim.lsp.buf.definition,     desc = "go to definition" },
    { "gD",         vim.lsp.buf.declaration,    desc = "go to declaration" },
    { "gi",         vim.lsp.buf.implementation, desc = "go to declaration" },
    { "gi",         vim.lsp.buf.references, desc = "go to declaration" },

})


-- Diagnostic keymaps
vim.keymap.set('n', '[d',
    function()
        vim.diagnostic.jump({ float = true, count = 1 })
    end,
    { desc = 'jump to previous diagnostic' })

vim.keymap.set('n', ']d',
    function()
        vim.diagnostic.jump({ float = true, count = -1 })
    end,
    { desc = 'jump to next diagnostic' })

vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz")
