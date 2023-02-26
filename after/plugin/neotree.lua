local neotree = require("neo-tree")
local keys = vim.keymap

neotree.setup({
	filesystem = {
		filtered_items = {
			hide_dotfiles = false,
			hide_gitignored = false,
			hide_hidden = false,
		},
		hijack_netrw_behavior = "open_default",
		window = {
			mappings = {
				["."] = "set_root",
				["H"] = "toggle_hidden",
				["/"] = "fuzzy_finder",
			},
			position = "float",
		}
	}
})
