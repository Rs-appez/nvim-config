return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main", -- Required for Neovim 0.12+
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").setup()
		end,
	},

	{
		"mks-h/treesitter-autoinstall.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = {
			ignore = {},

			highlight = true,

			regex = {},
		},
	},
}
