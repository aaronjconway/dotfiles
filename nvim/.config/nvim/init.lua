vim.g.mapleader = " "
vim.o.autoindent = true
vim.o.smartindent = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.expandtab = false
vim.o.backup = false
vim.o.swapfile = false
vim.o.undofile = true
vim.o.signcolumn = "yes"
vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = true
vim.o.linebreak = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.termguicolors = true
vim.o.clipboard = "unnamedplus"
vim.o.textwidth = 80
vim.o.breakindent = true
vim.o.updatetime = 200
vim.o.wildignorecase = true
vim.o.splitright = true
vim.opt.shortmess:append("I")

vim.diagnostic.config({ virtual_text = true })

function R(name)
	require("plenary.reload").reload_module(name)
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
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

require("lazy").setup({
	{ "Mofiqul/vscode.nvim" },
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				html = { "prettierd" },
				markdown = { "prettierd" },
				go = { "goimports" },
				bash = { "beautysh" },
				sh = { "beautysh" },
				sql = { "pg_format" },
				zsh = { "beautysh" },
			},
			format_on_save = { timeout_ms = 500, lsp_fallback = true },
		},
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup()
		end,
	},

	--tpope
	"tpope/vim-fugitive",
	"tpope/vim-surround",
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"f3fora/cmp-spell",
			"hrsh7th/cmp-nvim-lsp",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"rafamadriz/friendly-snippets",
		},
		config = function()
			local luasnip = require("luasnip")
			require("luasnip.loaders.from_vscode").lazy_load()
			luasnip.config.setup({})

			local cmp = require("cmp")
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				preselect = cmp.PreselectMode.None,
				mapping = cmp.mapping.preset.insert({
					["<CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "path" },
					{ name = "luasnip", option = { show_autosnippets = true } },
				}),
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
	},
}, {})

require("telescope").setup({
	vimgrep_arguments = {
		"rg",
		"--hidden",
		"--color=never",
		"--no-heading",
		"--with-filename",
		"--line-number",
		"--column",
		"--smart-case",
	},
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
	},
})

require("telescope").load_extension("fzf")
local map = vim.keymap.set
map("i", "<C-H>", "<c-w>")
map("i", "kj", "<ESC>l")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-i>", "<C-i>zz")
map("n", "<C-l>", "<C-w>w")
map("n", "<C-o>", "<C-o>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "<Space>", "<Nop>", { silent = true })
map("n", "<leader>g", ":tab Git<CR>")
map("n", "<leader>q", ":q!<CR>")
map("n", "<leader>sf", "<cmd>Telescope find_files hidden=true<cr>")
map("n", "<leader>sg", "<cmd>Telescope live_grep<cr>")
map("n", "<leader>sh", "<cmd>Telescope help_tags<cr>")
map("n", "<leader>so", "<cmd>Telescope oldfiles<cr>")
map("n", "<leader>st", "<cmd>Telescope<cr>")
map("n", "<leader>w", ":w<CR>")
map("n", "N", "Nzzzv")
map("n", "n", "nzzzv")
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	callback = function()
		--- set help as a tab with q to quit
		if vim.bo.filetype == "help" or vim.bo.filetype == "git" then
			vim.cmd("wincmd T")
			vim.api.nvim_buf_set_keymap(0, "n", "q", ":q!<cr>", {})
		end
		--- set root cwd
		local roots = { ".luarc.json" }
		local root = vim.fs.root(0, { roots, ".git" })
		if root then
			vim.fn.chdir(root)
		end
		-- start ts
		pcall(vim.treesitter.start)
	end,
})

require("vscode").setup({
	transparent = true,
	italic_comments = true,
	italic_inlayhints = true,
	underline_links = true,
	terminal_colors = true,
})
vim.cmd("colorscheme vscode")
