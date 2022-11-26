local illuminate = require("utils").require_plugin("illuminate")
if not illuminate then
    return
end

local nmap = require("core.keymap").nmap

nmap('<A-N>', illuminate.goto_prev_reference, { desc = "Move to previous reference" })

illuminate.configure({
    delay = 100,
    filetypes_denylist = {
        "dirvish",
        "fugitive",
        "packer",
        "gitcommit",
        "neo-tree",
        "aerial",
        "dashboard",
        "markdown",
    },
    modes_allowlist = { "n" },
})
