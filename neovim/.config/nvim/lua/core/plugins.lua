local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  { 'stevearc/conform.nvim',  opts = {}, },
  { 'stevearc/oil.nvim',      opts = {}, },
  { 'junegunn/vim-easy-align' },
  { 'vim-scripts/loremipsum' },
  { 'folke/which-key.nvim',   opts = {} },
  { 'folke/neodev.nvim' },
  { 'EdenEast/nightfox.nvim' },
  {
    'davidmh/mdx.nvim',
    config = true,
    dependencies = { 'nvim-treesitter/nvim-treesitter' }
  },
  { 'windwp/nvim-autopairs',  event = 'InsertEnter', opts = {} },
  { 'ahmedkhalf/project.nvim' },

  --tpope
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  'tpope/vim-sleuth',
  'tpope/vim-surround',

  -- Useful status updates for LSP
  { 'j-hui/fidget.nvim',           opts = {} },
  {
    'mason-org/mason-lspconfig.nvim',
    opts = {},
    dependencies = {
      { 'mason-org/mason.nvim', opts = {} },
      'neovim/nvim-lspconfig',
    },
  },
  { 'saadparwaiz1/cmp_luasnip' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-path' },
  { 'hrsh7th/nvim-cmp' },
  { 'L3MON4D3/LuaSnip' },
  { 'rafamadriz/friendly-snippets' },

  -- 'gc' to comment visual regions/lines
  { 'numToStr/Comment.nvim',       opts = {} },

  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
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
  { 'nvim-treesitter/nvim-treesitter',            branch = 'master', lazy = false, build = ':TSUpdate' },
  { 'nvim-treesitter/nvim-treesitter-textobjects' },
}, {})
