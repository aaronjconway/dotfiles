

vim.cmd([[
  augroup help_autocmd
    autocmd!
    autocmd BufEnter */doc/* if &filetype == 'help' | wincmd T | endif
  augroup END
]])

vim.cmd [[echo "you're in a help file" ]]
vim.api.nvim_buf_set_keymap(0, 'n', 'q', ':q<CR>', {})
