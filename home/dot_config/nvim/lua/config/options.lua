-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local os = require("os")

local psep = package.config:sub(1, 1) -- Directory path separator on platform

-- Setting ruler
vim.opt.colorcolumn = "79"

-- Setting vertical cursor line
vim.opt.cursorcolumn = true

-- Setting ergonomic nerdfont for gui usage, especially for neovim-qt
vim.opt.guifont = "OpenDyslexicM Nerd Font Mono:h10"

-- Setting default shell preferences
if vim.fn.executable("cmd") then
	if vim.fn.executable("powershell") then
		if vim.fn.executable("pwsh") then
			vim.o.shell = "pwsh"
		else
			vim.o.shell = "powershell"
		end

		vim.o.shellcmdflag = "-NoLogo -ExecutionPolicy Bypass -Command "
		--   .. "[Console]::InputEncoding=[Console]"
		--   .. "::OutputEncoding=[System.Text.UTF8Encoding]::new();"
		--   .. "$PSDefaultParameterValues['Out-File:Encoding']='utf8';"
		--   .. "Remove-Alias -Force -ErrorAction SilentlyContinue tee;"
		-- vim.o.shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
		-- vim.o.shellpipe = '2>&1 | %%{ "$_" } | Tee-Object %s; exit $LastExitCode'
		vim.o.shellredir = "| Out-File -Encoding UTF8 %s"
		vim.o.shellpipe = "| Out-File -Encoding UTF8 %s"
		vim.o.shellquote = ""
		vim.o.shellxquote = ""
	end
else
	if vim.fn.executable("dash") then
		vim.o.shell = "dash"
	elseif vim.fn.executable("bash") then
		vim.o.shell = "bash"
	end
end

-- Setting up python3 provider
local conda_prefix = os.getenv("CONDA_PREFIX")
if nil == conda_prefix then
	vim.g.python3_host_prog = vim.env.HOME
		.. psep
		.. "Anaconda3"
		.. psep
		.. "python"
else
	vim.g.python3_host_prog = conda_prefix .. psep .. "python"
end
