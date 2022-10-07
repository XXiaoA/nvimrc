local hop = require("utils").require_plugin("hop")

if hop then
    hop.setup({
        keys = "hjfdgklsa",
        -- jump_on_sole_occurrence = false,
    })
end

-- https://github.com/phaazon/hop.nvim/wiki/Advanced-Hop
local map = require("core.keymap").set_keymap({ "n", "x" })
map("f", function()
    hop.hint_char1({
        direction = require("hop.hint").HintDirection.AFTER_CURSOR,
        current_line_only = true,
    })
end)

map("F", function()
    hop.hint_char1({
        direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
        current_line_only = true,
    })
end)

map("t", function()
    hop.hint_char1({
        direction = require("hop.hint").HintDirection.AFTER_CURSOR,
        current_line_only = true,
        hint_offset = -1,
    })
end)

map("T", function()
    hop.hint_char1({
        direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
        current_line_only = true,
        hint_offset = -1,
    })
end)
