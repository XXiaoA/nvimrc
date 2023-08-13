require("nightfox").setup({
    options = {
        styles = {
            comments = "italic",
            -- conditionals = "italic",
            constants = "NONE",
            -- functions = "bold",
            keywords = "italic",
            numbers = "NONE",
            operators = "NONE",
            strings = "NONE",
            types = "NONE",
            variables = "NONE",
        },
        modules = {
            aerial = true,
            cmp = true,
            fidget = true,
            gitsigns = true,
            illuminate = true,
            indent_blanklines = true,
            neotree = true,
            telescope = true,
            tsrainbow2 = true,
            whichkey = true,
        },
    },
    groups = {
        nightfox = {
            NvimSurroundHighlight = { bg = "bg4" },
        },
    },
})
