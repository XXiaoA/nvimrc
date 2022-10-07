local map = require("core.keymap").set_keymap
local omap = map("o")
local xmap = map("x")
local init = false

require("tsht").config.hint_keys = { "h", "j", "f", "d", "g", "k", "l", "s", "a" }
xmap("m", function()
    if vim.api.nvim_buf_get_option(0, "ft") ~= "gitcommit" then
        vim.cmd.normal("v")
        require("tsht").nodes()
    else
        vim.cmd.normal("gv")
    end
end)
omap("m", function()
    if vim.api.nvim_buf_get_option(0, "ft") ~= "gitcommit" then
        require("tsht").nodes()
    end
end)
