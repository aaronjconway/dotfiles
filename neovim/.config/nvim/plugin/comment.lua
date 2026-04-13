local status, comment = pcall(require, "Comment")
if (not status) then return end

comment.setup({

  -- this is for linux on alacritty
  -- for me, wsl2 through allacritty needed <C-/>
  --
  toggler = {
    line = '<C-_>',
  },
  opleader = {
    line = '<C-_>',
  }
})

local ft = require('Comment.ft')
ft.set('mdx', "{/*%s*/}")
ft.set('markdown', "{/*%s*/}")
