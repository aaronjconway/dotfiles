-- make sick bindings
local status, wk = pcall(require, 'which-key')
if not status then print('problem with which key') end

wk.setup()

wk.register(
  {
    q = { ":bdelete<CR>", 'Quit Nicely' },
    Q = { ":qa!<CR>", 'Quit so Hard' },
    w = { ":w<CR>", 'save nice' },
    W = { ":wq!<CR>", 'save nice' },
    e = { ":Texplore<CR>", 'Ntree' },
    t = { ":TroubleToggle<Cr>", 'Toggle Trouble' },
    on = { ":bNext<CR>", 'Next buffer' },

    --have to do double since telescope uses s
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
    }
  },
  { prefix = '<leader>' }
)
