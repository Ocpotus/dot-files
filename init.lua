--[[ Settings ]]--
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.autochdir = false
vim.opt.scrolloff = 999
vim.opt.guicursor = ""
vim.opt.termguicolors = false
vim.opt.updatetime = 50
vim.opt.wrap = false
vim.opt.signcolumn = "yes"
vim.opt.tabstop = 8
vim.opt.expandtab = false
vim.g.mapleader = "<A>"
vim.opt.clipboard = "unnamedplus"

vim.filetype.add { extension = { ebnf = "ebnf" } }

--[[ File Explorer (netrw) ]]--
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3

--[[ Keymappings ]]--
vim.keymap.set("n", "<A-f>", "<CMD>Rexplore<CR>")
vim.keymap.set("n", "<F4>", "<CMD>wqa!<CR>")
vim.keymap.set("n", "<A-i>", "<CMD>lua require('FTerm').toggle()<CR>")
vim.keymap.set("t", "<A-i>", "<C-\\><C-n><CMD>lua require('FTerm').toggle()<CR>")
vim.keymap.set("n", "<A-i>", "<CMD>lua require('FTerm').toggle()<CR>")
vim.keymap.set("t", "<A-i>", "<C-\\><C-n><CMD>lua require('FTerm').toggle()<CR>")

vim.pack.add({
	{ src = "https://github.com/nvim-mini/mini.pairs.git", branch = "stable" },
	{ src = "https://github.com/numToStr/FTerm.nvim.git" },
	{ src = "https://github.com/numToStr/Comment.nvim.git" },
	--[[ LSP ]]--
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	--[[ Completion ]]--
	{ src = "https://github.com/saghen/blink.lib" },
	{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range("^1") },

	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", lazy = false, build = ":TSUpdate" },

	--[[ Git ]]--
	{ src = "https://github.com/lewis6991/gitsigns.nvim.git" }
})

require("Comment").setup()
require("mini.pairs").setup()
require("gitsigns").setup()
require("FTerm").setup({
	border     = "single",
	dimensions = {
		height = 0.9,
		width = 0.9,
	},
})

require("mason").setup()

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" }
			}
		}
	}
})

vim.lsp.enable("lua_ls")

vim.lsp.config("clangd", {
	cmd = {
		"clangd",
		"--background-index",
		"--clang-tidy",
		"--completion-style=detailed",
		"--header-insertion=iwyu",
	},
	filetypes = { "c", "cpp", "objc", "objcpp" },
	root_markers = { ".clangd", "compile_commands.json", "compile_flags.txt", ".git" },
})

vim.lsp.enable("clangd")
vim.lsp.enable("gopls")
vim.lsp.enable("rust_analyzer")

vim.diagnostic.config({
	virtual_text = {
		prefix = "■",
		source = "if_many",
	},

	underline = true,
	signs = true,
	update_in_insert = true,
	severity_sort = true,
})

require("blink.cmp").setup({
	keymap = { preset = "super-tab" },

	appearance = {
		nerd_font_variant = "mono",
		use_nvim_cmp_as_default = true,
	},

	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},

	completion = {
		documentation = { auto_show = true, auto_show_delay_ms = 200 },
	}
})

require("nvim-treesitter").setup {
	-- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
	install_dir = vim.fn.stdpath("data") .. "/site"
}
require("nvim-treesitter").install({ "rust", "javascript", "zig", "lua", "c", "cpp" })

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "c", "rust" },
	callback = function() vim.treesitter.start() end,
})
