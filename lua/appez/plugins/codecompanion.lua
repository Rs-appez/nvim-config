local function get_default_model()
	local hostname = vim.fn.hostname()
	if hostname == "archDesktop" then
		return "gemma4:e4b"
	elseif hostname == "archLaptop" then
		return "qwen2.5-coder:3b"
	else
		return "gpt-5-mini"
	end
end

return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	opts = {
		interactions = {
			chat = {
				adapter = "ollama",
				model = get_default_model(),
			},
			inline = {
				keymaps = {
					accept_change = {
						modes = { n = "ga" },
						description = "Accept the suggested change",
					},
					reject_change = {
						modes = { n = "gr" },
						opts = { nowait = true },
						description = "Reject the suggested change",
					},
				},
			},
		},
		adapters = {
			http = {
				ollama = function()
					return require("codecompanion.adapters").extend("ollama", {
						schema = {
							model = {
								default = get_default_model(),
							},
						},
					})
				end,
				copilot = function()
					return require("codecompanion.adapters").extend("copilot", {
						schema = {
							model = {
								default = get_default_model(),
							},
						},
					})
				end,
				-- Define your custom adapters here
				opts = {
					show_presets = false,
				},
			},
			acp = {
				opts = {
					show_presets = false,
				},
			},
		},
		display = {
			chat = {
				auto_scroll = false,
				window = {
					position = "right",
				},
			},
		},
		-- NOTE: The log_level is in `opts.opts`
		opts = {
			log_level = "DEBUG", -- or "TRACE"
		},
	},
	keys = {
		{ "<C-a>", ":CodeCompanionActions<CR>", desc = "Open the action palette", mode = { "n", "x" } },
		{ "<Leader>a", ":CodeCompanionChat Toggle<CR>", desc = "Toggle a chat buffer", mode = { "n", "x" } },
		{ "ga", ":CodeCompanionChat Add<CR>", desc = "Add code to a chat buffer", mode = "v" },
	},
}
