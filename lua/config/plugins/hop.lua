local M = {
    "phaazon/hop.nvim",
    keys = {
        "<leader>hw",
        "<leader>hW",
        "<leader>hl",
        "<leader>hp",
        { "t", mode = { "n", "x", "o" } },
        { "T", mode = { "n", "x", "o" } },
        { "f", mode = { "n", "x", "o" } },
        { "F", mode = { "n", "x", "o" } },
        { "se", mode = { "n", "x", "o" } },
    },
    config = function()
        require("config.plugins.hop")
    end,
}

M.config = function()
    local hop = require("utils").require("hop")

    if hop then
        hop.setup({
            keys = "hjfdgklsa",
            -- jump_on_sole_occurrence = false,
        })
    end

    local map = require("core.keymap").set_keymap({ "o", "n", "x" })
    map("<leader>hl", hop.hint_lines_skip_whitespace)
    map("<leader>hw", function()
        hop.hint_words({
            direction = require("hop.hint").HintDirection.AFTER_CURSOR,
        })
    end)
    map("<leader>hW", function()
        hop.hint_words({
            direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
        })
    end)
    map("<leader>hp", hop.hint_patterns)
    map("se", hop.hint_char2)

    -- https://github.com/phaazon/hop.nvim/wiki/Advanced-Hop
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
            hint_offset = 1,
        })
    end)
end

return M
