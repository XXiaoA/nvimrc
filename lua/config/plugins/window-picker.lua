require("window-picker").setup({
    autoselect_one = true,
    include_current = false,
    filter_rules = {
        -- filter using buffer options
        bo = {
            -- if the file type is one of following, the window will be ignored
            -- filetype = { "neo-tree", "quickfix" },

            -- if the buffer type is one of following, the window will be ignored
            -- buftype = { "terminal" },
        },
    },
})
local picker = require("window-picker")

local nmap = require("core.keymap").set_keymap("n")
nmap(",w", function()
    local picked_window_id = picker.pick_window({
        include_current_win = true,
    }) or vim.api.nvim_get_current_win()
    vim.api.nvim_set_current_win(picked_window_id)
end, { desc = "Pick a window" })

-- Swap two windows using the awesome window picker
nmap(",W", function()
    local window = picker.pick_window({
        include_current_win = false,
    })
    local target_buffer = vim.fn.winbufnr(window)
    -- Set the target window to contain current buffer
    vim.api.nvim_win_set_buf(window, 0)
    -- Set current window to contain target buffer
    vim.api.nvim_win_set_buf(0, target_buffer)
end, { desc = "Swap windows" })
