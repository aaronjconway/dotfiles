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

  -- --this is so cool
  -- vim.diagnostic.config({
  --   virtual_text = {
  --     format =
  --         function(diagnostic)
  --             return string.format('[' .. client.name .. ']' .. " %s", diagnostic.message)
  --         end
  --   }
  -- })

  wk.register(
    {
      l = {
        name = 'LSP',
        --{command, name}
        l = { ':LspInfo<CR>', 'Lsp Info' },
        t = { function()
          if vim.diagnostic.is_disabled() then
            vim.diagnostic.enable()
            print('Diagnostics Enabled')
          else
            vim.diagnostic.disable()
            print('Diagnostics Disabled')
          end
        end, 'Disable Diagnostics' },
        d = { function() vim.lsp.buf.definition() end, 'Definition' },
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
    ['tsserver'] = { 'javascript', 'typescript' },
    ['null_ls'] = { 'javascript', 'typescript', 'jsx', 'tsx', 'astro' },
    ['bashls'] = { 'bash', 'shell', 'zsh' },
    ['marksman'] = { 'markdown' },
    ['astro'] = { 'astro' },
  }
})


lspconfig.tsserver.setup({})
lspconfig.tailwindcss.setup({})
lspconfig.astro.setup({})
lspconfig.marksman.setup({})

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

--make sure to call null AFTER lsp.setup()
local null_ls = require('null-ls')

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.diagnostics.eslint.with({
      diagnostics_format = '[eslint] #{m}\n(#{c})'
    })
  }
})
