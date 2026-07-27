return {
    "chomosuke/typst-preview.nvim",
    ft = "typst",
    opts = {
        debug = false,
        dependencies_bin = { tinymist = "tinymist" },
        open_cmd = "firefox %s -P nvim-preview --class nvim-preview",
    },
}
