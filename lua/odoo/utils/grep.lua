local extensions = { "js", "ts", "py", "xml", "css", "scss", "html" }

local function build_globs(prefix, exclude)
    local globs = vim.tbl_map(function(ext)
        return prefix .. "*." .. ext
    end, extensions)

    if exclude then
        table.insert(globs, exclude)
    end
    return globs
end

local function grep_odoo(globs, desc)
    return function()
        Snacks.picker.grep({
            glob = globs,
            regex = false,
            title = desc,
        })
    end
end

local grep_targets = {
    { key = "<leader>og", desc = "Grep Odoo Main Files", globs = build_globs("", "!**/tests/**") },
    { key = "<leader>ot", desc = "Grep Odoo Test Files", globs = build_globs("**/tests/**/") },
}

for _, target in ipairs(grep_targets) do
    vim.keymap.set("n", target.key, grep_odoo(target.globs, target.desc), { desc = target.desc })
end
