local illuminate = require("utils").require_plugin("illuminate")
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
        "markdown",
    },
    modes_allowlist = { "n" },
})
