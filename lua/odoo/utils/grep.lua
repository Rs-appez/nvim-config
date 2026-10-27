local globs = { "*.js", "*.ts", "*.py", "*.xml", "*.css", "*.scss", "*.html" }

local function grep_odoo_with(extra_glob, opts)
    local Snacks = require("snacks")
    local glob = vim.list_extend(vim.deepcopy(globs), { extra_glob })

    Snacks.picker.grep(vim.tbl_extend("force", {
        glob = glob,
        regex = false,
    }, opts or {}))
end

local function grep_odoo()
    grep_odoo_with("!**/tests/**")
end

local function grep_odoo_tests()
    grep_odoo_with("**/tests/**")
end

vim.keymap.set("n", "<leader>og", grep_odoo, {
    desc = "Grep Odoo Main Files",
})

vim.keymap.set("n", "<leader>ot", grep_odoo_tests, {
    desc = "Grep Odoo Test Files",
})
