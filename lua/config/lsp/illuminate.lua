local illuminate = require("utils").requirePlugin("illuminate")
if not illuminate then
    return
end

-- default configuration
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
    },
    modes_allowlist = { "n" },
})
