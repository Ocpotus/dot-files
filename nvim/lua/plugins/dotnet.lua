local alt = require("config.util").alt
local map = vim.keymap.set

-- Requires easy-dotnet-server: `dotnet tool install -g EasyDotnet` (update with :Dotnet _server update)
-- easy-dotnet also runs Roslyn itself (client "easy_dotnet"); settings live in after/lsp/easy_dotnet.lua
-- Global dotnet tools (dotnet-easydotnet, roslyn-language-server) aren't on PATH by default on Arch
local dotnet_tools = vim.fs.joinpath(vim.env.HOME, ".dotnet", "tools")
if not vim.env.PATH:find(dotnet_tools, 1, true) then
	vim.env.PATH = dotnet_tools .. ":" .. vim.env.PATH
end

local dotnet = require("easy-dotnet")
dotnet.setup({
	picker = "fzf",
	-- All dotnet keybinds use the <A-D> prefix; letters mirror easy-dotnet's <leader> defaults.
	-- Left on <leader>: \ar (csproj/fsproj) and \gf (result floats) are hard-coded in the plugin.
	test_runner = {
		-- neotest owns buffer signs/keymaps; the :Dotnet testrunner window still works
		neotest_integration = true,
		mappings = { -- test runner window only (buffer-local)
			run = { lhs = alt("Dr"), desc = "run test" },
			run_all = { lhs = alt("Dar"), desc = "run all tests" },
			debug_test = { lhs = alt("Dd"), desc = "debug test" },
			peek_stacktrace = { lhs = alt("Dp"), desc = "peek stacktrace of failed test" },
			go_to_file = { lhs = alt("Dg"), desc = "go to file" },
			get_build_errors = { lhs = alt("De"), desc = "get build errors" },
		},
	},
	outdated = {
		mappings = { -- buffer-local after :Dotnet outdated
			upgrade = { lhs = alt("Dpu"), desc = "upgrade package under cursor" },
			upgrade_all = { lhs = alt("Dpa"), desc = "upgrade all outdated packages" },
		},
	},
})

local neotest = require("neotest")
neotest.setup({
	adapters = { require("easy-dotnet.neotest") },
})

-- Dotnet
map("n", alt("DR"), dotnet.run, { desc = "Dotnet: run project" })
map("n", alt("Db"), dotnet.build_quickfix, { desc = "Dotnet: build (quickfix)" })
map("n", alt("Dt"), dotnet.testrunner, { desc = "Dotnet: toggle test runner" })

-- Neotest
map("n", alt("tt"), function() neotest.run.run() end, { desc = "Test: run nearest" })
map("n", alt("tf"), function() neotest.run.run(vim.fn.expand("%")) end, { desc = "Test: run file" })
map("n", alt("tl"), function() neotest.run.run_last() end, { desc = "Test: run last" })
map("n", alt("tx"), function() neotest.run.stop() end, { desc = "Test: stop" })
map("n", alt("ts"), function() neotest.summary.toggle() end, { desc = "Test: toggle summary" })
map("n", alt("to"), function() neotest.output.open({ enter = true }) end, { desc = "Test: show output" })
map("n", alt("tp"), function() neotest.output_panel.toggle() end, { desc = "Test: toggle output panel" })
