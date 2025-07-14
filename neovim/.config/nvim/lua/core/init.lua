require("core.options")
require("core.keymaps")
require("core.plugins")

-- add templ file config
vim.filetype.add({ extension = { templ = "templ" } })

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

--remove trailing whitespace for each line
autocmd({ "BufWritePre" }, {
  group = CoreGroup,
  pattern = "*",
  command = [[%s/\s\+$//e]],
})
