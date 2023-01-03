local M = {
    "akinsho/toggleterm.nvim",
    keys = { "<leader>tt", "<leader>tf", "<leader>ta" },
}
M.config = function()
    local tg = require("utils").require("toggleterm")
    local terminal = require("utils").require("toggleterm.terminal")
    if not tg or not terminal then
        return
    end

    local keymap = require("core.keymap")
    local tmap = keymap.tmap

    local Terminal = terminal.Terminal
    tg.setup({
        size = 13,
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = "1",
        start_in_insert = true,
        persist_size = true,
        direction = "horizontal",
    })

    -- 新建浮动终端
    local floatTerm = Terminal:new({
        hidden = true,
        direction = "float",
        float_opts = {
            border = "single",
        },
        on_open = function(term)
            vim.cmd("startinsert")
            -- 浮动终端中 <ESC> 是退出插入模式
            tmap("<ESC>", "<C-\\><C-n>", { buffer = term.bufnr })
        end,
        on_close = function()
            -- 重新映射 <ESC>
            tmap("<ESC>", "<C-\\><C-n>")
        end,
    })

    -- 定义新的方法
    tg.float_toggle = function()
        floatTerm:toggle()
    end

    local nmap = require("core.keymap").nmap
    nmap("<leader>tt", '<cmd>exe v:count."ToggleTerm"<CR>', { desc = "Toggle a common terminal" })
    nmap("<leader>tf", tg.float_toggle, { desc = "Toggle a float terminal" })
    nmap("<leader>ta", "<cmd>ToggleTermToggleAll<CR>", { desc = "Toggle all terminal" })
end

return M
