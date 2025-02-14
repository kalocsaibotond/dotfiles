return {
	{
		"scottmckendry/cyberdream.nvim",
		config = function(_, _)
			require("cyberdream").setup({
				transparent = true,
				italic_comments = true,
				hide_fillchars = true,
				borderless_pickers = true,
				terminal_colors = true,
				opts = {
					colors = {
						bg = "#000000",
					},
				},
			})
		end,
	},
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "cyberdream",
		},
	},
}
