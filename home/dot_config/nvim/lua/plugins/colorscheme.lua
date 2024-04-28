return {
	{
		"scottmckendry/cyberdream.nvim",
		config = function()
			local colors = require("cyberdream.colors")
			require("cyberdream").setup({
				transparent = true,
				italic_comments = true,
				hide_fillchars = true,
				borderless_telescope = true,
				terminal_colors = true,
				theme = {
					highlights = {
						ColorColumn = { bg = colors.default.bgAlt },
					},
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
