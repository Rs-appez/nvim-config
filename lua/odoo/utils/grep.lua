local function grep_odoo()
    local Snacks = require("snacks")

    Snacks.picker.grep({
        glob = {
            "*.js", "*.ts", "*.py", "*.xml",
            "*.css", "*.scss", "*.html",
            "!**/tests/**",
        },
    })
end

local function grep_odoo_tests()
    local Snacks = require("snacks")

    Snacks.picker.grep({
        glob = {
            "*.js", "*.ts", "*.py", "*.xml",
            "*.css", "*.scss", "*.html",
            "**/tests/**",
        },
    })
end

vim.keymap.set("n", "<leader>og", grep_odoo, {
    desc = "Grep Odoo Main Files",
})

vim.keymap.set("n", "<leader>ot", grep_odoo_tests, {
    desc = "Grep Odoo Test Files",
})
