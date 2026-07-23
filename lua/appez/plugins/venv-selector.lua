return {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
        "neovim/nvim-lspconfig",
    },
    ft = "python",
    keys = {
        { ",v", "<cmd>VenvSelect<cr>" },
    },
    ---@type venv-selector.Config
    opts = {
        -- Your settings go here
    },
}
