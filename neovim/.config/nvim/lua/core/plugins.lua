local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
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
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  ----------------------------------------------------------------------------
  { 'folke/todo-comments.nvim' },
  { 'norcalli/nvim-colorizer.lua' },
  { 'stevearc/conform.nvim' },
  { 'vim-scripts/loremipsum' },
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
      { 'tpope/vim-dadbod',                     lazy = true },
      { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql', 'sqlite' }, lazy = true },
    },
    cmd = {
      'DBUI',
      'DBUIToggle',
      'DBUIAddConnection',
      'DBUIFindBuffer',
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },
  { 'MunifTanjim/prettier.nvim' },
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    keys = { { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" } },
  },
  --vscode
  { 'mofiqul/vscode.nvim' },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    requires = {
      { 'nvim-lua/plenary.nvim' }
    },
  },

  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      position = 'right',

    }
  },
  { "Vimjas/vim-python-pep8-indent" },
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {}
  },
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup {
        show_hidden = true,
        patterns = { 'README.md', '.git' },
      }
    end
  },
  {
    "AckslD/nvim-neoclip.lua",
    dependencies = {
      { 'nvim-telescope/telescope.nvim' },
    },
    config = function()
      require('neoclip').setup()
    end,
  },

  --tpope
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  'tpope/vim-sleuth',
  'tpope/vim-surround',

  -- make lua config easier
  -- Useful status updates for LSP
  { 'j-hui/fidget.nvim',                opts = {} },

  -- Additional lua configuration, makes nvim stuff amazing!
  { 'folke/neodev.nvim' },

  --lsp
  { 'williamboman/mason.nvim' },
  { 'williamboman/mason-lspconfig.nvim' },
  { 'VonHeikemen/lsp-zero.nvim',        branch = 'v3.x' },
  { 'neovim/nvim-lspconfig' },
  { 'saadparwaiz1/cmp_luasnip' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-path' },
  { 'hrsh7th/nvim-cmp' },
  { 'L3MON4D3/LuaSnip' },
  { 'rafamadriz/friendly-snippets' },

  --which key
  { 'folke/which-key.nvim',             opts = {} },

  -- idk whta tthis is
  { 'nvim-lualine/lualine.nvim' },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim',            opts = {} },

  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed. idk whta tthis is
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    'theHamsta/nvim-treesitter-pairs',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },
}, {})
