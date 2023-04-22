return {
    "akinsho/bufferline.nvim",
    event = "BufEnter",
    dependencies = "nvim-web-devicons",
    opts = {
        options = {
            -- 使用 nvim 内置lsp
            diagnostics = "nvim_lsp",
            -- 左侧让出 File Explorer 的位置
            offsets = {
                {
                    filetype = "NvimTree",
                    text = "File Explorer",
                    highlight = "Directory",
                    text_align = "left",
                },
            },
        },
    },
    keys = {
        { "<leader>bh", ":BufferLineMovePrev<CR>", silent = true, desc = "Move buffer Left" },
        { "<leader>bl", ":BufferLineMoveNext<CR>", silent = true, desc = "Move buffer Right" },
        {
            "<leader>bc",
            ":BufferLinePickClose<CR>",
            silent = true,
            desc = "Pick a buffer to close",
        },
        { "]b", ":BufferLineCyclePrev<CR>", silent = true, desc = "Previous buffer" },
        { "[b", ":BufferLineCycleNext<CR>", silent = true, desc = "Next buffer" },
    },
}
