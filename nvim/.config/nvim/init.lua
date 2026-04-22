-- Leader key
local map = vim.keymap.set

map('n', '<Space>', '<Nop>', { silent = true })
vim.g.mapleader = ' '

-- Basic UI
vim.o.number = true

local opt = vim.opt

-- Window behavior
vim.wo.wrap = true
vim.wo.linebreak = true

--Netrw behaviour
--open in split
vim.g.netrw_browse_split = 3
vim.g.netrw_i = 3

-- Indentation / formatting
opt.breakindent = true
opt.formatoptions:remove 'o'
opt.textwidth = 80
opt.commentstring = '//%s'
opt.expandtab = true -- use spaces instead of tabs
opt.shiftwidth = 2 -- indent size
opt.tabstop = 2 -- tab display width
opt.softtabstop = 2 -- insert/delete width
opt.smartindent = true -- smarter auto-indenting
opt.autoindent = true -- copy indent from current line

--- Timing
opt.updatetime = 200
opt.timeout = true
opt.timeoutlen = 500
opt.ttimeout = true
opt.ttimeoutlen = 0

-- Folding
opt.foldenable = false
opt.foldmethod = 'manual'
opt.foldlevelstart = 99

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false

-- Splits
opt.splitright = true
opt.splitbelow = true

-- Buffers / editing
opt.hidden = true
opt.confirm = false
opt.swapfile = false
opt.backup = false
opt.undofile = true

-- Clipboard / input
opt.clipboard = 'unnamedplus'
opt.mouse = 'a'

-- UI
opt.termguicolors = true
opt.colorcolumn = '80'
opt.signcolumn = 'yes'
opt.scrolloff = 2
opt.listchars = 'tab:^ ,nbsp:¬,extends:»,precedes:«,trail:•'
opt.statusline = "%{fnamemodify(expand('%:p'), ':~')}"

-- Completion / wildmenu
opt.completeopt = 'menuone,noselect,fuzzy'
opt.wildignorecase = true

---- // i think this is needed for svelte
---- vim.opt.isfname:append("@,48-57,/,.,-,_,+,,,#,$,%,{,},[,],@-@,!,~,=")
---- vim.opt.iskeyword:remove("_")

-- add templ file config
vim.filetype.add { extension = { templ = 'templ' } }

function R(name)
  require('plenary.reload').reload_module(name)
end

vim.api.nvim_create_user_command('LspInfo', function()
  vim.cmd 'checkhealth vim.lsp'
end, {})

vim.api.nvim_create_user_command('TSListAvailable', function()
  local available = require('nvim-treesitter').get_available()
  for _, v in ipairs(available) do
    print(v)
  end
end, {})

vim.api.nvim_create_autocmd('TextYankPost', {
  pattern = '*',
  command = 'silent! lua vim.highlight.on_yank({ timeout = 200 })',
})

--remove trailing whitespace for each line
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  pattern = '*',
  command = [[%s/\s\+$//e]],
})

