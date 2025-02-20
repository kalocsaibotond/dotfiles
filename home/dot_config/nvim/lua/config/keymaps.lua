-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

if vim.g.vscode then
-- vscode-nvim settings
else
	-- Ordinary nvim settings
	local map = vim.keymap.set

	map(
		"t",
		"<esc><esc>",
		[[<C-\><C-n>]],
		{ desc = "Escape from terminal mode to Normal mode" }
	)
end
