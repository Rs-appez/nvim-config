-- run script
local execute_mapping = "<leader>rs"

local function execute_script(cmd, include_filename)
	cmd = cmd or "cat"
	include_filename = include_filename or true
	local filename = ""
	if include_filename then
		filename = " %"
	end
	return ":wa<CR>:sp<CR>:term time " .. cmd .. filename .. "<CR>"
end

-- log
local log_mapping = "<leader>lg"
local log_macro_print = 'viw"lyoprint(""lpa : ", "lpa)'

-- Python
local function get_python_cmd()
	if vim.fn.filereadable(vim.fn.getcwd() .. "/uv.lock") == 1 then
		return "uv run python"
	end
	return "python3"
end

local function run_module()
	local current_file = vim.fn.expand("%:p")
	local cwd = vim.fn.getcwd()
	local rel_path = current_file:sub(#cwd + 2):gsub("%.py$", ""):gsub("/", ".")
	if rel_path ~= "" then
		return ":wa<CR>:sp<CR>:term time " .. get_python_cmd() .. " -m " .. rel_path .. "<CR>"
	end
	return ":echo 'Cannot determine module name'<CR>"
end
vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	callback = function()
		vim.keymap.set(
			"n",
			execute_mapping,
			execute_script(get_python_cmd()),
			{ desc = "Execute current Python script" }
		)
		vim.keymap.set(
			"v",
			log_mapping,
			'yoprint("" : ",")',
			{ desc = "Insert print statement for selected variable" }
		)
		vim.keymap.set("n", log_mapping, log_macro_print, { desc = "Insert print statement for variable under cursor" })
		vim.keymap.set("n", "<leader>rm", run_module(), { desc = "Run current Python module" })
	end,
})

-- Lua
vim.api.nvim_create_autocmd("FileType", {
	pattern = "lua",
	callback = function()
		vim.keymap.set("n", execute_mapping, execute_script("lua"), { desc = "Execute current Lua script" })
		vim.keymap.set("n", log_mapping, log_macro_print, { desc = "Insert print statement for variable under cursor" })
	end,
})

-- C#
vim.api.nvim_create_autocmd("FileType", {
	pattern = "cs",
	callback = function()
		vim.keymap.set(
			"n",
			execute_mapping,
			execute_script("dotnet run", false),
			{ desc = "Execute current C# script" }
		)
		vim.keymap.set(
			"n",
			log_mapping,
			'viw"lyoConsole.WriteLine(""lpa : " + "lpa);',
			{ desc = "Insert Console.WriteLine statement for variable under cursor" }
		)
	end,
})

-- Rust
vim.api.nvim_create_autocmd("FileType", {
	pattern = "rust",
	callback = function()
		vim.keymap.set(
			"n",
			execute_mapping,
			execute_script("cargo run", false),
			{ desc = "Execute current Rust script" }
		)
		vim.keymap.set(
			"n",
			log_mapping,
			'viw"lyoprintln!(""lpa : {}", "lpa);',
			{ desc = "Insert println! statement for variable under cursor" }
		)
	end,
})

-- Go
vim.api.nvim_create_autocmd("FileType", {
	pattern = "go",
	callback = function()
		vim.keymap.set("n", execute_mapping, execute_script("go run"), { desc = "Execute current Go script" })
		vim.keymap.set(
			"n",
			log_mapping,
			'viw"lyoprintln(""lpa : ", "lpa)',
			{ desc = "Insert println statement for variable under cursor" }
		)
	end,
})

--JavaScript/TypeScript
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "javascript", "typescript" },
	callback = function()
		vim.keymap.set(
			"n",
			execute_mapping,
			execute_script("bun"),
			{ desc = "Execute current JavaScript/TypeScript script" }
		)
		vim.keymap.set(
			"n",
			log_mapping,
			'viw"lyoconsole.log(""lpa : ", "lpa);',
			{ desc = "Insert console.log statement for variable under cursor" }
		)
	end,
})

-- Angular
local function generate_ng_file()
	local target_dir = vim.fn.getcwd() .. "/src/app"
	local old_dir = vim.fn.getcwd()
	vim.cmd("lcd " .. target_dir)

	vim.schedule(function()
		vim.ui.input({
			prompt = "Enter path for Angular file (relative to src/app): ",
			completion = "file",
		}, function(path)
			if not path or path == "" then
				print("Invalid path")
				vim.cmd("lcd " .. old_dir)
				return
			end
			vim.ui.input({
				prompt = "Enter type (component/service/module/directive/pipe): ",
				completion = "none",
			}, function(type)
				vim.cmd("lcd " .. old_dir)
				if not type or type == "" then
					print("Invalid type")
					return
				end
				local cmd = "ng generate " .. type .. " " .. path
				local result = vim.fn.system(cmd)
				if vim.v.shell_error == 0 then
					print("Angular file generated: " .. path)
					local ts_file
					local dir_to_handle = vim.loop.fs_scandir(target_dir .. "/" .. path)
					if not dir_to_handle then
						print("Could not open directory to find generated file.")
						return
					end
					while true do
						local name, _ = vim.loop.fs_scandir_next(dir_to_handle)
						if not name then
							break
						end
						if name:match("%.ts$") and not name:match("%.spec%.ts$") then
							ts_file = name
							break
						end
					end
					if ts_file then
						vim.cmd("edit " .. target_dir .. "/" .. path .. "/" .. ts_file)
					else
						print("Could not find generated TypeScript file.")
					end
				else
					print("Error: " .. result)
				end
			end)
		end)
	end)
end
if vim.fn.filereadable(vim.fn.getcwd() .. "/angular.json") == 1 then
	vim.api.nvim_create_autocmd("FileType", {
		pattern = {},
		callback = function()
			vim.keymap.set(
				"n",
				"<leader>ng",
				generate_ng_file,
				{ desc = "Generate Angular Component/Service/Module..." }
			)
		end,
	})
end
