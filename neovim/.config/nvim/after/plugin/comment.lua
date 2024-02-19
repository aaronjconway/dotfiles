local status, comment = pcall(require, "Comment")
if (not status) then return end

comment.setup({

  toggler = {
    line = '<C-_>',
  },
  opleader = {
    line = '<C-_>',
  }


})



--see :h fo-table for why these letters are set.
--c,r allow ading comment lines on enter action whne in  insert
--but not on "o" new line



vim.o.formatoptions = 'cr'
