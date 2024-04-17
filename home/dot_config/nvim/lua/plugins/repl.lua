return {
	{ -- Adding group name for REPL
		"folke/which-key.nvim",
		opts = {
			defaults = {
				["<leader>r"] = { name = "+repl" },
				["<leader>rm"] = { name = "+mark" },
			},
		},
	},
	{ -- https://dev.to/rnrbarbosa/how-to-run-python-on-neovim-like-jupyter-3ln0
		"Vigemus/iron.nvim",
		config = function(plugins, opts)
			local iron = require("iron")
			local view = require("iron.view")
			local fts = require("iron.fts")

			table.insert(fts.python.ipython.command, "--no-confirm-exit")
			table.insert(fts.python.ipython.command, "--pylab=qt")
			if vim.fn.executable("pwsh") then
				fts.ps1.ps1.command[1] = "pwsh"
			end
			iron.core.setup({
				config = {
					-- Whether a repl should be discarded or not
					scratch_repl = false,
					-- Your repl definitions come here
					repl_definition = {
						python = fts.python.ipython,
						ps1 = fts.ps1.ps1,
						sh = fts.sh.sh,
					},
					-- How the repl window will be displayed
					-- See below for more information
					repl_open_cmd = view.right(85),
				},
				-- Iron doesn't set keymaps by default anymore.
				-- You can set them here or manually add keymaps to the functions in iron.core
				keymaps = {
					send_motion = "<leader>rc",
					visual_send = "<leader>rc",
					send_file = "<leader>rf",
					send_line = "<leader>rl",
					send_until_cursor = "<leader>ru",
					send_mark = "<leader>rm",
					mark_motion = "<leader>rmc",
					mark_visual = "<leader>rmc",
					remove_mark = "<leader>rmd",
					cr = "<leader>r<cr>",
					interrupt = "<leader>r<space>",
					exit = "<leader>rq",
					clear = "<leader>rx",
				},
				-- If the highlight is on, you can change how it looks
				-- For the available options, check nvim_set_hl
				highlight = {
					italic = true,
				},
				ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
			})
		end,
		keys = {
			{
				"<leader>rs",
				"<cmd>IronRepl<cr>",
				desc = "Open REPL",
			},
			{
				"<leader>rr",
				"<cmd>IronRestart<cr>",
				desc = "Restart REPL",
			},
			{
				"<leader>rF",
				"<cmd>IronFocus<cr>",
				desc = "Focus on REPL",
			},
			{
				"<leader>rh",
				"<cmd>IronHide<cr>",
				desc = "Hide REPL",
			},
		},
	},
}
