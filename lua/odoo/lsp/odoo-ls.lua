local capabilities = vim.lsp.protocol.make_client_capabilities()
local has_blink, blink = pcall(require, "blink.cmp")
if has_blink then
	capabilities = blink.get_lsp_capabilities(capabilities)
end

local home = vim.env.HOME or vim.fn.expand("~")

vim.lsp.config("odoo_ls", {
	cmd = { home .. "/.local/share/nvim/odoo/odoo_ls_server" },
	filetypes = { "python", "javascript", "xml" },
	root_markers = { "odools.toml" },
	capabilities = capabilities,
	settings = {
		python = {
			pythonPath = "/home/odoo/odoo/.venv/bin/python",
			venv = ".venv",
			venvPath = "/home/odoo/odoo",
		},
	},
})

vim.lsp.enable("odoo_ls")
