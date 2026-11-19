-- Per-server overrides live in lsp/<name>.lua and are merged over nvim-lspconfig's defaults
vim.lsp.enable({ "lua_ls", "clangd", "gopls", "rust_analyzer" })

vim.diagnostic.config({
	virtual_text = { prefix = "■", source = "if_many" },
	update_in_insert = true,
	severity_sort = true,
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("config.lsp", { clear = true }),
	callback = function(ev)
		-- Builtin defaults already cover: grn rename, gra code action, grr references,
		-- gri implementation, grt type definition, grx codelens, gO symbols, K hover,
		-- <C-W>d diagnostic float, <C-S> signature help (insert). Only fill the gaps.
		local map = function(keys, rhs, desc)
			vim.keymap.set("n", keys, rhs, { buffer = ev.buf, desc = "LSP: " .. desc })
		end
		map("gd", "<C-]>", "go to definition") -- builtin tagfunc jump, first match
		map("gD", vim.lsp.buf.declaration, "go to declaration")
	end,
})
