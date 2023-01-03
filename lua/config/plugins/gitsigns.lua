local M = {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
}

M.config = function()
    if not package.loaded.trouble then
        package.preload.trouble = function()
            return true
        end
    end
    require("gitsigns").setup({
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
            local gs = package.loaded.gitsigns
            local map = require("core.keymap").set_keymap
            local nmap = map("n")

            -- Navigation
            map({ "n", "v" })("]c", function()
                if vim.wo.diff then
                    return "]c"
                end
                vim.schedule(function()
                    gs.next_hunk()
                end)
                return "<Ignore>"
            end, { expr = true, desc = "next hunk" })

            map({ "n", "v" })("[c", function()
                if vim.wo.diff then
                    return "[c"
                end
                vim.schedule(function()
                    gs.prev_hunk()
                end)
                return "<Ignore>"
            end, { expr = true, desc = "previous hunk" })

            -- Actions
            nmap("<leader>gA", gs.stage_buffer, { desc = "git stage buffer" })
            map({ "n", "v" })("<leader>ga", ":Gitsigns stage_hunk<CR>", { desc = "git stage hunk" })
            nmap("<leader>gR", gs.reset_buffer, { desc = "git reset buffer" })
            map({ "n", "v" })("<leader>gr", ":Gitsigns reset_hunk<CR>", { desc = "git reset hunk" })
            nmap("<leader>gp", gs.preview_hunk, { desc = "preview hunk" })
            nmap("<leader>gu", gs.undo_stage_hunk, { desc = "git undo stage hunk" })
            nmap("<leader>gd", gs.diffthis, { desc = "git diffthis" })
            nmap("<leader>gD", function()
                gs.diffthis("~")
            end, { desc = "git diffthis" })
            nmap("<leader>gb", function()
                gs.blame_line({ full = true })
            end, { desc = "git blame line" })
            nmap("<leader>td", gs.toggle_deleted, { desc = "git toggle deleted" })
            nmap("<leader>tw", gs.toggle_word_diff, { desc = "git toggle word diff" })

            -- Text object
            map({ "o", "x" })("ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "" })
        end,
    })
    package.loaded.trouble = nil
    package.preload.trouble = nil
end

return M
