local map = require("core.keymap").set_keymap
local omap = map("o")
local xmap = map("x")
local init = false

xmap("m", function()
    if vim.api.nvim_buf_get_option(0, "ft") ~= "gitcommit" then
        if not init then
            vim.cmd.packadd("nvim-treehopper")
            require("tsht").config.hint_keys = { "h", "j", "f", "d", "n", "v", "s", "l", "a" }
            init = true
        end
        vim.cmd.normal("v")
        require("tsht").nodes()
    else
        vim.cmd.normal("gv")
    end
end)
omap("m", function()
    if vim.api.nvim_buf_get_option(0, "ft") ~= "gitcommit" then
        if not init then
            vim.cmd.packadd("nvim-treehopper")
            require("tsht").config.hint_keys = { "h", "j", "f", "d", "n", "v", "s", "l", "a" }
            init = true
        end
        require("tsht").nodes()
    end
end)
