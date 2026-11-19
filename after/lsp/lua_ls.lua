---@type vim.lsp.Config
return {
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			-- Real Neovim API types instead of silencing the "vim" global
			workspace = {
				checkThirdParty = false,
				library = { vim.env.VIMRUNTIME },
			},
		},
	},
}
