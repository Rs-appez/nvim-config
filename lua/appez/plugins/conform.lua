return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>gf",
			function()
				require("conform").format({ async = true })
			end,
			desc = "Format buffer",
		},
	},
	opts = {
		formatters_by_ft = {
			javascript = { "prettier" },
			typescript = { "prettier" },
			html = { "prettier" },
			css = { "prettier" },
			json = { "prettier" },
			yaml = { "prettier" },
			markdown = { "prettier" },
			htmldjango = { "djlint" },
			hcl = { "hclfmt" },
			sh = { "beautysh" },
			zsh = { "beautysh" },
			lua = { "stylua" },
			go = { "gofmt" },
			sql = { "pgformatter" },
			rust = { "rustfmt" },
			terraform = { "terraform" },
			make = { "mbake" },
		},
		formatters = {
			pgformatter = {
				command = "pg_format",
				args = { "-" },
				stdin = true,
			},
			terraform = {
				command = "terraform",
				args = { "fmt", "-" },
				stdin = true,
			},
			mbake = {
				command = "mbake",
				args = { "format", "$FILENAME" },
				stdin = false,
			},
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},
	},
}
