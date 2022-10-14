local gitsigns = require("utils").require_plugin("gitsigns")
if not gitsigns then
    return
end

gitsigns.setup({
    signs = {
        add = {
            hl = "GitSignsAdd",
            text = "│",
            numhl = "GitSignsAddNr",
            linehl = "GitSignsAddLn",
        },
        change = {
            hl = "GitSignsChange",
            text = "│",
            numhl = "GitSignsChangeNr",
            linehl = "GitSignsChangeLn",
        },
        delete = {
            hl = "GitSignsDelete",
            text = "_",
            numhl = "GitSignsDeleteNr",
            linehl = "GitSignsDeleteLn",
        },
        topdelete = {
            hl = "GitSignsDelete",
            text = "‾",
            numhl = "GitSignsDeleteNr",
            linehl = "GitSignsDeleteLn",
        },
        changedelete = {
            hl = "GitSignsChange",
            text = "~",
            numhl = "GitSignsChangeNr",
            linehl = "GitSignsChangeLn",
        },
    },
    word_diff = false,
    on_attach = function()
        local map = require("core.keymap").set_keymap
        local nmap = map("n")

        -- Navigation
        nmap("]c", function()
            if vim.wo.diff then
                return "]c"
            end
            vim.schedule(function()
                gitsigns.next_hunk()
            end)
            return "<Ignore>"
        end, { expr = true, desc = "next hunk" })

        nmap("[c", function()
            if vim.wo.diff then
                return "[c"
            end
            vim.schedule(function()
                gitsigns.prev_hunk()
            end)
            return "<Ignore>"
        end, { expr = true, desc = "previous hunk" })

        -- Actions
        nmap("<leader>gA", gitsigns.stage_buffer, { desc = "git stage buffer" })
        map({ "n", "v" })("<leader>ga", ":Gitsigns stage_hunk<CR>", { desc = "git stage hunk" })
        nmap("<leader>gR", gitsigns.reset_buffer, { desc = "git reset buffer" })
        map({ "n", "v" })("<leader>gr", ":Gitsigns reset_hunk<CR>", { desc = "git reset hunk" })
        nmap("<leader>gp", gitsigns.preview_hunk, { desc = "preview hunk" })
        nmap("<leader>gu", gitsigns.undo_stage_hunk, { desc = "git undo stage hunk" })
        nmap("<leader>gd", gitsigns.diffthis, { desc = "git diffthis" })
        nmap("<leader>gD", function()
            gitsigns.diffthis("~")
        end, { desc = "git diffthis" })
        nmap("<leader>gb", function()
            gitsigns.blame_line({ full = true })
        end, { desc = "git blame line" })
        nmap("<leader>td", gitsigns.toggle_deleted, { desc = "git toggle deleted" })
        nmap("<leader>tw", gitsigns.toggle_word_diff, { desc = "git toggle word diff" })

        -- Text object
        map({ "o", "x" })("ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "" })
    end,
})
