local zm = require("utils").require("zen-mode")
if not zm then
    return
end

local nmap = require("core.keymap").nmap
nmap("<leader>zz", "<CMD>ZenMode<CR>")
nmap("<leader>zt", "<CMD>Twilight<CR>")

zm.setup({
    plugins = {
        options = {
            enabled = true,
            showcmd = true,
        },
        twilight = { enabled = true },
        gitsigns = { enabled = true },
        tmux = { enabled = true },
    },
})
