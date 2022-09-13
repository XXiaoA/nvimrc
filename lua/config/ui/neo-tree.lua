local nt = require("utils").require_plugin("neo-tree")

if not nt then
    return
end

nt.setup({
    filesystem = {
        filtered_items = {
            hide_dotfiles = false,
        },
    },
})
