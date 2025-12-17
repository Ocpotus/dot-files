--[[
local set = vim.opt
local keys = vim.keymap

set.relativenumber = true
set.number = true
set.hlsearch = false
set.incsearch = true
set.ignorecase = true
set.smartcase = true
set.smartindent = true
set.autoindent = true
set.autochdir = false
set.scrolloff = 999
set.guicursor = ""
set.termguicolors = true
set.updatetime = 50
set.wrap = false
set.signcolumn = "yes"
set.tabstop = 8
set.expandtab = false
vim.g.mapleader = "<A>"
vim.filetype.add { extension = { ebnf = 'ebnf' } }

keys.set('n', '<F4>', '<CMD>wqa!<CR>')
keys.set('n', '<A-i>', '<CMD>lua require("FTerm").toggle()<CR>')
keys.set('t', '<A-i>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
keys.set('n', '<A-f>', '<CMD>Neotree toggle<CR>')
keys.set('n', '<A-i>', '<CMD>lua require("FTerm").toggle()<CR>')
keys.set('t', '<A-i>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
keys.set('n', '<A-f>', '<CMD>Neotree toggle<CR>')

require("gruvbox").setup({
		italic = {
			strings = false,
			comment = false,
			operators = false,
		}
})
]]--
