vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "*.rasi",
    command = "set filetype=css",
})
