local ok, sniprun = pcall(require, "sniprun")
if not ok then
    vim.notify(" sniprun failed to load")
    return
end

sniprun.setup {
    display = {
        -- "Classic",
        -- "NvimNotify",
        "VirtualTextOk",
        "LongTempFloatingWindow",
    }
}
