local tc = require("utils").requirePlugin("treesitter-context")

if not tc then
    return
end

tc.setup({
    patterns = {
        default = {
            "class",
            "function",
            "method",
            "for",
            "while",
            "if",
            "elseif",
            "switch",
            "case",
        },
    },

    mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
    separator = "-",
})
