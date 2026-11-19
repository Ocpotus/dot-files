-- Build hooks must be registered before vim.pack.add() so they fire on install
vim.api.nvim_create_autocmd("PackChanged", {
	group = vim.api.nvim_create_augroup("config.pack", { clear = true }),
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if name == "nvim-treesitter" and (kind == "install" or kind == "update") then
			if not ev.data.active then vim.cmd.packadd("nvim-treesitter") end
			vim.cmd("TSUpdate")
		end
	end,
})

vim.pack.add({
	{ src = "https://github.com/nvim-mini/mini.pairs", version = "stable" },
	{ src = "https://github.com/akinsho/toggleterm.nvim" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://github.com/ibhagwan/fzf-lua" },
	-- LSP
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	-- Completion
	{ src = "https://github.com/saghen/blink.lib" }, -- future use
	{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range("^1") },
	-- Highlighting
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
})

require("mini.pairs").setup()
require("gitsigns").setup()
require("mason").setup()

require("plugins.terminal")
require("plugins.fzf")
require("plugins.completion")
require("plugins.treesitter")
