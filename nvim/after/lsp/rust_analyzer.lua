---@type vim.lsp.Config
return {
	settings = {
		["rust-analyzer"] = {
			check = { command = "clippy" }, -- clippy lints instead of plain `cargo check`
			cargo = {
				allFeatures = true, -- analyse code behind feature flags too
				buildScripts = { enable = true },
			},
			procMacro = { enable = true },
			imports = {
				granularity = { group = "module" },
				prefix = "self",
			},
		},
	},
}
