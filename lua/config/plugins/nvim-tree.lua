local nvim_tree = require("utils").requirePlugin("nvim-tree")

if nvim_tree and nvim_tree ~= true then
    vim.g.nvim_tree_respect_buf_cwd = 1

    nvim_tree.setup {
        update_cwd = true,
        update_focused_file = {
            enable = true,
            update_cwd = true
        }
    }
end
