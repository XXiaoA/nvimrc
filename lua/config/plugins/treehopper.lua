require("tsht").config.hint_keys = { "h", "j", "f", "d", "n", "v", "s", "l", "a" }

local map = require("core.keymap").set_keymap
local omap = map("o")
local xmap = map("v")
omap("m", ":<C-U>lua require('tsht').nodes()<CR>")
xmap("m", ":lua require('tsht').nodes()<CR>")

vim.cmd([[
hi! link TSNodeKey HopNextKey
hi! link TSNodeUnmatched HopUnmatched
]])
vim.api.nvim_create_autocmd("ColorScheme", {
    command = [[
hi! link TSNodeKey HopNextKey
hi! link TSNodeUnmatched HopUnmatched
    ]],
})
