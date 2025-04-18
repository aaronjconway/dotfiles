vim.cmd([[
  augroup help_autocmd
    autocmd!
    autocmd BufEnter */doc/* if &filetype == 'man' | wincmd T | endif
  augroup END
]])

vim.api.nvim_buf_set_keymap(0, 'n', 'q', ':q<CR>', {})
