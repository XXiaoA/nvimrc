return {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
    config = function()
        local indent_blankline = require("utils").require("indent_blankline")
        if indent_blankline then
            indent_blankline.setup({
                space_char_blankline = " ",
                show_current_context = true,
                show_current_context_start = true,
            })
        end
        vim.g.indent_blankline_filetype_exclude = {
            "help",
            "TERMINAL",
            "terminal",
            "startuptime",
            "toggleterm",
            "translator",
        }
    end,
}
