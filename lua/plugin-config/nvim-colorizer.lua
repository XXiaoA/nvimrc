local ok, colorizer = pcall(require, "colorizer")
if not ok then
    vim.notify(' colorizer failed to load')
    return
end

colorizer.setup {
    "*",
}
