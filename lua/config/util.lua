local M = {}

--- Turn a key sequence into Alt-modified keys: alt("ef") -> "<A-e><A-f>"
---@param keys string
---@return string
function M.alt(keys)
	return (keys:gsub(".", "<A-%0>"))
end

--- LSP on_attach that formats the buffer with this client before each write
---@param client vim.lsp.Client
---@param bufnr integer
function M.format_on_save(client, bufnr)
	vim.api.nvim_create_autocmd("BufWritePre", {
		group = vim.api.nvim_create_augroup("config.format." .. bufnr, { clear = true }),
		buffer = bufnr,
		callback = function() vim.lsp.buf.format({ bufnr = bufnr, id = client.id }) end,
	})
end

return M
