require("rose-pine").setup({
    --- @usage 'main' | 'moon'
    dark_variant = "moon",
    bold_vert_split = false,
    dim_nc_background = false,
    disable_background = false,
    disable_float_background = false,
    disable_italics = false,

    highlight_groups = {
        IlluminatedWord = { bg = "#57406b" },
        IlluminatedCurWord = { bg = "#57406b" },
        IlluminatedWordText = { bg = "#57406b" },
        IlluminatedWordRead = { bg = "#57406b" },
        IlluminatedWordWrite = { bg = "#57406b" },

        TelescopeBorder = { fg = "highlight_high", bg = "none" },
        TelescopeNormal = { bg = "none" },
        TelescopePromptNormal = { bg = "base" },
        TelescopeResultsNormal = { fg = "subtle", bg = "none" },
        TelescopeSelection = { fg = "text", bg = "base" },
        TelescopeSelectionCaret = { fg = "rose", bg = "rose" },
        LeapMatch = { fg = "pine", bg = "overlay", inherit = false },
        LspInlayHint = { bg = "#2d2943", fg = "#8883a0", inherit = false },
    },
})
