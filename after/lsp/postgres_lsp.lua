return {
	settings = {
		postgres = {
			command = { "sqls", "server" },
			filetypes = { "sql" },
			root_dir = function()
				return vim.fn.getcwd()
			end,
		},
	},
}
