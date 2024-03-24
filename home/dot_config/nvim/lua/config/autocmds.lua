-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Chezmoi
local chezmoi_worktree = vim.env.HOME .. "/.local/share/chezmoi/**"
-- chezmoi_worktree = vim.api.nvim_exec2(
-- 	"!chezmoi execute-template '{{.chezmoi.workingTree}}/**'", -- HACK: abusing chezmoi template execution
-- 	{ output = false }
-- )[0]
-- vim.print(chezmoi_worktree)  -- ize  ize ize
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { chezmoi_worktree },
	callback = function()
		vim.schedule(require("chezmoi.commands.__edit").watch)
	end,
})
