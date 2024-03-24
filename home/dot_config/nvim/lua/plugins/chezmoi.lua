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
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("chezmoi").setup({
				-- your configurations
			})
		end,
	},
}
