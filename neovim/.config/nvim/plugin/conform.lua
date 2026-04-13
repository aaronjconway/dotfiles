require('conform').setup {
  formatters_by_ft = {
    lua = { 'lua_ls' },
    zsh = { 'beautysh' },
    bash = { 'beautysh' },
    sh = { 'beautysh' },
    sql = { 'lsp' },
    go = { 'goimports' },
    templ = { 'templ' },
    markdown = { 'prettierd' },
    html = { 'prettierd' }
  },
  format_on_save = function()
    return { timeout_ms = 1200, lsp_fallback = true }
  end,
}
