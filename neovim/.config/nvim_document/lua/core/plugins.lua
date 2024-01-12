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
  -------------------------------

  { 'folke/zen-mode.nvim' },
  { 'neovim/nvim-lspconfig' },
  { 'MunifTanjim/prettier.nvim' },
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    keys = { { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" } },
  },
  { 'mofiqul/vscode.nvim' },

  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup {
        show_hidden = true
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
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
      { "williamboman/mason.nvim", --[[ opts = true ]] },
      { "williamboman/mason-lspconfig.nvim", --[[ opts = true ]] },
    },
    opts = {
      ensure_installed = {
        "marksman",  -- LSP for python
        "remark_ls", -- LSP for python
      },
    },
  },

  {
    'neovim/nvim-lspconfig',
    dependencies = {

      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',

      { 'j-hui/fidget.nvim',       opts = {} },

      'folke/neodev.nvim',
    },
  },

  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-cmdLine',

      'rafamadriz/friendly-snippets',
    },
  },

  { 'folke/which-key.nvim',     opts = {} },
  { 'nvim-lualine/lualine.nvim' },

  -- {
  --   -- Add indentation guides even on blank lines
  --   'lukas-reineke/indent-blankline.nvim',
  --   -- Enable `lukas-reineke/indent-blankline.nvim`
  --   -- See `:help ibl`
  --   main = 'ibl',
  --   opts = {},
  -- },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim',    opts = {} },

  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  },

  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
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
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },
}, {})
