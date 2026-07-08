return {
	"ludovicchabant/vim-gutentags",
	event = "LazyFile",
	init = function()
		local uname = vim.uv.os_uname().sysname
		if "Windows_NT" == uname then
			vim.g.gutentags_trace = 1
		end
	end,
}
