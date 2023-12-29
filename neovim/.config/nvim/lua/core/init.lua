-- my custom auto commands
--
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local yank_group = augroup('HighlightYank', {})

autocmd('TextYankPost', {
  group = yank_group,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({
      higroup = 'Cursor',
      timeout = 100
    })
  end
})


-- Define an autocmd for BufEnter event
vim.cmd [[
      autocmd TermOpen * startinsert
]]

vim.api.nvim_create_user_command('Yayterm', function()
  print('this is a custom command')
end, {})
