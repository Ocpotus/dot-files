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
vim.opt.clipboard = "unnamedplus"

-- No leader every custom keybind will be alt modifiers
--vim.g.mapleader = " "

vim.filetype.add { extension = { ebnf = "ebnf" } }

local map_keys = function(keys)
	return (keys:gsub(".", "<A-%0>"))
end

vim.pack.add({
	{ src = "https://github.com/nvim-mini/mini.pairs.git", branch = "stable" },
	--{ src = "https://github.com/numToStr/FTerm.nvim.git" },
	{ src = "https://github.com/numToStr/Comment.nvim.git" },
	--[[ Terminal ]]--
	{ src = "https://github.com/akinsho/toggleterm.nvim" },
	--[[ LSP ]]--
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	--[[ Completion ]]--
	{ src = "https://github.com/saghen/blink.lib" }, -- Future use
	{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range("^1") },
	--[[ Highlighting ]]--
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", lazy = false, build = ":TSUpdate" },
	--[[ Fuzzy finder ]]--
	{ src = "https://github.com/ibhagwan/fzf-lua" },
	--[[ Git ]]--
	{ src = "https://github.com/lewis6991/gitsigns.nvim.git" }
})

--[[ Force quit ]]--
vim.keymap.set("n", "<F4>", "<CMD>wqa!<CR>")

--[[ File explorer (netrw) ]]--
vim.keymap.set("n", map_keys("e"), "<CMD>Rexplore<CR>")
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3

--[[ Terminal ]]--
require("toggleterm").setup({
	open_mapping = map_keys("i"), -- n + t modes (terminal_mappings defaults to true)
	insert_mappings = false,
	direction = "float",
	float_opts = {
		border = "single",
		width = function() return math.floor(vim.o.columns * 0.9) end,
		height = function() return math.floor(vim.o.lines * 0.9) end,
	},
})

require("Comment").setup()
require("mini.pairs").setup()
require("gitsigns").setup()
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

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		-- Builtin defaults already cover: grn rename, gra code action, grr references,
		-- gri implementation, grt type definition, grx codelens, gO symbols, K hover,
		-- <C-W>d diagnostic float, <C-S> signature help (insert). Only fill the gaps.
		local map = function(keys, fn, desc)
			vim.keymap.set("n", keys, fn, { buffer = ev.buf, desc = desc })
		end
		map("gd", "<C-]>", "LSP: go to definition") -- builtin tagfunc jump, first match
		map("gD", vim.lsp.buf.declaration, "LSP: go to declaration")
	end,
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

require("nvim-treesitter").setup({
	-- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
	install_dir = vim.fn.stdpath("data") .. "/site"
})
require("nvim-treesitter").install({ "rust", "javascript", "zig", "lua", "c", "cpp" })

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "c", "rust", "ts", "js", "cs", "cpp", "zig", "lua", "rs" },
	callback = function() vim.treesitter.start() end,
})

-- Places the floating window at the bottom left corner
require("fzf-lua").setup({
	-- files / grep / live_grep already search cwd; restrict the rest too
	buffers  = { cwd_only = true },
	oldfiles = { cwd_only = true },
	lsp      = { cwd_only = true },
	diagnostics = { cwd_only = true },
})
vim.keymap.set("n", map_keys("f"), "<CMD>FzfLua live_grep<CR>")
