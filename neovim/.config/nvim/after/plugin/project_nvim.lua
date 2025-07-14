local status, project = pcall(require, 'project_nvim')
if (not status) then
  error('-----------------Error with project_nvim ------------')
  return
end

project.setup({})
