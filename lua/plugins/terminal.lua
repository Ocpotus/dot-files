local alt = require("config.util").alt

require("toggleterm").setup({
	open_mapping = alt("i"), -- n + t modes (terminal_mappings defaults to true)
	insert_mappings = false,
	direction = "float",
	float_opts = {
		border = "single",
		width = function() return math.floor(vim.o.columns * 0.9) end,
		height = function() return math.floor(vim.o.lines * 0.9) end,
	},
})
