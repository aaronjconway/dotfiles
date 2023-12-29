-- make sick bindings
local status, wk = pcall(require, 'which-key')
if not status then print('problem with which key') end

wk.setup()

wk.register(
  {
    q = { ":q<CR>", 'Quit Nicely' },
    Q = { ":qa!<CR>", 'Quit so Hard' },
    w = { ":w<CR>", 'save nice' },
    W = { ":wq!<CR>", 'save nice' },
    e = { ":Ntree<CR>", 'Ntree' },

    --have to do double since telescope uses s
    ss = { ":source<CR>", 'Source' },
    m = { ":Mason<CR>", 'Mason' },
  },
  { prefix = '<leader>' }
)

-- document existing key chains
require('which-key').register {
  ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
  ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
  ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
  ['<leader>h'] = { name = 'Git [H]unk', _ = 'which_key_ignore' },
  ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
  ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
  ['<leader>t'] = { name = '[T]oggle', _ = 'which_key_ignore' },
  ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
}
-- register which-key VISUAL mode
-- required for visual <leader>hs (hunk stage) to work
require('which-key').register({
  ['<leader>'] = { name = 'VISUAL <leader>' },
  ['<leader>h'] = { 'Git [H]unk' },
}, { mode = 'v' })