vim.api.nvim_create_autocmd('User', {
  pattern = 'TelescopePreviewerLoaded',
  callback = function()
    vim.wo.wrap = true
    vim.wo.linebreak = true
    vim.wo.breakindent = true
  end,
})

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
---@diagnostic disable-next-line: undefined-field
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  }
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require('lazy').setup({
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        bash = { 'beautysh' },
        go = { 'goimports' },
        html = { 'prettierd' },
        markdown = { 'prettierd' },
        lua = { 'lsp' },
        sh = { 'beautysh' },
        sql = { 'pg_format' },
        templ = { 'templ' },
        zsh = { 'beautysh' },
        js = { 'lsp' },
      },
      format_on_save = function()
        return { timeout_ms = 1200, lsp_fallback = true }
      end,
    },
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
      require('nvim-autopairs').setup()
    end,
  },

  --tpope
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  'tpope/vim-surround',
  'tpope/vim-commentary',
  {
    'mason-org/mason-lspconfig.nvim',
    opts = {},
    dependencies = {
      { 'mason-org/mason.nvim', opts = {} },
      'neovim/nvim-lspconfig',
    },
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'rafamadriz/friendly-snippets',
    },
    config = function()
      local luasnip = require 'luasnip'
      require('luasnip.loaders.from_vscode').lazy_load()
      luasnip.config.setup {}

      local cmp = require 'cmp'

      local cmp_autopairs = require 'nvim-autopairs.completion.cmp'

      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

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
        -- testing
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
        sources = cmp.config.sources {
          { name = 'nvim_lsp' },
          { name = 'buffer' },
          { name = 'path' },
          { name = 'luasnip', option = { show_autosnippets = true } },
          -- { name = 'cmdline' },
        },
      }
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  {
    'nvim-telescope/telescope.nvim',
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
  },
}, {
  performance = {
    rtp = {
      disabled_plugins = {
        'gzip',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
})

vim.lsp.config.lua_ls = {
  settings = {
    Lua = {
      telemetry = { enable = false },
      runtime = {
        version = 'LuaJIT',
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        globals = { 'vim' },
        disable = { 'missing-fields' },
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.fn.expand '$VIMRUNTIME/lua',
          vim.fn.stdpath 'config' .. '/lua',
        },
      },
    },
  },
}

require('telescope').setup {
  defaults = {
    layout_config = {
      horizontal = {
        preview_width = 0.5,
      },
    },
    vimgrep_arguments = {
      'rg',
      '--hidden',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
    },
    mappings = {
      n = {
        ['q'] = require('telescope.actions').close,
      },
      i = {
        ['<Esc>'] = require('telescope.actions').close,
      },
    },
  },
  extensions = {
    fzf = {},
    wrap_results = true,
  },
}

local glob_pattern = {
  -- VCS folders
  '!.git/**',
  '!.svn/**',
  '!.hg/**',

  -- Node / JS / package manager
  '!node_modules/**',
  '!pnpm-lock.yaml',
  '!package-lock.json',
  '!yarn.lock',

  -- Build / output
  '!dist/**',
  '!build/**',
  '!out/**',
  '!coverage/**',

  -- Python / cache
  '!__pycache__/**',
  '!*.pyc',
  '!*.pyo',

  -- OS / editor files
  '!.DS_Store',
  '!.vscode/**',
  '!.idea/**',
  '!*.swp',
  '!*.swo',
  '!*.tmp',

  -- Logs / locks
  '!*.log',
  '!*.lock',

  -- Misc
  '!.obsidian/**',
  '!*.bak',
  '!*.cache',

  -- Golang files
  '!go.mod',
  '!go.sum',
}

local function grep()
  require('telescope.builtin').live_grep {
    glob_pattern = glob_pattern,
  }
end

local function find_files()
  require('telescope.builtin').find_files {
    hidden = true,
  }
end

local function grep_all()
  require('telescope.builtin').live_grep()
end

-- Search group (leader s)
map('n', '<leader>sg', grep, { desc = 'Grep' })
map('n', '<leader>sG', grep_all, { desc = 'Grep All' })
map('n', '<leader>sf', find_files, { desc = 'Find Files' })
map('n', '<leader>so', '<cmd>Telescope oldfiles<cr>', { desc = 'Old Files' })
map('n', '<leader>sb', '<cmd>Telescope buffers<cr>', { desc = 'Buffers' })
map('n', '<leader>st', '<cmd>Telescope<cr>', { desc = 'Telescope' })
map('n', '<leader>sc', '<cmd>Telescope commands<cr>', { desc = 'Commands' })
map('n', '<leader>sh', function()
  require('telescope.builtin').help_tags()
end, { desc = 'Help Tags' })
map('n', '<leader>sk', '<cmd>Telescope keymaps<cr>', { desc = 'Keymaps' })
map('n', '<leader>sp', '<cmd>Telescope projects<cr>', { desc = 'Projects' })
map('n', '<leader>sr', '<cmd>Telescope resume<cr>', { desc = 'Resume' })

map('n', '<leader>/', function()
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })
map('n', '<leader>w', ':w<CR>', { desc = 'save nice' })
map('n', '<leader>q', ':q!<CR>', { desc = 'quit' })
map('n', '<leader>g', ':tab Git<CR>', { desc = 'open Git' })
map('n', '<leader>to', ':botright vsp new<CR>', { desc = 'Open a buffer' })

-- LSP
map('n', 'gd', vim.lsp.buf.definition, { desc = 'go to definition' })
map('n', 'gD', vim.lsp.buf.declaration, { desc = 'go to declaration' })
map('n', 'gi', vim.lsp.buf.implementation, { desc = 'go to implementation' })
map('n', 'gr', vim.lsp.buf.references, { desc = 'go to references' })

-- Diagnostic keymaps
map('n', '[d', function()
  vim.diagnostic.jump { float = true, count = 1 }
end, { desc = 'jump to previous diagnostic' })

map('n', ']d', function()
  vim.diagnostic.jump { float = true, count = -1 }
end, { desc = 'jump to next diagnostic' })

--remap for tmux send c-i vs tab
map('n', '<C-i>', '<C-i>', { silent = true, noremap = true })
map('v', 'J', ":m '>+1<CR>gv=gv")
map('v', 'K', ":m '<-2<CR>gv=gv")
map('n', 'J', 'mzJ`z')
map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')
map('n', '<C-o>', '<C-o>zz')
map('n', '<C-i>', '<C-i>zz<CR>')
map('n', '<s-g>', '<s-g>zz')

-- maps backspace and c-H in insert to delete word
-- have to do this since tmux and normal shell I think send different keys
map('i', '<C-BS>', '<C-W>')
map('i', '<C-H>', '<C-W>')
map('c', '<C-H>', '<C-W>')
map('n', '<C-l>', '<C-w>w')
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
-- Select (charwise) the contents of the current line, excluding indentation.
map('n', 'vv', '^vg_')
map('i', 'kj', '<ESC>l')

vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    if vim.bo[args.buf].filetype == 'help' or vim.bo[args.buf].buftype == 'help' then
      vim.cmd 'wincmd T'
    end
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    if vim.bo[args.buf].filetype == 'man' or vim.bo[args.buf].buftype == 'man' then
      vim.cmd 'wincmd T'
    end
  end,
})

local ts = require 'nvim-treesitter'

local available = ts.get_available()
local available_set = {}
for _, lang in ipairs(available) do
  available_set[lang] = true
end

vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    local ft = vim.bo[args.buf].filetype

    if not available_set[ft] then
      return
    end

    ts.install(ft)

    vim.schedule(function()
      if vim.api.nvim_buf_is_valid(args.buf) then
        vim.treesitter.start(args.buf)
      end
    end)
  end,
})
