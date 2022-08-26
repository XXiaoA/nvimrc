require("tsht").config.hint_keys = { "h", "j", "f", "d", "n", "v", "s", "l", "a" }

local map = require("core.keymap").set_keymap
local omap = map("o")
local xmap = map("v")
omap("m", ":<C-U>lua require('tsht').nodes()<CR>")
xmap("m", ":lua require('tsht').nodes()<CR>")

