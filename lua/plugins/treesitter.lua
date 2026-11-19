local ts = require("nvim-treesitter")

ts.setup({
	-- Prepended to 'runtimepath' so these parsers take priority
	install_dir = vim.fn.stdpath("data") .. "/site",
})
ts.install({ "c", "cpp", "rust", "zig", "lua", "javascript", "typescript" })

-- Start highlighting for any buffer whose filetype has an installed parser
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("config.treesitter", { clear = true }),
	callback = function(ev) pcall(vim.treesitter.start, ev.buf) end,
})
