--lsp config
local lsp = require('lsp-zero').preset('recommended')

lsp.on_attach(function(_, bufnr)
  lsp.default_keymaps({ buffer = bufnr })
  local opts = { buffer = bufnr, remap = false }

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>df", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "<C-j>", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "<leader>lca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>lrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>lrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

lsp.format_on_save({
  format_opts = {
    async = false,
    timeout_ms = 10000,
  },
  servers = {
    ['lua_ls'] = { 'lua' },
    ['rust_analyzer'] = { 'rust' },
    ['bashls'] = { 'bash' },
    -- if you have a working setup with null-ls
    -- you can specify filetypes it can format.
    ['null-ls'] = { 'javascript', 'typescript' },
  }
})

-- --lua lsp setup
-- require('lspconfig').rust_analyzer.setup({
--   filetypes = { 'rust' },
--   settings = {
--     ['rust-analyzer'] = {
--       cargo = {
--         allFeatures = true,
--       },
--     },
--   }
-- })


--bash lsp setup
require('lspconfig').bashls.setup({
})

--lua lsp setup
require('lspconfig').lua_ls.setup({
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
    },
  },
})


local null_ls = require('null-ls')

null_ls.setup({
  sources = {
    -- Replace these with the tools you have installed
    -- make sure the source name is supported by null-ls
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.diagnostics.fish }
})

lsp.setup()
