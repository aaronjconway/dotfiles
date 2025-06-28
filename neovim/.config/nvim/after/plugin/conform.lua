require("conform").setup({
  formatters_by_ft = {
    templ = { 'templ' },
    -- html = { 'prettier', lsp_format = 'fallback' },
    html = { 'html', lsp_format = 'fallback' },
    yaml = { 'yaml', lsp_format = 'fallback' },
    toml = { 'taplo', lsp_format = 'fallback' },
    go = { "goimports", "gofmt" },
    zsh = { "bashls" },
    scss = { 'beans', lsp_format = 'fallback' },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_format = "fallback",
    lsp_fallback = true
  },
})
