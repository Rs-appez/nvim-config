return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lf = require("appez.utils.lualine_functions")
		require("lualine").setup({
			options = {
				section_separators = { left = "", right = "" },
				component_separators = {},
			},
			sections = {
				lualine_a = {
					{
						"mode",
						fmt = function(str)
							return str:sub(1, 1)
						end,
					},
				},
				lualine_b = { "branch", "diff" },
				lualine_c = { "diagnostics", "filename" },

				lualine_x = {
					-- copilot model indicator
					{
						lf.codeCompanionModel,
						cond = function()
							return package.loaded["codecompanion"] ~= nil
						end,
						color = { fg = "#9063CD" },
					},
					-- display recording register
					{
						require("noice").api.statusline.mode.get,
						cond = function()
							return vim.fn.reg_recording() ~= ""
						end,
						color = { fg = "#ff9e64" },
					},
				},
				lualine_y = {
					-- visual selection lines and characters count
					{
						lf.selectionCount,
						cond = function()
							return vim.fn.mode():find("[vV]") ~= nil
						end,
						color = { fg = "#a3be8c" },
					},
					"encoding",
					"fileformat",
					"filetype",
				},
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "filetype" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			extensions = {},
		})
	end,
}
