local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim' -- Package manager
	use 'numToStr/FTerm.nvim' -- Simple floating terminal
--[[
	use {
		"sheerun/vim-polyglot"
	}
]]
	use {
	    'RubixDev/ebnf',
	    rtp = 'crates/tree-sitter-ebnf',
	}

	use {
		"ellisonleao/gruvbox.nvim"
	}

	use {
		"chrisbra/unicode.vim"
	}
	use {
		'nvim-treesitter/nvim-treesitter',
		{
			run = ':TSUpdate'
		},
	}

	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v1.x',
		requires = {
			-- LSP Support --
			{'neovim/nvim-lspconfig'},             	-- Required
			{'williamboman/mason.nvim'},           	-- Optional
			{'williamboman/mason-lspconfig.nvim'}, 	-- Optional
			-- Autocompletion --
			{'hrsh7th/nvim-cmp'},         		-- Required
			{'hrsh7th/cmp-nvim-lsp'},     		-- Required
			{'hrsh7th/cmp-buffer'},       		-- Optional
			{'hrsh7th/cmp-path'},         		-- Optional
			{'saadparwaiz1/cmp_luasnip'}, 		-- Optional
			{'hrsh7th/cmp-nvim-lua'},     		-- Optional

			{'L3MON4D3/LuaSnip'},             	-- Required
			{'rafamadriz/friendly-snippets'}, 	-- Optional
		}
	}

	use {
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		requires = { 
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		}
	}

	use {
		'numToStr/Comment.nvim',
		config = function()
			require('Comment').setup()
		end
	}

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require('packer').sync()
	end
end)
