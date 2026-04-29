local map = vim.keymap.set

map('n', '<Space>', '<Nop>', { silent = true })
vim.g.mapleader = ' '

-- Add custom filetype detection: treat *.templ files as 'templ'
vim.filetype.add { extension = { templ = 'templ' } }

-- netrw (built-in file explorer) behavior
vim.g.netrw_browse_split = 3 -- open files in a new tab
vim.g.netrw_i = 3 -- use tree-style listing

-- Indentation & tabs
vim.o.autoindent = true -- copy indent from current line
vim.o.smartindent = true -- smarter auto-indenting
vim.o.expandtab = true -- use spaces instead of tabs
vim.o.shiftwidth = 4 -- indentation width for >>, <<
vim.o.tabstop = 4 -- number of spaces a <Tab> counts for
vim.o.softtabstop = 2 -- spaces inserted/deleted when pressing Tab/BS

-- Backup / swap / undo
vim.o.backup = false -- disable backup files
vim.o.swapfile = false -- disable swap files
vim.o.undofile = true -- persistent undo history

-- UI / appearance
vim.o.termguicolors = true -- enable 24-bit colors
vim.o.colorcolumn = '80' -- highlight column at 80 chars
vim.o.signcolumn = 'yes' -- always show sign column
vim.o.number = true -- show absolute line numbers
vim.o.relativenumber = true -- show relative line numbers
vim.o.cursorline = false -- (not set, default off)
vim.o.wrap = true -- wrap long lines
vim.o.linebreak = true -- wrap at word boundaries
vim.wo.wrap = true -- window-local wrap (redundant but explicit)
vim.wo.linebreak = true -- window-local linebreak

-- Whitespace visualization
vim.o.listchars = 'tab:^ ,nbsp:¬,extends:»,precedes:«,trail:•'

-- Search behavior
vim.o.hlsearch = false -- don't highlight search matches
vim.o.ignorecase = true -- case-insensitive search by default
vim.o.smartcase = true -- case-sensitive if uppercase used

-- Command / completion UI
vim.o.inccommand = 'split' -- live preview of substitutions in split
vim.o.cot = '' -- shortmess for completion (effectively minimal)

-- Folding
vim.o.foldenable = false -- disable folding by default
vim.o.foldmethod = 'manual' -- manual folding method
vim.o.foldlevelstart = 99 -- open all folds on startup

-- Window splitting
vim.o.splitbelow = true -- horizontal splits go below
vim.o.splitright = true -- vertical splits go right

-- Scrolling
vim.o.scrolloff = 2 -- keep 2 lines visible above/below cursor

-- Mouse
vim.o.mouse = 'a' -- enable mouse in all modes

-- Clipboard
vim.o.clipboard = 'unnamedplus' -- use system clipboard

-- File handling
vim.o.hidden = true -- allow switching buffers without saving
vim.o.confirm = false -- no confirmation prompts
vim.o.autowrite = false

-- Formatting / text layout
vim.o.textwidth = 80 -- auto-wrap text at 80 chars
vim.o.breakindent = true -- preserve indentation in wrapped lines
vim.o.commentstring = '//%s' -- default comment format
vim.opt.formatoptions:remove 'o' -- don't continue comments with 'o' or 'O'

-- Timing / responsiveness
vim.o.timeout = true -- enable mapped sequence timeout
vim.o.timeoutlen = 500 -- time to wait for mapped sequence (ms)
vim.o.ttimeout = true -- key code timeout
vim.o.ttimeoutlen = 0 -- no delay for key codes
vim.o.updatetime = 200 -- faster CursorHold / swap updates

-- Messages / prompts
vim.o.more = false -- don't pause for long messages

-- Statusline / title
vim.o.statusline = "%{fnamemodify(expand('%:p'), ':~')}" -- show full path (~ for home)
vim.o.title = true -- enable terminal title
vim.o.titlestring = '%t%( %M%)%( (%{expand("%:~:h")})%)%a (nvim)' -- custom title

-- Search / completion behavior
vim.o.wildignorecase = true -- case-insensitive command-line completion

-- Misc
vim.o.incsearch = false -- (not set, default off)

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

vim.api.nvim_create_user_command('SpellCheckMode', function()
  vim.opt.spell = true
  vim.opt.spelllang = { 'en_us' }
  require('cmp').setup {
    sources = {
      {
        name = 'spell',
        option = {
          keep_all_entries = true,
          enable_in_context = function()
            return true
          end,
          preselect_correct_word = true,
        },
      },
    },
  }
end, {})

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
  { 'vim-scripts/loremipsum' },
  {
    'folke/lazydev.nvim',
    ft = 'lua',
  },
  {
    'Mofiqul/vscode.nvim',
    priority = 1000,
    lazy = false,
    config = function()
      require('vscode').setup {
        terminal_colors = true,
        italic_comments = true,
        italic_inlayhints = true,
        underline_links = true,
      }
      vim.cmd 'colorscheme vscode'
    end,
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        bash = { 'beautysh' },
        go = { 'goimports' },
        html = { 'prettierd' },
        js = { 'lsp' },
        lua = { 'lsp' },
        markdown = { 'prettierd' },
        sh = { 'beautysh' },
        sql = { 'pg_format' },
        templ = { 'templ' },
        zsh = { 'beautysh' },
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
      'f3fora/cmp-spell',
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
          completeopt = 'menuone,noselect,fuzzy,preview',
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
          { name = 'path' },
          { name = 'luasnip', option = { show_autosnippets = true } },
          { name = 'lazydev', group_index = 0 },
          -- { name = 'cmdline' },
          -- { name = 'buffer' },
          -- { name = 'spell' },
        },
      }
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
  },
  {
    'nvim-telescope/telescope.nvim',
    version = '*',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
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

-- roots I want to search for as the project root.
-- default to git otherwise
local roots = { '.luarc.json' }

local function grep()
  require('telescope.builtin').live_grep {
    glob_pattern = glob_pattern,
    cwd = vim.fs.root(0, { roots, '.git' }),
  }
end

local function find_files()
  require('telescope.builtin').find_files {
    hidden = true,
    cwd = vim.fs.root(0, { roots, '.git' }),
  }
end

-- Search group (leader s)
map('n', '<leader>sg', grep, { desc = 'Grep' })
map('n', '<leader>sf', find_files, { desc = 'Find Files' })
map('n', '<leader>so', '<cmd>Telescope oldfiles<cr>', { desc = 'Old Files' })
map('n', '<leader>st', '<cmd>Telescope<cr>', { desc = 'Telescope' })
map('n', '<leader>sh', function()
  require('telescope.builtin').help_tags()
end, { desc = 'Help Tags' })
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
    local buf = args.buf
    local ft = vim.bo[buf].filetype

    if not available_set[ft] then
      -- start it anyways
      pcall(vim.treesitter.start)
      return
    end

    ts.install(ft, { summary = true, auto_on = true })
    pcall(vim.treesitter.start)
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    vim.opt.formatoptions:remove { 'r', 'o' }
  end,
})
