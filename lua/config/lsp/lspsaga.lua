return {
    "glepnir/lspsaga.nvim",
    event = "VeryLazy",
    commit = "b7b4777369b441341b2dcd45c738ea4167c11c9e",
    config = function()
        local saga = require("lspsaga")
        saga.init_lsp_saga({
            code_action_lightbulb = {
                enable_in_insert = false,
                sign = true,
                virtual_text = false,
            },
            diagnostic_header = { " ", " ", " ", " " },
            show_outline = {
                jump_key = "<CR>",
            },
            symbol_in_winbar = {
                enable = false,
                show_file = false,
            },
        })
    end,
}
