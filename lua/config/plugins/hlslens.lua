local hlslens = require("utils").require_plugin("hlslens")
if not hlslens then
    return
end
require("hlslens").setup()

local map = require("core.keymap").set_keymap({ "x", "n", "o" })

local function nN(char)
    local ok, winid = hlslens.nNPeekWithUFO(char)
    if ok and winid then
        -- Safe to override buffer scope keymaps remapped by ufo,
        -- ufo will restore previous buffer keymaps before closing preview window
        -- Type <CR> will switch to preview window and fire `tarce` action
        vim.keymap.set("n", "<CR>", function()
            local keyCodes = vim.api.nvim_replace_termcodes("<Tab><CR>", true, false, true)
            vim.api.nvim_feedkeys(keyCodes, "im", false)
        end, { buffer = true })
    end
end

map("n", function()
    nN("n")
end)
map("N", function()
    nN("N")
end)
map("*", [[*<Cmd>lua require('hlslens').start()<CR>N]])
map("#", [[#<Cmd>lua require('hlslens').start()<CR>N]])
map("g*", [[g*<Cmd>lua require('hlslens').start()<CR>N]])

