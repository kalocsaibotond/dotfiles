-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local os = require("os")

local psep = package.config:sub(1, 1) -- Directory path separator on platform

-- Disabling animations
vim.g.snacks_animate = false

-- Setting ruler
vim.opt.colorcolumn = { 80 }

-- Setting horizontal and vertical cursor line
vim.opt.cursorline = false
vim.opt.cursorcolumn = false

-- Setting ergonomic nerdfont for gui usage, especially for neovim-qt
vim.opt.guifont = "OpenDyslexicM Nerd Font Mono:h10"

-- Setting default shell preferences per system
local uname = vim.uv.os_uname().sysname

if "Windows_NT" == uname then -- Getting rid of cmd if possible
	if 1 == vim.fn.executable("powershell") then
		if 1 == vim.fn.executable("pwsh") then
			vim.opt.shell = "pwsh"
		else
			vim.opt.shell = "powershell"
		end

		vim.opt.shellcmdflag = "-NoLogo -ExecutionPolicy Bypass -Command "
		--   .. "[Console]::InputEncoding=[Console]"
		--   .. "::OutputEncoding=[System.Text.UTF8Encoding]::new();"
		--   .. "$PSDefaultParameterValues['Out-File:Encoding']='utf8';"
		--   .. "Remove-Alias -Force -ErrorAction SilentlyContinue tee;"
		-- vim.opt.shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
		-- vim.opt.shellpipe = '2>&1 | %%{ "$_" } | Tee-Object %s; exit $LastExitCode'
		vim.opt.shellredir = "| Out-File -Encoding UTF8 %s"
		vim.opt.shellpipe = "| Out-File -Encoding UTF8 %s"
		vim.opt.shellquote = ""
		vim.opt.shellxquote = ""
	end
end

-- Setting up python3 provider
local conda_prefix = os.getenv("CONDA_PREFIX")
if conda_prefix then
	vim.g.python3_host_prog = conda_prefix .. psep .. "python"
end

-- C specific options
vim.g.c_syntax_for_h = 1
