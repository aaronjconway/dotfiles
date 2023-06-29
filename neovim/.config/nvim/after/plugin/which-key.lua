local status, wk = pcall(require, 'which-key')
if not status then print('problem with which key') end

wk.setup(
)

wk.register(
  {
    q = { ":q<CR>", 'Quit Nicely' },
    Q = { ":qa!<CR>", 'Quit Hard' },
    w = { ":w<CR>", 'save nice' },
    W = { ":wq!<CR>", 'save nice' },

    --have to do double since telescope uses s
    ss = { ":source<CR>", 'Source' },
    m = { ":Mason<CR>", 'Mason' },
  },
  { prefix = '<leader>' }
)
