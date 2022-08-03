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

local nmap = require("core.keymap").set_keymap("n")

nmap("q", function()
    local bf = vim.api.nvim_get_current_buf()
    local filetype = vim.api.nvim_buf_get_option(bf, "filetype")
    if filetype == "TelescopePrompt" then
        vim.api.nvim_win_close(0, true)
    end
end)
