local tc = require("utils").require("todo-comments")
if not tc then
    return
end

require("core.keymap").set_keymap("n")("<leader>ft", ":TodoTelescope<CR>")

tc.setup({
    highlight = {
        keyword = "bg",
    },
})
