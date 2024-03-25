return {
	"nvimdev/dashboard-nvim",
	opts = function(_, opts)
		table.insert(
			opts.config.center,
			6,
			{ -- Inserting chezmoi dashboard entry
				action = require("telescope").extensions.chezmoi.find_files,
				desc = " Chezmoi",
				icon = opts.config.center[5].icon,
				key = "z",
				key_format = opts.config.center[5].key_format,
			}
		)
	end,
}
