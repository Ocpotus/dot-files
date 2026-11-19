---@type vim.lsp.Config
return {
	on_attach = require("config.util").format_on_save,
	settings = {
		gopls = {
			gofumpt = true, -- stricter gofmt
			staticcheck = true, -- extra lint checks
			semanticTokens = true,
			analyses = {
				shadow = true, -- variables that shadow an outer one
				unusedvariable = true,
			},
			directoryFilters = { "-.git", "-node_modules" },
		},
	},
}
