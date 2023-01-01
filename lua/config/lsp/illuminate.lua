local illuminate = require("utils").require("illuminate")
if not illuminate then
    return
end

local nmap = require("core.keymap").nmap

nmap("]]", illuminate.goto_next_reference, { desc = "Next reference" })
nmap("[[", illuminate.goto_prev_reference, { desc = "Previous reference" })

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
