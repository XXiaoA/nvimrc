local tsht = require("utils").require_plugin("tsht")
if not tsht then
    return
end

local map = require("core.keymap").set_keymap({ "o", "x" })

tsht.config.hint_keys = { "h", "j", "f", "d", "g", "k", "l", "s", "a" }

map("m", ":lua require('tsht').nodes()<CR>")
