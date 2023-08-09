--lsp
-----------------------------------------------------
local wk = require('which-key')
local lsp = require('lsp-zero').preset({})
local lspconfig = require('lspconfig')


lsp.ensure_installed({
  'tsserver',
  'html',
  'lua_ls',
})

lsp.on_attach(function(_, bufnr)
  lsp.default_keymaps({ buffer = bufnr })

  wk.register(
    {
      l = {
        name = 'LSP',
        l = { ':LspInfo<CR>', 'Lsp Info' },

        -- enable or disable diagnostics
        t = { function()
          if vim.diagnostic.is_disabled() then
            vim.diagnostic.enable()
            print('Diagnostics Enabled')
          else
            vim.diagnostic.disable()
            print('Diagnostics Disabled')
          end
        end, 'Disable Diagnostics' },

        d = { function() vim.lsp.buf.definition() end, 'definition' },
        h = { function() vim.lsp.buf.hover() end, 'Hover' },
        j = { function() vim.diagnostic.goto_next() end, 'Goto' },
        c = { function() vim.lsp.buf.code_action() end, 'Code Action' },
        r = { function() vim.lsp.buf.rename() end, 'Rename' },
        f = { function() vim.lsp.buf.references() end, 'References' },
        s = { function() vim.lsp.buf.signature_help() end, 'Signature Help' },
      }
    },
    { prefix = '<leader>' }
  )
end)

lsp.format_on_save({
  format_opts = {
    async = true,
    timeout_ms = 10000,
  },
  servers = {
    ['lua_ls'] = { 'lua' },
    ['cssls'] = { 'css' },
    ['tsserver'] = { 'javascript', 'typescript' },
    ['null_ls'] = { 'html', 'astro', 'javascript', 'typescript', 'jsx', 'tsx' },
    ['bashls'] = { 'bash', 'shell', 'zsh' },
    ['marksman'] = { 'markdown' },
    ['astro'] = { 'astro' },
    ['svelte'] = { 'svelte' },
    ['gopls'] = { 'go' },
  }
})


lspconfig.tsserver.setup({})
lspconfig.gopls.setup({})
lspconfig.astro.setup({})
lspconfig.tailwindcss.setup({})
lspconfig.marksman.setup({})
lspconfig.svelte.setup({})

lspconfig.cssls.setup({
  settings = {
    css = {
      validate = true,
      lint     = { unknownAtRules = "ignore" }
    },
    less = {
      validate = true,
      lint     = { unknownAtRules = "ignore" }
    },
    scss = {
      validate = true,
      lint     = { unknownAtRules = "ignore" }
    },
  }
}
)

lspconfig.html.setup({
  filetypes = { 'jsx', 'javascript', 'typescript', 'tsx', }
})

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

-- --make sure to call null AFTER lsp.setup()
-- local null_ls = require('null-ls')
--
-- null_ls.setup({
--   sources = {
--     null_ls.builtins.formatting.prettier,
--     null_ls.builtins.diagnostics.eslint.with({
--       diagnostics_format = '[eslint] #{m}\n(#{c})'
--     })
--   }
-- })
