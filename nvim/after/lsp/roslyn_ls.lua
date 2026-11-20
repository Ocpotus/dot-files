-- Merged over nvim-lspconfig's roslyn_ls (which handles solution loading and
-- diagnostic refresh). Don't set on_attach/on_init here: it would replace those.
---@type vim.lsp.Config
return {
	settings = {
		["csharp|background_analysis"] = {
			-- Analyzers only on open files keeps big solutions responsive;
			-- compiler errors still cover the whole solution
			dotnet_analyzer_diagnostics_scope = "openFiles",
			dotnet_compiler_diagnostics_scope = "fullSolution",
		},
		["csharp|formatting"] = {
			dotnet_organize_imports_on_format = true, -- sort/remove usings on save
		},
		["csharp|completion"] = {
			dotnet_show_completion_items_from_unimported_namespaces = true, -- auto-add usings
			dotnet_show_name_completion_suggestions = true,
		},
	},
}
