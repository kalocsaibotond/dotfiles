return {
	"jvgrootveld/telescope-zoxide",
	dependencies = {
		"nvim-lua/popup.nvim",
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		-- local z_utils = require("telescope._extensions.zoxide.utils")
		require("telescope").setup({
			extensions = {
				zoxide = {
					-- your configurations
				},
			},
		})
	end,
}
