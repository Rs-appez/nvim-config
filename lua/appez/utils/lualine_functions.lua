local M = {}
function M.selectionCount()
	local isVisualMode = vim.fn.mode():find("[Vv]")
	if not isVisualMode then
		return ""
	end
	local starts = vim.fn.line("v")
	local ends = vim.fn.line(".")
	local lines = starts <= ends and ends - starts + 1 or starts - ends + 1
	return "  " .. tostring(lines) .. "L " .. tostring(vim.fn.wordcount().visual_chars) .. "C"
end

function M.codeCompanionModel()
	local ok, codecompanion = pcall(require, "codecompanion")
	if not ok then
		return ""
	end

	local chat = codecompanion.buf_get_chat(0)
	if chat and chat.adapter then
		local model = chat.settings and chat.settings.model or chat.adapter.model or ""
		local name = chat.adapter.name or "Unknown"

		if model ~= "" then
			return "󰚩  " .. name .. " (" .. model .. ")"
		end
		return "󰚩  " .. name
	end
	return ""
end

return M
