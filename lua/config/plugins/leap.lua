local M = {
    "ggandor/leap.nvim",
    event = "VeryLazy",
    dependencies = {
        { "ggandor/flit.nvim", config = true },
        { "ggandor/leap-spooky.nvim", config = true },
        "tpope/vim-repeat",
    },
}

M.config = function()
    vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" })
    require("leap").add_default_mappings(true)

    -- to fix the conflict with treehopper
    vim.keymap.del({ "x", "o" }, "mm")

    vim.keymap.del({ "n", "o", "x" }, "s")
    vim.keymap.del({ "n", "o", "x" }, "S")
    vim.keymap.set({ "n", "o", "x" }, "<CR>", "<Plug>(leap-forward-to)")
    vim.keymap.set({ "n", "o", "x" }, "<S-CR>", "<Plug>(leap-backward-to)")
end

return M
