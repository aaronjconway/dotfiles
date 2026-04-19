local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
---@diagnostic disable-next-line: undefined-field
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require('lazy').setup({
	{ 'yegappan/taglist' },
	{ "ahmedkhalf/project.nvim" },
	{ 'stevearc/conform.nvim',  opts = {}, },
	{ 'junegunn/vim-easy-align' },
	{ 'vim-scripts/loremipsum' },

	{ 'folke/which-key.nvim',   opts = {} },
	{ 'folke/trouble.nvim' },
	{ 'folke/lazydev.nvim' },

	-- { 'EdenEast/nightfox.nvim' },
	{ 'windwp/nvim-autopairs',  event = 'InsertEnter', opts = {} },

	--tpope
	'tpope/vim-fugitive',
	'tpope/vim-rhubarb',
	'tpope/vim-sleuth',
	'tpope/vim-surround',
	'tpope/vim-vinegar',

	-- Useful status updates for LSP
	{ 'j-hui/fidget.nvim',           opts = {} },
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
	},
	{ 'L3MON4D3/LuaSnip' },
	{ 'saadparwaiz1/cmp_luasnip' },
	{ 'hrsh7th/cmp-nvim-lsp' },
	{ 'hrsh7th/cmp-buffer' },
	{ 'hrsh7th/cmp-path' },
	{ 'hrsh7th/cmp-cmdline' },
	{ 'rafamadriz/friendly-snippets' },
	{ 'hrsh7th/nvim-cmp' },

	-- -- 'gc' to comment visual regions/lines
	-- { 'numToStr/Comment.nvim',       opts = {} },

	{
		'nvim-telescope/telescope.nvim',
		-- event = 'VimEnter',
		branch = '0.1.x',
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
	{ 'nvim-treesitter/nvim-treesitter',            branch = 'master', lazy = false, build = ':TSUpdate' },
	{ 'nvim-treesitter/nvim-treesitter-textobjects' },
}, {
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				-- "netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},

})
