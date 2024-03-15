return {
    "Exafunction/codeium.vim",
    event = "VeryLazy",
    config = function()
        vim.keymap.set("i", "<M-g>", function()
            return vim.fn["codeium#Accept"]()
        end, { expr = true, silent = true })
        vim.keymap.set("i", "<M-;>", function()
            return vim.fn["codeium#CycleCompletions"](1)
        end, { expr = true, silent = true })
        vim.keymap.set("i", "<M-,>", function()
            return vim.fn["codeium#CycleCompletions"](-1)
        end, { expr = true, silent = true })
        vim.keymap.set("i", "<M-x>", function()
            return vim.fn["codeium#Clear"]()
        end, { expr = true, silent = true })
    end,
}
