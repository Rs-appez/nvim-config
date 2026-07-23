return {
    "uga-rosa/ccc.nvim",
    ft = { "css", "html" },
    keys = {
        { "<leader>cp", "<cmd>CccPick<cr>", desc = "Color picker" },
    },
    config = function()
        local ccc = require("ccc")
        ccc.setup({
            highlighter = {
                auto_enable = true,
                lsp = true,
            },
            highlight_mode = "virtual",
        })
    end,
}
