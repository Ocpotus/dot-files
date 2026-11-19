local alt = require("config.util").alt
local map = vim.keymap.set

map("n", "<F4>", function() vim.cmd.wqall({ bang = true }) end, { desc = "Save all and quit" })
map("n", alt("f"), function() vim.cmd.Rexplore() end, { desc = "Toggle netrw" })
