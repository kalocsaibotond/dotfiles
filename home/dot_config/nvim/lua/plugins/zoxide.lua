if "telescope" == LazyVim.pick.picker.name then
	return {
		"jvgrootveld/telescope-zoxide",
		dependencies = {
			"nvim-lua/popup.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = function(_, _)
			local telescope = require("telescope")
			-- local z_utils = require("telescope._extensions.zoxide.utils")
			-- telescope.setup({
			-- 	extensions = {
			-- 		zoxide = {
			-- 			-- your configurations
			-- 		},
			-- 	},
			-- })
			telescope.load_extension("zoxide")
		end,
		keys = {
			{
				"<leader>fd",
				function()
					require("telescope").extensions.zoxide.list()
				end,
				desc = "Change directory (cwd)",
			},
		},
	}
else
	return {
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = {
			{
				"<leader>fd",
				function()
					require("fzf-lua").zoxide()
				end,
				desc = "Change directory (cwd)",
			},
		},
	}
end
