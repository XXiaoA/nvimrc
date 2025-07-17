local M = {
    "akinsho/toggleterm.nvim",
    keys = { "<leader>tt", "<leader>tf", "<leader>ta" },
}
M.config = function()
    local tg = require("toggleterm")
    if not tg then
        return
    end
    local terminal = require("toggleterm.terminal")

    local Terminal = terminal.Terminal
    tg.setup({
        size = 13,
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = "1",
        start_in_insert = true,
        persist_size = true,
        direction = "horizontal",
        on_open = function()
            vim.cmd.startinsert()
        end,
    })

    local floatTerm = Terminal:new({
        hidden = true,
        direction = "float",
        float_opts = {
            border = "single",
        },
        on_open = function()
            vim.cmd.startinsert()
        end,
    })
    tg.float_toggle = function()
        pcall(vim.cmd.w)
        floatTerm:toggle()
    end

    local nmap = require("core.keymap").nmap
    nmap("<leader>tt", '<cmd>w|exe v:count."ToggleTerm"<CR>', { desc = "Toggle a common terminal" })
    nmap("<leader>tf", tg.float_toggle, { desc = "Toggle a float terminal" })
    nmap("<leader>ta", "<cmd>ToggleTermToggleAll<CR>", { desc = "Toggle all terminal" })
end

return M
