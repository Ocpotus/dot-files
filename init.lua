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
vim.opt.termguicolors = true
vim.opt.updatetime = 50
vim.opt.wrap = false
vim.opt.signcolumn = "yes"
vim.opt.tabstop = 8
vim.opt.expandtab = false
vim.g.mapleader = "<A>"
vim.filetype.add { extension = { ebnf = 'ebnf' } }

--[[ Keymappings ]]--
vim.keymap.set('n', '<F4>', '<CMD>wqa!<CR>')
vim.keymap.set('n', '<A-i>', '<CMD>lua require("FTerm").toggle()<CR>')
vim.keymap.set('t', '<A-i>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
vim.keymap.set('n', '<A-i>', '<CMD>lua require("FTerm").toggle()<CR>')
vim.keymap.set('t', '<A-i>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end)
vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)


vim.pack.add({
	{ src = "https://github.com/nvim-mini/mini.pairs.git",           branch = "stable" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter.git" },
	{ src = "https://github.com/numToStr/FTerm.nvim.git" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim.git" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim.git" },
	{ src = "https://github.com/numToStr/Comment.nvim.git" },
})

require('Comment').setup()
require("mini.pairs").setup()
require("nvim-treesitter.configs").setup({
	ensure_installed = { "c", "lua", "vim", "vimdoc", "rust", "go", "zig", "ebnf", "javascript" },
	sync_install = false,
	auto_install = true,
	ignore_install = { },
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
})
require("FTerm").setup({
	border     = "single",
	dimensions = {
		height = 0.9,
		width = 0.9,
	},
})

vim.cmd[[set completeopt+=menuone,noselect,popup]]
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('my.lsp', {}),
	callback = function(args)
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
		if client:supports_method('textDocument/implementation') then
			-- Create a keymap for vim.lsp.buf.implementation ...
		end

		-- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
		if client:supports_method('textDocument/completion') then
			-- Optional: trigger autocompletion on EVERY keypress. May be slow!
			local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
			client.server_capabilities.completionProvider.triggerCharacters = chars

			vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
		end
	end,
})

vim.diagnostic.config({
	virtual_text = true,
})

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "clangd", "gopls", "lua_ls" },
})

vim.lsp.enable({
    "clangd",
    "gopls",
    "lua_ls",
})

--[[ Styling ]] --
require("gruvbox").setup({
		italic = {
			strings = false,
			comment = false,
			operators = false,
		}
})
vim.cmd("colorscheme gruvbox")
