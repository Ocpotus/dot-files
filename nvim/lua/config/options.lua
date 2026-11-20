local o = vim.o

-- UI
o.number = true
o.relativenumber = true
o.signcolumn = "yes"
o.wrap = false
o.scrolloff = 999
o.guicursor = ""
o.termguicolors = false
o.winborder = "single"

-- Search
o.hlsearch = false
o.ignorecase = true
o.smartcase = true

-- Editing
o.smartindent = true
o.clipboard = "unnamedplus"
o.updatetime = 50

-- netrw
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3

vim.filetype.add({ extension = { ebnf = "ebnf" } })
