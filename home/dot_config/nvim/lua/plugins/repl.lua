if not vim.g.vscode then
	-- Execute commands with count values
	local function run_cmd_with_count(cmd)
		vim.cmd(string.format("%d%s", vim.v.count, cmd))
	end

	-- Execute commands iwth count vales and complition
	local function partial_cmd_with_count_expr(cmd)
		-- <C-U> is equivalent to \21, we want to clear the range before next input
		-- to ensure the count is recognized correctly.
		return vim.cmd(":\21" .. vim.v.count .. cmd)
	end

	-- Filetype to repl assocaitions
	local ft_to_repl = {
		python = "ipython",
		sh = "sh",
		bat = "cmd",
		ps1 = "powershell",
		REPL = "",
	}
	if vim.fn.executable("ipython") then
		ft_to_repl["python"] = "ipython"
	end
	if vim.fn.executable("dash") then
		ft_to_repl["sh"] = "dash"
	elseif vim.fn.executable("bash") then
		ft_to_repl["sh"] = "bash"
	end
	local fts = {}
	for k, _ in pairs(ft_to_repl) do
		table.insert(fts, k)
	end

	require("which-key").register({
		r = { name = "repl" },
	}, {
		prefix = "<LocalLeader>",
		mode = "n",
	})
	return {
		"milanglacier/yarepl.nvim",
		config = function(plugin, opts)
			local yarepl = require("yarepl")
			yarepl.setup({
				buflisted = false,
				wincmd = "vertical 85 split",
				metas = {
					ipython = {
						cmd = { "ipython", "--no-confirm-exit", "--pylab=tk" },
						formatter = yarepl.formatter.bracketed_pasting,
					},
					sh = {
						cmd = "sh",
						formatter = yarepl.formatter.trim_empty_lines,
					},
					dash = {
						cmd = "dash",
						formatter = yarepl.formatter.trim_empty_lines,
					},
					cmd = {
						cmd = "cmd",
						formatter = yarepl.formatter.trim_empty_lines,
					},
					powershell = {
						cmd = {
							"powershell",
							"-NoExit",
							"-ExecutionPolicy",
							"Bypass",
						},
						formatter = yarepl.formatter.trim_empty_lines,
					},
					pwsh = {
						cmd = {
							"pwsh",
							"-NoExit",
							"-ExecutionPolicy",
							"Bypass",
						},
						formatter = yarepl.formatter.trim_empty_lines,
					},
				},
			})
			require("telescope").load_extension("REPLShow")
		end,
		ft = fts,
		keys = {
			-- REPL management keybindings
			{
				"<LocalLeader>ro",
				function()
					local repl = ft_to_repl[vim.bo.filetype]
					run_cmd_with_count("REPLStart " .. repl)
				end,
				mode = "n",
				-- ft = fts,  -- BUG: If I uncomment then the key is not defined
				desc = "Open REPL here",
			},
			{
				"<LocalLeader>r?",
				function()
					run_cmd_with_count("REPLStart")
				end,
				mode = "n",
				-- ft = fts,
				desc = "Open REPL",
			},
			{
				"<LocalLeader>rq",
				function()
					run_cmd_with_count("REPLClose")
				end,
				mode = "n",
				-- ft = fts,
				desc = "Quit REPL",
			},
			{
				"<LocalLeader>rc",
				"<Cmd>REPLCleanup<Cr>",
				mode = "n",
				-- ft = fts,
				desc = "Cleanup REPLs",
			},
			{
				"<LocalLeader>ra",
				"<Cmd>REPLAttachBufferToREPL<Cr>",
				mode = "n",
				-- ft = fts,
				desc = "Attach REPL",
			},
			{
				"<LocalLeader>rd",
				"<Cmd>REPLDetachBufferToREPL<Cr>",
				mode = "n",
				-- ft = fts,
				desc = "Detach REPL",
			},
			{
				"<LocalLeader>rs",
				"<Cmd>REPLSwap<Cr>",
				mode = "n",
				-- ft = fts,
				desc = "Swap REPLs",
			},
			-- REPL navigation keybindigs
			{
				"<LocalLeader>rf",
				function()
					run_cmd_with_count("REPLFocus")
				end,
				mode = "n",
				-- ft = fts,
				desc = "Focus on REPL",
			},
			{
				"<LocalLeader>rh",
				function()
					run_cmd_with_count("REPLHide")
				end,
				mode = "n",
				-- ft = fts,
				desc = "Hide REPL",
			},
			{
				"<LocalLeader>rl",
				"<Cmd>Telescope REPLShow<Cr>",
				mode = "n",
				-- ft = fts,
				desc = "List REPLs",
			},
			{
				"<LocalLeader>t",
				function()
					run_cmd_with_count("REPLHideOrFocus")
				end,
				mode = "n",
				-- ft = fts,
				desc = "Toggle REPL",
			},
			-- Sending key bindings
			{
				"<LocalLeader>ss",
				function()
					run_cmd_with_count("REPLSendLine")
				end,
				mode = "n",
				-- ft = fts,
				desc = "Send line to REPL",
			},
			{
				"<LocalLeader>s",
				function()
					run_cmd_with_count("REPLSendOperator")
				end,
				mode = "n",
				-- ft = fts,
				desc = "Send to REPL",
			},
			{
				"<LocalLeader>s",
				function()
					run_cmd_with_count("REPLSendVisual")
				end,
				mode = "v",
				-- ft = fts,
				desc = "Send Visual to REPL",
			},
			-- {
			-- 	"<LocalLeader>re",
			-- 	partial_cmd_with_count_expr("REPLExec "),
			-- 	mode = "n",
			-- 	-- ft = fts,
			-- 	desc = "Execute command in REPL",
			-- 	expr = true,
			-- },
		},
	}
