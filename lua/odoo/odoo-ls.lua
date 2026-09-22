local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")
local capabilities = vim.lsp.protocol.make_client_capabilities()
local has_blink, blink = pcall(require, "blink.cmp")

if has_blink then
	capabilities = blink.get_lsp_capabilities(capabilities)
end

if not configs.odoo_ls then
	configs.odoo_ls = {
		default_config = {
			cmd = { "/home/appez/.local/share/nvim/odoo/odoo_ls_server" },
			filetypes = { "python", "javascript", "xml" },
			root_dir = lspconfig.util.root_pattern("odools.toml"),
			settings = {},
		},
	}
end

lspconfig.odoo_ls.setup({
	capabilities = capabilities,
})
