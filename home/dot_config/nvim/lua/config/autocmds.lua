-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Chezmoi
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = {
		vim.fn.system(
			"chezmoi execute-template '{{.chezmoi.workingTree}}/**'"
		),
	},
	callback = function()
		vim.schedule(require("chezmoi.commands.__edit").watch)
	end,
})
