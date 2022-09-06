vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "gitconfig",
    command = "set ft=gitconfig",
})
