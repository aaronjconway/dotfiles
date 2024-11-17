local M = {}

-- Function to find the project root based on the presence of a .git directory
M.find_project_root = function()
  local path = vim.fn.expand('%:p:h') -- Start from the current file's directory
  while path ~= "/" do
    -- Check if .git exists in the current directory
    if vim.fn.isdirectory(path .. '/.git') == 1 then
      return path
    end
    -- Move up one level
    path = vim.fn.fnamemodify(path, ':h')
  end
  return nil -- No .git directory found
end

return M
