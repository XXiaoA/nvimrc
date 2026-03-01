local M = {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    init = function()
        vim.g.nvim_surround_no_mappings = true
    end,
    config = function()
        vim.keymap.set("n", "sa", "<Plug>(nvim-surround-normal)", {
            desc = "Add a surrounding pair around a motion (normal mode)",
        })
        vim.keymap.set("n", "ssa", "<Plug>(nvim-surround-normal-cur)", {
            desc = "Add a surrounding pair around the current line (normal mode)",
        })
        vim.keymap.set("n", "sA", "<Plug>(nvim-surround-normal-line)", {
            desc = "Add a surrounding pair around a motion, on new lines (normal mode)",
        })
        vim.keymap.set("n", "ssA", "<Plug>(nvim-surround-normal-cur-line)", {
            desc = "Add a surrounding pair around the current line, on new lines (normal mode)",
        })
        vim.keymap.set("x", "sa", "<Plug>(nvim-surround-visual)", {
            desc = "Add a surrounding pair around a visual selection",
        })
        vim.keymap.set("x", "sA", "<Plug>(nvim-surround-visual-line)", {
            desc = "Add a surrounding pair around a visual selection, on neq lines",
        })
        vim.keymap.set("n", "sd", "<Plug>(nvim-surround-delete)", {
            desc = "Delete a surrounding pair",
        })
        vim.keymap.set("n", "sc", "<Plug>(nvim-surround-change)", {
            desc = "Change a surrounding pair",
        })
        vim.keymap.set("n", "sC", "<Plug>(nvim-surround-change-line)", {
            desc = "Change a surrounding pair, putting replacements on neq lines",
        })
    end,
}

return M
