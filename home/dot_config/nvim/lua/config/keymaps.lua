-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

if vim.g.vscode then
-- vscode-nvim settings
else
	-- iron also has a list of commands, see :h iron-commands for all available commands
	vim.keymap.set("n", "<space>rs", "<cmd>IronRepl<cr>")
	vim.keymap.set("n", "<space>rr", "<cmd>IronRestart<cr>")
	vim.keymap.set("n", "<space>rF", "<cmd>IronFocus<cr>")
	vim.keymap.set("n", "<space>rh", "<cmd>IronHide<cr>")

	local telescope = require("telescope")

	-- Zoxide
	telescope.load_extension("zoxide")
	vim.keymap.set(
		"n",
		"<leader>fd",
		require("telescope").extensions.zoxide.list,
		{ desc = "Change directory (cwd)" }
	)

	-- Chezmoi
	telescope.load_extension("chezmoi")
	vim.keymap.set(
		"n",
		"<leader>fz",
		telescope.extensions.chezmoi.find_files,
		{ desc = "Find Chezmoi Source File" }
	)
end
