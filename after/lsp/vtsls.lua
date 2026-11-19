-- vtsls handles all TypeScript, including inside .vue files via @vue/typescript-plugin.
-- vue_ls (lspconfig defaults, no override needed) handles the template/style parts
-- and forwards its TypeScript requests to this client.

local vue_ls_path = vim.fs.joinpath(
	vim.fn.stdpath("data"),
	"mason/packages/vue-language-server/node_modules/@vue/language-server"
)

---@type vim.lsp.Config
return {
	-- Full list: replaces lspconfig's, adding vue
	filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
	settings = {
		vtsls = {
			autoUseWorkspaceTsdk = true, -- use the project's own TypeScript version when present
			tsserver = {
				globalPlugins = {
					{
						name = "@vue/typescript-plugin",
						location = vue_ls_path,
						languages = { "vue" },
						configNamespace = "typescript",
						enableForWorkspaceTypeScriptVersions = true,
					},
				},
			},
		},
		typescript = {
			updateImportsOnFileMove = { enabled = "always" },
		},
		javascript = {
			updateImportsOnFileMove = { enabled = "always" },
		},
	},
}
