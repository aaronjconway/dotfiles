require("core.options")
require("core.keymaps")
require("core.plugins")


--make highlight prettier
vim.cmd.highlight('FlashLabel guifg=#FFC921')

local augroup = vim.api.nvim_create_augroup
local CoreGroup = augroup('Core', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

function R(name)
  require("plenary.reload").reload_module(name)
end

autocmd('TextYankPost', {
  group = yank_group,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({
      higroup = 'IncSearch',
      timeout = 100,
    })
  end,
})

autocmd({ "BufWritePre" }, {
  group = CoreGroup,
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

autocmd({ "BufEnter" }, {
  group = CoreGroup,
  pattern = "*",
  callback = function()
    if vim.bo.filetype == 'help' or vim.bo.filetype == 'man' or vim.bo.filetype == 'netrw' then
      vim.cmd [[wincmd T]]
      vim.api.nvim_buf_set_keymap(0, 'n', 'q', ':q<CR>', {})
    end
  end,
})


vim.filetype.add({
  extension = {
    mdx = 'markdown.mdx'
  },
  filename = {},
  pattern = {},
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
