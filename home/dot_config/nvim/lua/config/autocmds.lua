-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

if vim.g.vscode then
-- vscode-nvim settings
else
	-- OpenCL file settings
	vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
		pattern = "*.cl",
		callback = function()
			vim.opt_local.filetype = "c" -- We treat it as if it were a C file
		end,
		desc = "Set OpenCL filetype related options.",
	})

	-- C language family related file settings (clang compiler supported)
	vim.api.nvim_create_autocmd({ "FIleType" }, {
		callback = function()
			if
				"c" == vim.opt_local.filetype:get()
				or "cpp" == vim.opt_local.filetype:get()
			then
				vim.opt_local.tabstop = 8
				vim.opt_local.expandtab = false
				vim.opt_local.softtabstop = 8
				vim.opt_local.shiftwidth = 8
			end
		end,
		desc = "Set C language family filetype related options.",
	})

	-- Powershell file type settings
	vim.api.nvim_create_autocmd({ "FIleType" }, {
		callback = function()
			if "ps1" == vim.opt_local.filetype:get() then
				vim.opt_local.tabstop = 4
				vim.opt_local.expandtab = true
				vim.opt_local.softtabstop = 4
				vim.opt_local.shiftwidth = 4
			end
		end,
		desc = "Set C language family filetype related options.",
	})
end
