--test config
-----------------------------------------------------
local lsp = require('lsp-zero').preset({})
local lspconfig = require('lspconfig')

lsp.on_attach(function(_, bufnr)
  lsp.default_keymaps({ buffer = bufnr })
  local opts = { buffer = bufnr, remap = false }

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)

  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)

  vim.keymap.set("n", "<leader>ldf", function() vim.diagnostic.open_float() end, opts)

  vim.keymap.set("n", "<C-j>", function() vim.diagnostic.goto_next() end, opts)

  vim.keymap.set("n", "<leader>lca", function() vim.lsp.buf.code_action() end, opts)

  vim.keymap.set("n", "<leader>lrf", function() vim.lsp.buf.references() end, opts)

  vim.keymap.set("n", "<leader>lrn", function() vim.lsp.buf.rename() end, opts)

  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

lsp.format_on_save({
  format_opts = {
    async = true,
    timeout_ms = 10000,
  },
  servers = {
    ['lua_ls'] = { 'lua' },
    ['tsserver'] = { 'javascript', 'typescript' },
    ['bashls'] = { 'bash', 'shell', 'zsh' },
    -- ['null-ls'] = { 'javascript', 'typescript' },
  }
})


lspconfig.tsserver.setup({})
lspconfig.bashls.setup({})
lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
    },
  },
})

lsp.setup()

--make sure to call null AFTER lsp.setup()
local null_ls = require('null-ls')
null_ls.setup({
  sources = {
    --null_ls.builtins.formatting.prettierd,
    null_ls.builtins.diagnostics.eslint_d,
  }
})
