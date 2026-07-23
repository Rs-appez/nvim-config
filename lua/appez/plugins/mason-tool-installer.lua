return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	dependencies = { "mason-org/mason.nvim" },
	opts = {
		ensure_installed = {
			"prettier",
			"djlint",
			"hclfmt",
			"beautysh",
			"stylua",
			"mbake",
			"pgformatter",
			"terraform",
		},
	},
}
