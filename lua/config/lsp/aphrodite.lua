return {
    "XXiaoA/aphrodite.nvim",
    event = "LspAttach",
    opts = {
        lightbulb = {
            enable_in_insert = false,
            sign = true,
            virtual_text = false,
        },
        diagnostic_header = { " ", " ", " ", " " },
        symbol_in_winbar = {
            enable = false,
            show_file = false,
            separator = " ",
        },
    },
}
