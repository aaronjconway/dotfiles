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
  { 'stevearc/oil.nvim' },
  {
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  },
  --lsp help
  { 'jose-elias-alvarez/null-ls.nvim' },

  --misc
  { 'tpope/vim-surround' },
  { 'numToStr/Comment.nvim' },

  --lua help
  { "folke/neodev.nvim",              opts = {} },

  --dap
  { 'mfussenegger/nvim-dap' },
  { 'rcarriga/nvim-dap-ui' },
  { 'mxsdev/nvim-dap-vscode-js' },
  { 'theHamsta/nvim-dap-virtual-text' },
  {
    "microsoft/vscode-node-debug2",
    build = "npm install && NODE_OPTIONS=--no-experimental-fetch npm run build"
  },

  --rust
  { 'simrat39/rust-tools.nvim' },

  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {

      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/mason.nvim' },
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
  }, {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons', opt = true }
},
  { 'nvim-telescope/telescope-ui-select.nvim' },
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim',
      {
        "ahmedkhalf/project.nvim",
        opts = {},
        event = "VeryLazy",
        config = function(_, opts)
          require("project_nvim").setup(opts)
          require("telescope").load_extension("projects")
        end,
        keys = {
          { "<leader>sp", "<Cmd>Telescope projects<CR>", desc = "Projects" },
        },
      },
    }
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
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
  },
  {
    'windwp/nvim-autopairs',
  },
}, {
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
          "synmenu",
          "optwin",
          "compiler",
          "bugreport",
          "ftplugin",
        },
      },
    },
  },
})
