require("config.options")
require("config.keymaps")
require("config.plugins")

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

vim.api.nvim_create_autocmd("User", {
  pattern = "TelescopePreviewerLoaded",
  callback = function()
    vim.wo.wrap = true
  end,
})

-- Function to check if a file exists
local function file_exists(path)
  local f = io.open(path, "r")
  if f then
    f:close()
    return true
  end
  return false
end

-- Function to find a file recursively upwards
local function find_file_upwards(filenames, start_dir)
  local dir = start_dir or vim.fn.getcwd()
  while dir do
    for _, name in ipairs(filenames) do
      local path = dir .. "/" .. name
      if file_exists(path) then
        return dir
      end
    end
    local parent = dir:match("^(.*)/[^/]+$")
    if not parent or parent == dir then
      break
    end
    dir = parent
  end
  return nil
end

-- Function to set working directory based on found file
local function set_working_dir(filenames)
  local dir = find_file_upwards(filenames)
  if dir then
    vim.cmd("cd " .. dir)
    print("Working directory set to: " .. dir)
  else
    print("No matching file found in parent directories.")
  end
end

-- Example usage
set_working_dir({ ".git", ".luarc.json" })
