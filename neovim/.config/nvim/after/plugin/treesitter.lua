local status, configs = pcall(require, 'nvim-treesitter.configs')
if (not status) then
  error('-----------------Error with Treesitter ------------')
  return
end

configs.setup({
  auto_install = true,
  ignore_install = {},
  modules = {},
  ensure_installed = {
    "c",
    "lua",
    "bash",
    "vim",
    "vimdoc",
    "query",
    "elixir",
    "heex",
    "javascript",
    "html"
  },
  sync_install = false,
  highlight = { enable = true },
  indent = { enable = true },
})