else
	return {}
end
-- { -- https://dev.to/rnrbarbosa/how-to-run-python-on-neovim-like-jupyter-3ln0
-- 	"Vigemus/iron.nvim",
-- 	config = function(plugins, opts)
-- 		local iron = require("iron")
-- 		local view = require("iron.view")
-- 		local fts = require("iron.fts")
--
-- 		table.insert(fts.python.ipython.command, "--no-confirm-exit")
-- 		table.insert(fts.python.ipython.command, "--pylab=tk")
-- 		if vim.fn.executable("pwsh") then
-- 			fts.ps1.ps1.command[1] = "pwsh"
-- 		end
-- 		iron.core.setup({
-- 			config = {
-- 				-- Whether a repl should be discarded or not
-- 				scratch_repl = false,
-- 				-- Your repl definitions come here
-- 				repl_definition = {
-- 					python = fts.python.ipython,
-- 					ps1 = fts.ps1.ps1,
-- 					sh = fts.sh.sh,
-- 				},
-- 				-- How the repl window will be displayed
-- 				-- See below for more information
-- 				repl_open_cmd = view.right(85),
-- 			},
-- 			-- Iron doesn't set keymaps by default anymore.
-- 			-- You can set them here or manually add keymaps to the functions in iron.core
-- 			keymaps = {
-- 				send_motion = "<LocalLeader>rc",
-- 				visual_send = "<LocalLeader>r",
-- 				send_file = "<LocalLeader>rf",
-- 				send_line = "<LocalLeader>rl",
-- 				send_until_cursor = "<LocalLeader>ru",
-- 				send_mark = "<LocalLeader>rm",
-- 				mark_motion = "<LocalLeader>rmc",
-- 				mark_visual = "<LocalLeader>rmc",
-- 				remove_mark = "<LocalLeader>rmd",
-- 				cr = "<LocalLeader>r<cr>",
-- 				interrupt = "<LocalLeader>r<space>",
-- 				exit = "<LocalLeader>rq",
-- 				clear = "<LocalLeader>rx",
-- 			},
-- 			-- If the highlight is on, you can change how it looks
-- 			-- For the available options, check nvim_set_hl
-- 			highlight = {
-- 				italic = true,
-- 			},
-- 			ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
-- 		})
-- 	end,
-- 	keys = {
-- 		{
-- 			"<LocalLeader>rs",
-- 			"<cmd>IronRepl<cr>",
-- 			desc = "Open REPL",
-- 		},
-- 		{
-- 			"<LocalLeader>rr",
-- 			"<cmd>IronRestart<cr>",
-- 			desc = "Restart REPL",
-- 		},
-- 		{
-- 			"<LocalLeader>rF",
-- 			"<cmd>IronFocus<cr>",
-- 			desc = "Focus on REPL",
-- 		},
-- 		{
-- 			"<LocalLeader>rh",
-- 			"<cmd>IronHide<cr>",
-- 			desc = "Hide REPL",
-- 		},
-- 	},
-- },
