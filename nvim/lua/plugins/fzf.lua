local alt = require("config.util").alt
local fzf = require("fzf-lua")

fzf.setup({
	-- files / grep / live_grep already search cwd; restrict the rest too
	buffers = { cwd_only = true },
	oldfiles = { cwd_only = true },
	lsp = { cwd_only = true },
	diagnostics = { cwd_only = true },
	keymap = {
		-- `true` keeps fzf-lua's default binds; the same key that opens the picker closes it
		fzf = { true, ["alt-r"] = "abort" },
	},
})

vim.keymap.set("n", alt("r"), fzf.live_grep, { desc = "Live grep" })
