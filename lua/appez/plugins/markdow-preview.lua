-- install without yarn or npm
return {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
        vim.g.mkdp_filetypes = { "markdown", "mermaid" }
    end,
    ft = { "markdown", "mermaid" },
    keys = {
        {
            "<leader>mk",
            function()
                vim.cmd("MarkdownPreviewToggle")
            end,
            desc = "Markdown Preview Start/Stop",
        },
    },
}
