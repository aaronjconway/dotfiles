require('conform').setup {
  formatters_by_ft = {
    lua = { 'luals' },
    sql = { 'pg_format' },
  },
  format_on_save = function()
    return { timeout_ms = 1200, lsp_fallback = true }
  end,
}
