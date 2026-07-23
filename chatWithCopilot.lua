vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        require("CopilotChat").open()
        vim.cmd("wincmd j")
        vim.cmd("q")
    end,
})
