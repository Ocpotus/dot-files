-- Per-server overrides live in after/lsp/<name>.lua (loaded last, so they win over) nvim-lspconfig's defaults
-- NOTE: When tsgo gets more features and a good vue server/plugin is available, replace vue_ls and vtsls with it.
-- 	 Treesitter and Mason will need to be updated when this happens.
-- C# Roslyn is started by easy-dotnet (client "easy_dotnet"), not enabled here
vim.lsp.enable({ "lua_ls", "clangd", "gopls", "rust_analyzer", "vue_ls", "vtsls", "eslint" })

-- Servers whose formatter runs on every write
-- typescript/javascript formatting not enabled
local format_on_save = { gopls = true, rust_analyzer = true, easy_dotnet = true }

vim.diagnostic.config({
	virtual_text = { prefix = "■", source = "if_many" },
	update_in_insert = true,
	severity_sort = true,
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("config.lsp", { clear = true }),
	callback = function(ev)
		local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))

		-- Builtin defaults already cover: grn rename, gra code action, grr references,
		-- gri implementation, grt type definition, grx codelens, gO symbols, K hover,
		-- <C-W>d diagnostic float, <C-S> signature help (insert). Only fill the gaps.
		local map = function(keys, rhs, desc)
			vim.keymap.set("n", keys, rhs, { buffer = ev.buf, desc = "LSP: " .. desc })
		end
		map("gd", "<C-]>", "go to definition") -- builtin tagfunc jump, first match
		map("gD", vim.lsp.buf.declaration, "go to declaration")

		if format_on_save[client.name] then
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = vim.api.nvim_create_augroup("config.format." .. ev.buf, { clear = true }),
				buffer = ev.buf,
				callback = function() vim.lsp.buf.format({ bufnr = ev.buf, id = client.id }) end,
			})
		end
	end,
})
