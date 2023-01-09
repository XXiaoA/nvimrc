local M = {
    "ggandor/leap.nvim",
    event = "VeryLazy",
    dependencies = {
        { "ggandor/flit.nvim", config = true },
        { "ggandor/leap-spooky.nvim", config = true },
    },
}

M.config = function()
    vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" })
    require("leap").add_default_mappings(true)

    -- to fix the conflict with treehopper
    vim.keymap.del({ "x", "o" }, "mm")
end

return M
