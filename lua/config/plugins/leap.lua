local M = {
    "ggandor/leap.nvim",
    keys = {
        { mode = { "n", "o", "x" }, "<CR>" },
        { mode = { "n", "o", "x" }, "<S-CR>" },
        { mode = { "n", "o", "x" }, "g<CR>" },
        { mode = { "o", "x" }, "x" },
        { mode = { "o", "x" }, "X" },
    },
    dependencies = {
        -- {
        --     "ggandor/flit.nvim",
        --     config = true,
        --     keys = {
        --         { mode = { "n", "o", "x" }, "t" },
        --         { mode = { "n", "o", "x" }, "T" },
        --         { mode = { "n", "o", "x" }, "f" },
        --         { mode = { "n", "o", "x" }, "F" },
        --     },
        -- },
        "vim-repeat",
    },
}

M.config = function()
    vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" })
    vim.keymap.set({ "n", "o", "x" }, "<CR>", "<Plug>(leap-forward-to)")
    vim.keymap.set({ "n", "o", "x" }, "<S-CR>", "<Plug>(leap-backward-to)")
    vim.keymap.set({ "n", "o", "x" }, "g<CR>", "<Plug>(leap-from-window)")

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

        local clever = require("leap.user").with_traversal_keys -- [2]
        local clever_f = clever("f", "F")
        local clever_t = clever("t", "T")

        for key, key_specific_args in pairs({
            f = { opts = clever_f },
            F = { backward = true, opts = clever_f },
            t = { offset = -1, opts = clever_t },
            T = { backward = true, offset = 1, opts = clever_t },
        }) do
            vim.keymap.set({ "n", "x", "o" }, key, function()
                require("leap").leap(as_ft(key_specific_args))
            end)
        end
    end

    ------------------------------------------------------------------------
    -- [1] Match the modes here for which you don't want to use labels
    --     (`:h mode()`, `:h lua-pattern`).
    -- [2] This helper function makes it easier to set "clever-f"-like
    --     functionality (https://github.com/rhysd/clever-f.vim), returning
    --     an `opts` table derived from the defaults, where the given keys
    --     are added to `keys.next_target` and `keys.prev_target`
end

return M
