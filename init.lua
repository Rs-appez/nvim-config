pcall(function()
	local env = require("appez.utils.env")
	-- Config-level secrets
	env.load(vim.fn.stdpath("config") .. "/.env")
	-- Project-level overrides
	env.load(vim.fn.getcwd() .. "/.env")
end)

require("appez")
