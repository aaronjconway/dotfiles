local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

-- Auto-install lazy.nvim if not present
if not vim.loop.fs_stat(lazypath) then
  print('Installing lazy.nvim....')
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
  print('Done.')
end

vim.opt.rtp:prepend(lazypath)
require('lazy').setup({
  { 'Mofiqul/vscode.nvim' },
  { 'jose-elias-alvarez/null-ls.nvim' },
  { 'MunifTanjim/prettier.nvim' },
  { 'tpope/vim-surround' },
  { 'numToStr/Comment.nvim' },
  { "folke/neodev.nvim",              opts = {} },
  {
    'rcarriga/nvim-dap-ui',
    dependencies = { 'mfussenegger/nvim-dap' },
  },
  { 'simrat39/rust-tools.nvim' },
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {

      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      {
        'williamboman/mason.nvim',
        build = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      { 'williamboman/mason-lspconfig.nvim' },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },
      {
        'L3MON4D3/LuaSnip',
        dependencies = {
          { 'rafamadriz/friendly-snippets' },
        }
      },
      { 'saadparwaiz1/cmp_luasnip' },
    }
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', opt = true }
  },
  { 'akinsho/bufferline.nvim', version = "*" },
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },
  { "nvim-treesitter/playground" },
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {

      performance = {
        rtp = {
          disabled_plugins = {
            "2html_plugin",
            "tohtml",
            "getscript",
            "getscriptPlugin",
            "gzip",
            "logipat",
            "netrw",
            "netrwPlugin",
            "netrwSettings",
            "netrwFileHandlers",
            "matchit",
            "tar",
            "tarPlugin",
            "rrhelper",
            "spellfile_plugin",
            "vimball",
            "vimballPlugin",
            "zip",
            "zipPlugin",
            "tutor",
            "rplugin",
            "syntax",
            "synmenu",
            "optwin",
            "compiler",
            "bugreport",
            "ftplugin",
            "editorconfig",
          },
        },
      },
    }
  }
})
