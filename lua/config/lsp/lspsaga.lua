local saga = require("utils").require_plugin("lspsaga")
if not saga then
    return
end

saga.init_lsp_saga({
    code_action_lightbulb = {
        enable_in_insert = false,
        sign = true,
        virtual_text = false,
    },
    show_outline = {
        jump_key = "<CR>",
    },
})
