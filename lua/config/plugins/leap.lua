local M = {
    "ggandor/leap.nvim",
    keys = {
        { mode = { "n", "o", "x" }, "\\" },
        { mode = { "n", "o", "x" }, "<CR>" },
        { mode = { "n", "o", "x" }, "<S-CR>" },
        { mode = { "n", "o", "x" }, "g<CR>" },
        { mode = { "o", "x" }, "x" },
        { mode = { "o", "x" }, "X" },
    },
    dependencies = {
        {
            "ggandor/flit.nvim",
            config = true,
            keys = {
                { mode = { "n", "o", "x" }, "t" },
                { mode = { "n", "o", "x" }, "T" },
                { mode = { "n", "o", "x" }, "f" },
                { mode = { "n", "o", "x" }, "F" },
            },
        },
        "vim-repeat",
    },
}

M.config = function()
    vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" })
    require("leap").add_default_mappings(true)

    vim.keymap.del({ "n", "o", "x" }, "s")
    vim.keymap.del({ "n", "o", "x" }, "S")
    vim.keymap.del({ "n", "o", "x" }, "gs")
    vim.keymap.set({ "n", "o", "x" }, "<CR>", "<Plug>(leap-forward-to)")
    vim.keymap.set({ "n", "o", "x" }, "<S-CR>", "<Plug>(leap-backward-to)")
    vim.keymap.set({ "n", "o", "x" }, "g<CR>", "<Plug>(leap-from-window)")

    local function get_line_starts(winid)
        local wininfo = vim.fn.getwininfo(winid)[1]
        local cur_line = vim.fn.line(".")
        -- Skip lines close to the cursor.
        local skip_range = 2

        -- Get targets.
        local targets = {}
        local lnum = wininfo.topline
        while lnum <= wininfo.botline do
            local fold_end = vim.fn.foldclosedend(lnum)
            -- Skip folded ranges.
            if fold_end ~= -1 then
                lnum = fold_end + 1
            else
                if (lnum < cur_line - skip_range) or (lnum > cur_line + skip_range) then
                    table.insert(targets, { pos = { lnum, 1 } })
                end
                lnum = lnum + 1
            end
        end

        -- Sort them by vertical screen distance from cursor.
        local cur_screen_row = vim.fn.screenpos(winid, cur_line, 1)["row"]
        local function screen_rows_from_cur(t)
            local t_screen_row = vim.fn.screenpos(winid, t.pos[1], t.pos[2])["row"]
            return math.abs(cur_screen_row - t_screen_row)
        end
        table.sort(targets, function(t1, t2)
            return screen_rows_from_cur(t1) < screen_rows_from_cur(t2)
        end)

        if #targets >= 1 then
            return targets
        end
    end

    ---@diagnostic disable-next-line: lowercase-global
    function leap_linewise()
        local winid = vim.api.nvim_get_current_win()
        require("leap").leap({
            target_windows = { winid },
            targets = get_line_starts(winid),
        })
    end
    vim.keymap.set("n", "\\", leap_linewise)
    -- For maximum comfort, make sure to set the mappings in a way that forces linewise selection:
    vim.keymap.set("x", "\\", function()
        -- Do not exit from V if already in it (pressing v/V/<C-v>
        -- again exits the corresponding Visual mode).
        return (vim.fn.mode(1) == "V" and "" or "V") .. "<cmd>lua leap_linewise()<cr>"
    end, { expr = true })
    vim.keymap.set("o", "\\", "V<cmd>lua leap_linewise()<cr>")
end

return M
