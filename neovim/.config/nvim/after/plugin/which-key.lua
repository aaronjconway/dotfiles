-- make sick bindings
local status, wk = pcall(require, 'which-key')
if not status then print('problem with which key') end

wk.setup()

-- -- takes the content of the current bufer and outputs in another.
-- local handleClose = function()
--   local bufnr = vim.fn.bufnr("%")
--
--   local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
--   local newbuff = vim.api.nvim_create_buf(false, true)
--
--   vim.api.nvim_buf_set_lines(newbuff, 0, -1, false, lines)
--   vim.api.nvim_command('vsp')
--
--   vim.api.nvim_win_set_buf(0, newbuff)
-- end

-- takes the content of the current bufer and outputs in another.
local handleClose = function()
  if vim.fn.expand('%:t') == 'new' or '' then
    vim.cmd('silent q')
  else
    local success, error = pcall(vim.cmd, 'bdelete')
    if not success then
      print('Error occured: ', error)
    end
  end
end

wk.register(
  {
    --todo: make this better
    -- q = { ":bdelete<CR>", 'Quit Nicely' },
    q = { function()
      handleClose()
    end, 'Quit Nicely' },

    Q = { ":qa!<CR>", 'Quit so Hard' },
    w = { ":w<CR>", 'save nice' },
    W = { ":wq!<CR>", 'save nice' },
    e = { ":Texplore<CR>", 'Ntree' },
    t = { ":TroubleToggle<Cr>", 'Toggle Trouble' },

    --have to do double since telescope uses s: then don't do this dummy
    ss = { ":source<CR>", 'Source' },
    m = { ":Mason<CR>", 'Mason' },
  },
  { prefix = '<leader>' }
)

-- register which-key VISUAL mode
-- required for visual <leader>hs (hunk stage) to work
wk.register({
  ['<leader>'] = { name = 'VISUAL <leader>' },
  ['<leader>h'] = { 'Git [H]unk' },
}, { mode = 'v' })


wk.register(
  {
    t = {
      name = 'Tabs & Buffer',
      o = { ":botright vsp new<CR>", 'Open a buffer' },
    },
    d = {
      name = 'Database',
      o = { ":DBUIToggle<CR>", 'Toggle DBUI' },
    }

  },
  { prefix = '<leader>' }
)

--TODO: why are there multiple key maps  [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })


-- you can't do this because you use c-n and c-p for navigating other stuff.
-- vim.keymap.set('n', '<C-n>', vim.cmd['cnext'], { desc = 'go to next in quickfix' })
-- vim.keymap.set('n', '<C-p>', vim.cmd['cprevious'], { desc = 'go to next in quickfix' })
-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz")
