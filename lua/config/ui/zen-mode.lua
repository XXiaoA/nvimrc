local zm = require("utils").require_plugin("zen-mode")
if not zm then
    return
end

local nmap = require("core.keymap").nmap
nmap("<leader>z", "<CMD>ZenMode<CR>")

zm.setup({
    plugins = {
        options = {
            enabled = true,
            showcmd = true,
        },
        twilight = { enabled = true },
        gitsigns = { enabled = true },
        -- tmux = { enabled = true },
    },
})
