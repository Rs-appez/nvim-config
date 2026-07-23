return {
    "neovim/nvim-lspconfig",
    dependencies = {
        { "mason-org/mason.nvim",          opts = {} },
        { "mason-org/mason-lspconfig.nvim" },
    },
    config = function()
        require("appez.utils.diagnostics").setup()

        -- Auto-discover and enable all lsp/*.lua configs
        local lsp_dir = vim.fn.stdpath("config") .. "/after/lsp"
        local servers = {}
        for _, file in ipairs(vim.fn.glob(lsp_dir .. "/*.lua", false, true)) do
            table.insert(servers, vim.fn.fnamemodify(file, ":t:r"))
        end

        -- Install discovered servers via mason
        require("mason-lspconfig").setup({
            ensure_installed = servers,
            automatic_installation = true,
        })

        vim.lsp.enable(servers)

        -- LSP keybindings on attach
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("lsp-keymaps", { clear = true }),
            callback = function(event)
                local client = vim.lsp.get_client_by_id(event.data.client_id)
                if not client then
                    return
                end
                local bufnr = event.buf
                local opts = { noremap = true, silent = true, buffer = bufnr, desc = "Organize Imports" }

                -- Order Imports (if supported by the client LSP)
                if client:supports_method("textDocument/codeAction", bufnr) then
                    vim.keymap.set("n", "<leader>oi", function()
                        vim.lsp.buf.code_action({
                            context = {
                                only = { "source.organizeImports" },
                                diagnostics = {},
                            },
                            apply = true,
                            bufnr = bufnr,
                        })
                    end, opts)
                end
            end,
        })
    end,

}
