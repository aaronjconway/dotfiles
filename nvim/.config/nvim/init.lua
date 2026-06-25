vim.loader.enable()
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.backup = false
vim.o.swapfile = false
vim.o.undofile = true
vim.o.signcolumn = "yes"
vim.o.number = true
vim.o.ignorecase = true
vim.o.wildignorecase = true
vim.o.smartcase = true
vim.o.clipboard = "unnamedplus"
vim.opt.shortmess:append("Ia")

vim.diagnostic.config({ virtual_text = true })

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

	{ "tpope/vim-fugitive" },
	{ "tpope/vim-surround" },
	{ "j-hui/fidget.nvim", opts = {} },
	{ "lewis6991/gitsigns.nvim" },
	{ "norcalli/nvim-colorizer.lua" },
	{ "stevearc/oil.nvim", lazy = false },
	{
		"Mofiqul/vscode.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("vscode").setup({
				transparent = true,
				italic_comments = true,
				italic_inlayhints = true,
				underline_links = true,
			})
		end,
	},
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				go = { "goimports" },
				lua = { "stylua" },
				markdown = { "prettierd" },
				toml = { "prettierd" },
			},
			format_on_save = {
				timeout_ms = 4000,
			},
		},
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup()
		end,
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
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
	},
}, {})

require("telescope").setup({
	defaults = {
		layout_config = {
			horizontal = {
				preview_width = 0.5,
			},
		},
		mappings = {
			i = {
				["<esc>"] = require("telescope.actions").close,
			},
		},
		preview = { wrap = true },
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
		},
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

map("n", "]h", require("gitsigns").next_hunk)
map("n", "[h", require("gitsigns").prev_hunk)
map("n", "<Esc>", "<cmd>nohlsearch<CR>")
map({ "c", "i" }, "<c-h>", "<c-w>")
map("i", "kj", "<ESC>l")
map("n", "<c-d>", "<c-d>zz")
map("n", "<c-i>", "<c-i>zz")
map("n", "<c-l>", "<c-w>w")
map("n", "<c-o>", "<c-o>zz")
map("n", "<c-u>", "<c-u>zz")
map("n", "<Space>", "<Nop>", { silent = true })
map("n", "<leader>g", ":tab Git<CR>")
map("n", "<leader>q", ":q!<CR>")
map("n", "<leader>st", "<cmd>Telescope<cr>")
map("n", "<leader>sf", "<cmd>Telescope find_files hidden=true<cr>")
map("n", "<leader>sg", require("telescope.builtin").live_grep)
map("n", "<leader>sh", require("telescope.builtin").help_tags)
map("n", "<leader>so", require("telescope.builtin").oldfiles)
map("n", "<leader>/", require("telescope.builtin").current_buffer_fuzzy_find)
map("n", "<leader>w", ":w<CR>")
map("n", "N", "Nzzzv")
map("n", "n", "nzzzv")
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map("n", "<c-n>", ":try | cnext | catch | cfirst | endtry<CR>")
map("n", "<c-p>", ":try | cprev | catch | clast | endtry<CR>")
map("n", "gd", vim.lsp.buf.definition, { desc = "jump to definition" })
map("n", "-", ":Oil<CR>", { desc = "Open Oil" })
map("n", "<s-r>", "<Nop>", { silent = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	callback = function()
		--- set help as separate tab with q to quit
		if vim.bo.filetype == "help" or vim.bo.filetype == "fugitive" or vim.bo.filetype == "man" then
			if #vim.api.nvim_tabpage_list_wins(0) == 1 then
				return
			end
			-- else tab it
			vim.cmd("wincmd T")
			vim.api.nvim_buf_set_keymap(0, "n", "q", ":q!<cr>", {})
		end

		--- set root cwd
		local roots = { ".luarc.json" }
		local root = vim.fs.root(0, { roots, ".git" })
		if root then
			-- TODO: add in a place to save projects
			vim.fn.chdir(root)
		end

		pcall(vim.treesitter.start)
	end,
})

require("oil").setup({
	columns = {},
	skip_confirm_for_simple_edits = true,
	prompt_save_on_select_new_entry = false,
	view_options = {
		show_hidden = true,
	},
})

vim.cmd.colorscheme("vscode")

vim.lsp.enable("lua_ls")
vim.lsp.enable("gopls")
