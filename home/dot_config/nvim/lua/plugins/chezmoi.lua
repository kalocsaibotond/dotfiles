return {
	{
		"alker0/chezmoi.vim", -- For syntax highlighting
		lazy = false,
		init = function()
			-- This option is required.
			vim.g["chezmoi#use_tmp_buffer"] = true
			-- add other options here if needed.
		end,
	},
	{
		"xvzc/chezmoi.nvim", -- For chezmoi-managed file editing, applying
		event = "LazyFile",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local telescope = require("telescope")
			-- require("chezmoi").setup({
			-- 	-- your configurations
			-- })
			telescope.load_extension("chezmoi")
		end,
		keys = {
			{
				"<leader>fz",
				function()
					require("telescope").extensions.chezmoi.find_files()
				end,
				desc = "Find Chezmoi Source File",
			},
		},
	},
}
