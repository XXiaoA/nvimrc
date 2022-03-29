-- https://github.com/akinsho/toggleterm.nvim

local Toggleterm = require("toggleterm")

Toggleterm.setup(
    {
        --  开启的终端默认进入插入模式
        start_in_insert = false,
        -- 设置终端打开的大小
        size = 6
    }
)
