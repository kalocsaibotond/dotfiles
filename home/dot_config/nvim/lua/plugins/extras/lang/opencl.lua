return {
	{
		"brgmnn/vim-opencl",
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
						"--style={BasedOnStyle: chromium, IndentWidth: 8}",
					},
				},
			},
		},
	},
}
