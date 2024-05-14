require("plugins")
require("settings")

require("gruvbox").setup({
	--italic = false,
})
vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])
