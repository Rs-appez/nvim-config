vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<M-j>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<M-k>", "<cmd>cprev<CR>zz")

vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set("n", "<leader>P", [["+p]])

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set("n", "<leader>rr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/g<Left><Left>]],
    { desc = "[File] Replace word under cursor" })
vim.keymap.set("n", "<leader>rl", [[:s/\<<C-r><C-w>\>/<C-r><C-w>/g<Left><Left>]],
    { desc = "[Inline] Replace word under cursor" })
-- vim.keymap.set("v", "<leader>rr", [[:s/\%V<C-r><C-w>/<C-r><C-w>/g<Left><Left>]],
--     { desc = "Replace word under cursor in visual selection" })

vim.keymap.set("n", "<leader>dl", "v/[A-Z]<CR>hc", { desc = "Change up to next capital letter (excluding)" })

vim.keymap.set("n", "<leader>my", function()
    local word = vim.fn.expand("<cword>")
    local new_word = vim.fn.input("Replace '" .. word .. "' with: ", word)
    vim.cmd("normal! '[mw']mx")
    vim.cmd(":'w;'xs/\\<" .. word .. "\\>/" .. new_word .. "/g")
end, { desc = "Replace in pasted text" })

-- Navigate vim panes better
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")

-- LSP
vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, { desc = "Show diagnostics" })
