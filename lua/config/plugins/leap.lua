local M = {
    "ggandor/leap.nvim",
    keys = {
        "f",
        "F",
        "t",
        "T",
        { mode = { "o", "x" }, "m" },
        { mode = { "n", "o", "x" }, "<CR>" },
        { mode = { "n", "o", "x" }, "<S-CR>" },
        { mode = { "n", "o", "x" }, "g<CR>" },
        { mode = { "o", "x" }, "x" },
        { mode = { "o", "x" }, "X" },
    },
    dependencies = {
        "vim-repeat",
    },
}

M.config = function()
    vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" })
    vim.keymap.set({ "n", "o", "x" }, "<CR>", "<Plug>(leap-forward)")
    vim.keymap.set({ "n", "o", "x" }, "<S-CR>", "<Plug>(leap-backward)")
    vim.keymap.set({ "n", "o", "x" }, "g<CR>", "<Plug>(leap-from-window)")
    vim.keymap.set({ "x", "o" }, "m", function()
        require("leap.treesitter").select({
            opts = require("leap.user").with_traversal_keys("m", "M"),
        })
    end)

    do
        -- Return an argument table for `leap()`, tailored for f/t-motions.
        local function as_ft(key_specific_args)
            local common_args = {
                inputlen = 1,
                inclusive = true,
                -- To limit search scope to the current line:
                -- pattern = function (pat) return '\\%.l'..pat end,
                opts = {
                    labels = "", -- force autojump
                    safe_labels = vim.fn.mode(1):match("[no]") and "" or nil, -- [1]
                },
            }
            return vim.tbl_deep_extend("keep", common_args, key_specific_args)
        end

        local clever = require("leap.user").with_traversal_keys(";", ",") -- [2]

        for key, key_specific_args in pairs({
            f = { opts = clever },
            F = { backward = true, opts = clever },
            t = { offset = -1, opts = clever },
            T = { backward = true, offset = 1, opts = clever },
        }) do
            vim.keymap.set({ "n", "x", "o" }, key, function()
                require("leap").leap(as_ft(key_specific_args))
            end)
        end
    end
end

return M
