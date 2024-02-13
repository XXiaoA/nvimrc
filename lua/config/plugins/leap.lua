local M = {
    "ggandor/leap.nvim",
    keys = {
        { mode = { "n", "o", "x" }, "\\" },
        { mode = { "n", "o", "x" }, "<CR>" },
        { mode = { "n", "o", "x" }, "<S-CR>" },
        { mode = { "n", "o", "x" }, "g<CR>" },
        { mode = { "o", "x" }, "x" },
        { mode = { "o", "x" }, "X" },
    },
    dependencies = {
        {
            "ggandor/flit.nvim",
            config = true,
            keys = {
                { mode = { "n", "o", "x" }, "t" },
                { mode = { "n", "o", "x" }, "T" },
                { mode = { "n", "o", "x" }, "f" },
                { mode = { "n", "o", "x" }, "F" },
            },
        },
        "vim-repeat",
    },
}

M.config = function()
    vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" })
    require("leap").add_default_mappings(true)

    vim.keymap.del({ "n", "o", "x" }, "s")
    vim.keymap.del({ "n", "o", "x" }, "S")
    vim.keymap.del({ "n", "o", "x" }, "gs")
    vim.keymap.set({ "n", "o", "x" }, "<CR>", "<Plug>(leap-forward-to)")
    vim.keymap.set({ "n", "o", "x" }, "<S-CR>", "<Plug>(leap-backward-to)")
    vim.keymap.set({ "n", "o", "x" }, "g<CR>", "<Plug>(leap-from-window)")
end

return M
