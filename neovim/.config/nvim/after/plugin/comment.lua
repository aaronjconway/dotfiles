local status, comment = pcall(require, "Comment")
if (not status) then return end

comment.setup({

  toggler = {
    line = '<C-/>',
  },
  opleader = {
    line = '<C-/>',
  }
})

ft = require('Comment.ft')
ft.set('mdx', "{/*%s*/}")
ft.set('markdown', "{/*%s*/}")

--see :h fo-table for why these letters are set.
--c,r allow ading comment lines on enter action whne in  insert
--but not on "o" new line

vim.o.formatoptions = 'cr'
