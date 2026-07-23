require("CopilotChat.config").providers.locals = {
	prepare_input = require("CopilotChat.config.providers").copilot.prepare_input,
	prepare_output = require("CopilotChat.config.providers").copilot.prepare_output,

	get_url = function(opts)
		return "http://localhost:11434/v1/chat/completions"
	end,

	get_models = function(headers)
		local response, err = require("CopilotChat.utils.curl").get("http://localhost:11434/v1/models", {
			headers = headers,
			json_response = true,
		})

		if err then
			error(err)
		end

		return vim.tbl_map(function(model)
			return {
				id = model.id,
				name = model.id,
			}
		end, response.body.data)
	end,
}
