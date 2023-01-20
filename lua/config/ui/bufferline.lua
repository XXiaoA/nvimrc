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
        { "[b", ":BufferLineCyclePrev<CR>", silent = true, desc = "Go to previous buffer" },
        { "]b", ":BufferLineCycleNext<CR>", silent = true, desc = "Go to next buffer" },
    },
}
