require("conform").setup({
  formatters_by_ft = {
    templ = { 'templ' },
    html = { 'prettier', lsp_format = 'fallback' },
    toml = { 'toml', lsp_format = 'fallback' },
    go = { "goimports", "gofmt" },
    zsh = { "beautysh", lsp_format = "fallback" },
    sh = { "beautysh", lsp_format = "fallback" },
    fish = { "beautysh", lsp_format = "fallback" },
  },
  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_format = "fallback",
  },
})
