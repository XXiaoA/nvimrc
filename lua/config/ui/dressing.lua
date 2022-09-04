local dressing = require("utils").requirePlugin("dressing")
if not dressing then
    return
end

dressing.setup({
    -- If you want the mapping in vim.ui.input
    input = {
        mappings = {
            -- n for normal mode
            n = {
                q = "Close",
            },
        },
    },
    -- If you want the mapping in vim.ui.select
    select = {
        builtin = {
            mappings = {
                q = "Close",
            },
        },
    },
})
