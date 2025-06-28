require("core.options")
require("core.keymaps")
require("core.plugins")


vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

-- add templ file config
vim.filetype.add({ extension = { templ = "templ" } })

--make highlight prettier
vim.cmd.highlight('FlashLabel guifg=#FFC921')
vim.cmd.highlight('FlashBackDrop guifg=#bbbbbb')

local augroup = vim.api.nvim_create_augroup
local CoreGroup = augroup('Core', {})


local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

function R(name)
  require("plenary.reload").reload_module(name)
end

vim.api.nvim_create_autocmd("User", {
  pattern = "TelescopePreviewerLoaded",
  callback = function()
    vim.wo.wrap = true
  end,
})

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

vim.api.nvim_create_user_command('RemoveClassContents', function()
  vim.cmd [[%s,\vclass\=".*",class="",g]]
end, {})


vim.api.nvim_create_user_command('WrapText', function()
  vim.cmd [[normal! ggVGgq]]
end, {})

autocmd({ "BufLeave" }, {
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    local name = vim.api.nvim_buf_get_name(buf)
    local modified = vim.api.nvim_buf_get_option(buf, 'modified')

    if name == "" and modified then
      -- Optional: print a warning
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  end
})
