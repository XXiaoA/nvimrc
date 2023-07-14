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
            map({ "n", "v" })("]h", function()
                if vim.wo.diff then
                    return "]h"
                end
                vim.schedule(function()
                    gs.next_hunk()
                end)
                return "<Ignore>"
            end, { expr = true, desc = "Next hunk" })

            map({ "n", "v" })("[h", function()
                if vim.wo.diff then
                    return "[h"
                end
                vim.schedule(function()
                    gs.prev_hunk()
                end)
                return "<Ignore>"
            end, { expr = true, desc = "Previous hunk" })

            -- Actions
            nmap("<leader>gA", gs.stage_buffer, { desc = "Stage buffer" })
            map({ "n", "v" })("<leader>ga", ":Gitsigns stage_hunk<CR>", { desc = "Stage hunk" })
            nmap("<leader>gR", gs.reset_buffer, { desc = "Reset buffer" })
            map({ "n", "v" })("<leader>gr", ":Gitsigns reset_hunk<CR>", { desc = "Reset hunk" })
            nmap("<leader>gp", gs.preview_hunk, { desc = "Preview hunk" })
            nmap("<leader>gu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
            nmap("<leader>gd", gs.diffthis, { desc = "Git diffthis" })
            nmap("<leader>gD", function()
                gs.diffthis("~")
            end, { desc = "Diffthis with ~" })
            nmap("<leader>gb", function()
                gs.blame_line({ full = true })
            end, { desc = "Blame line" })
            nmap("<leader>gtd", gs.toggle_deleted, { desc = "Toggle deleted" })
            nmap("<leader>gtw", gs.toggle_word_diff, { desc = "Toggle word diff" })

            -- Text object
            map({ "o", "x" })("ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Huck" })
        end,
    })
    package.loaded.trouble = nil
    package.preload.trouble = nil
end

return M
