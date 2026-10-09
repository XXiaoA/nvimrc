return {
    "chomosuke/typst-preview.nvim",
    ft = "typst",
    keys = {
        {
            "<leader>ll",
            "<cmd>TypstPreviewToggle<CR>",
            ft = "typst",
            desc = "Toggle Typst preview",
        },
    },
    opts = {
        debug = false,
        dependencies_bin = { tinymist = "tinymist" },
        open_cmd = "firefox --new-window %s",
    },
}
