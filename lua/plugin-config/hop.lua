local ok, hop = pcall(require, "hop")
if not ok then
    vim.notify(' hop failed to load')
    return
end

hop.setup({
        keys = "etovxqpdygfblzhckisuran",
        -- jump_on_sole_occurrence = false,
})
