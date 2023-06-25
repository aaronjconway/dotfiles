local status, whichkey = pcall(require, 'which-key')
if not status then print('problem with which key') end

whichkey.setup(
)
