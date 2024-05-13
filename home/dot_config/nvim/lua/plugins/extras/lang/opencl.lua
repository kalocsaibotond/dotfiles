if not vim.g.vscode then
	local psep = package.config:sub(1, 1) -- Directory path separator on platform

	return {
		{
			"brgmnn/vim-opencl", -- For syntax highlighting
			lazy = false,
		}, -- NOTE: Contains OpenCL file detection autocommand
		{
			"neovim/nvim-lspconfig",
			opts = {
				setup = {
					opencl_ls = function()
						require("lspconfig").opencl_ls.setup({})
					end,
				},
			},
		},
		{
			"williamboman/mason.nvim",
			opts = function(_, opts)
				table.insert(opts.ensure_installed, "clang-format")
			end,
		},
		{
			"stevearc/conform.nvim",
			opts = {
				formatters_by_ft = {
					["opencl"] = { "clang-format" },
				},
				formatters = {
					["clang-format"] = {
						args = {
							"--fallback-style=Chromium",
							"--style=file:"
								.. vim.env.HOME
								.. psep
								.. ".clang-format",
						},
					},
				},
			},
		},
	}
else
	return {}
end
