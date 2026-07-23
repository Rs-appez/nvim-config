local M = {}

function M.load(path)
	path = path or vim.fn.getcwd() .. "/.env"

	local f = io.open(path, "r")
	if not f then
		return false
	end

	for line in f:lines() do
		-- Strip whitespace and comments
		line = line:match("^%s*(.-)%s*$")

		-- Skip empty lines and comments
		if line ~= "" and not line:match("^#") then
			-- Match KEY=VALUE (handles quotes, spaces, export prefix)
			local key, value = line:match("^export%s+([%w_]+)%s*=%s*(.+)$")
			if not key then
				key, value = line:match("^([%w_]+)%s*=%s*(.+)$")
			end

			if key and value then
				-- Remove surrounding quotes
				value = value:gsub("^[\"'](.*)[\"']-$", "%1")

				-- Expand existing env vars like ${VAR} or $VAR
				value = value:gsub("%${([%w_]+)}", function(var)
					return vim.env[var] or ""
				end)
				value = value:gsub("%$([%w_]+)", function(var)
					return vim.env[var] or ""
				end)

				vim.fn.setenv(key, value)
			end
		end
	end

	f:close()
	return true
end

return M
