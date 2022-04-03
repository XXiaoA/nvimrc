local ok, nvim_tree = pcall(require, "nvim-tree")
if not ok then
    vim.notify(' nvim-tree failed to load')
    return
end
vim.g.nvim_tree_respect_buf_cwd = 1

nvim_tree.setup({
    nvim_tree_auto_close = true,
    update_cwd = true,
    update_focused_file = {
        enable = true,
        update_cwd = true
    },
})
