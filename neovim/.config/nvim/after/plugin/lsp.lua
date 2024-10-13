local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(_, bufnr)
  local nmap = function(keys, func, desc)
    -- add lsp to lsp thigns
    if desc then
      desc = 'LSP: ' .. desc
    end
    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
  nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

  vim.api.nvim_create_autocmd('BufWritePre', {
    buffer = bufnr,
    callback = function()
      vim.lsp.buf.format {
        async = false,
      }
    end
  })
end)

-- Setup neovim lua configuration
require('neodev').setup()

require('mason').setup({})
require('mason-lspconfig').setup({
  handlers = {
    lsp_zero.default_setup,
    --lua
    lua_ls = function()
      require('lspconfig').lua_ls.setup({
        settings = {
          Lua = {
            -- Disable telemetry
            telemetry = { enable = false },
            runtime = {
              -- Tell the language server which version of Lua you're using
              -- (most likely LuaJIT in the case of Neovim)
              version = 'LuaJIT',
              path = runtime_path,
            },
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = { 'vim' }
            },
            workspace = {
              checkThirdParty = false,
              library = {
                -- Make the server aware of Neovim runtime files
                vim.fn.expand('$VIMRUNTIME/lua'),
                vim.fn.stdpath('config') .. '/lua'
              }
            }
          }
        }
      })
    end,
    ------------Typescript---------------
    tsserver = function()
      require('lspconfig').tsserver.setup {
      }
    end,
    ------------Astro--------------------
    astro = function()
      require('lspconfig').astro.setup({
        file_types = { 'mdx', 'md' }
      })
    end,
    ------------Rust--------------------
    rust_analyzer = function()
      require('lspconfig').rust_analyzer.setup({})
    end,
    ------------Svelte---------------
    svelte = function()
      require('lspconfig').svelte.setup {}
    end,
    ------------HTML---------------
    html = function()
      require('lspconfig').html.setup {}
    end,
    ------------HTMX---------------
    htmx = function()
      require('lspconfig').htmx.setup {}
    end,
    ------------Marksman---------------
    marksman = function()
      require('lspconfig').marksman.setup {
        file_types = { '.mdx', '.md' }
      }
    end,
    ------------MDX---------------
    mdx_analyzer = function()
      require('lspconfig').mdx_analyzer.setup({
        file_types = { '.mdx', '.md' }
      })
    end,
  },
})

local cmp = require('cmp')
-- local cmp_action = require('lsp-zero').cmp_action()

local cmp_autopairs = require('nvim-autopairs.completion.cmp')

local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()

luasnip.config.setup {}

cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  completion = {
    completeopt = 'menu,menuone,noinsert,noselect',
  },
  -- stop preselecting things
  preselect = cmp.PreselectMode.None,
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },

  sources = {
    { name = 'buffer' },
    { name = 'cmdLine' },
    { name = 'luasnip',              option = { show_autosnippets = true } },
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'vim-dadbod-completion' },
  },
}
