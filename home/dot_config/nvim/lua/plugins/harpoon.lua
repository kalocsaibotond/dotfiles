return {
	"ThePrimeagen/harpoon",
	keys = {
		{
			"<leader>6",
			function()
				require("harpoon"):list():select(6)
			end,
			desc = "Harpoon to file 6",
		},
		{
			"<leader>7",
			function()
				require("harpoon"):list():select(7)
			end,
			desc = "Harpoon to file 7",
		},
		{
			"<leader>8",
			function()
				require("harpoon"):list():select(8)
			end,
			desc = "Harpoon to file 8",
		},
		{
			"<leader>9",
			function()
				require("harpoon"):list():select(9)
			end,
			desc = "Harpoon to file 9",
		},
	},
}
