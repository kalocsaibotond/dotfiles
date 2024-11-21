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
		python = "python",
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
	end
	if vim.fn.executable("pwsh") then
		ft_to_repl["ps1"] = "pwsh"
	end
	local fts = {}
	for k, _ in pairs(ft_to_repl) do
		table.insert(fts, k)
	end

	require("which-key").add({
		{ "<LocalLeader>r", group = "repl" }, -- Add repl group in which-key
	})
	return {
		"milanglacier/yarepl.nvim",
		config = function(_, _)
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
		keys = {
			-- REPL management keybindings
			{
				"<LocalLeader>ro",
				function()
					local repl = ft_to_repl[vim.bo.filetype]
					run_cmd_with_count("REPLStart " .. repl)
				end,
				mode = "n",
				ft = fts,
				desc = "Open REPL here",
			},
			{
				"<LocalLeader>r?",
				function()
					run_cmd_with_count("REPLStart")
				end,
				mode = "n",
				desc = "Open REPL",
			},
			{
				"<LocalLeader>rq",
				function()
					run_cmd_with_count("REPLClose")
				end,
				mode = "n",
				desc = "Quit REPL",
			},
			{
				"<LocalLeader>rc",
				"<Cmd>REPLCleanup<Cr>",
				mode = "n",
				desc = "Cleanup REPLs",
			},
			{
				"<LocalLeader>ra",
				"<Cmd>REPLAttachBufferToREPL<Cr>",
				mode = "n",
				desc = "Attach REPL",
			},
			{
				"<LocalLeader>rd",
				"<Cmd>REPLDetachBufferToREPL<Cr>",
				mode = "n",
				desc = "Detach REPL",
			},
			{
				"<LocalLeader>rS",
				"<Cmd>REPLSwap<Cr>",
				mode = "n",
				desc = "Swap REPLs",
			},
			-- REPL navigation keybindigs
			{
				"<LocalLeader>rf",
				function()
					run_cmd_with_count("REPLFocus")
				end,
				mode = "n",
				desc = "Focus on REPL",
			},
			{
				"<LocalLeader>rh",
				function()
					run_cmd_with_count("REPLHide")
				end,
				mode = "n",
				desc = "Hide REPL",
			},
			{
				"<LocalLeader>rl",
				"<Cmd>Telescope REPLShow<Cr>",
				mode = "n",
				desc = "List REPLs",
			},
			{
				"<LocalLeader>rt",
				function()
					run_cmd_with_count("REPLHideOrFocus")
				end,
				mode = "n",
				desc = "Toggle REPL",
			},
			{ -- Shortcut
				"<LocalLeader>t",
				function()
					run_cmd_with_count("REPLHideOrFocus")
				end,
				mode = "n",
				desc = "Toggle REPL",
			},
			-- Sending key bindings
			{
				"<LocalLeader>rss",
				function()
					run_cmd_with_count("REPLSendLine")
				end,
				mode = "n",
				desc = "Send line to REPL",
			},
			{ -- Shortcut
				"<LocalLeader>ss",
				function()
					run_cmd_with_count("REPLSendLine")
				end,
				mode = "n",
				desc = "Send line to REPL",
			},
			{
				"<LocalLeader>rs",
				function()
					run_cmd_with_count("REPLSendOperator")
				end,
				mode = "n",
				desc = "Send to REPL",
			},
			{ -- Shortcut
				"<LocalLeader>s",
				function()
					run_cmd_with_count("REPLSendOperator")
				end,
				mode = "n",
				desc = "Send to REPL",
			},
			{
				"<LocalLeader>rs",
				function()
					run_cmd_with_count("REPLSendVisual")
				end,
				mode = "v",
				desc = "Send Visual to REPL",
			},
			{ -- Shortcut
				"<LocalLeader>s",
				function()
					run_cmd_with_count("REPLSendVisual")
				end,
				mode = "v",
				desc = "Send Visual to REPL",
			},
			-- TODO: Define a keymap that works for the REPLExec command:
			-- {
			-- 	"<LocalLeader>re",
			-- 	partial_cmd_with_count_expr("REPLExec "),
			-- 	mode = "n",
			-- 	desc = "Execute command in REPL",
			-- 	expr = true,
			-- },
		},
	}
else
	return {}
end
