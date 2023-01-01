local saga = require("utils").require("lspsaga")
if not saga then
    return
end

local configuration = {
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
}

saga.init_lsp_saga(configuration)
