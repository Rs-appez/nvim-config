vim.filetype.add({
	pattern = {
		[".*%.yaml%.tftpl"] = "yaml",
		[".*%.yml%.tftpl"] = "yaml",
		[".*%.sh%.tftpl"] = "sh",
		[".*%.bash%.tftpl"] = "sh",
		[".*%.json%.tftpl"] = "json",
		[".*%.hcl%.tftpl"] = "hcl",
		[".*%.tf%.tftpl"] = "terraform",
		[".*%.txt%.tftpl"] = "text",
	},
})
