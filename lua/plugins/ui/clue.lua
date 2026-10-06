local vimtex_mappings = {
    { mode = "n", suffix = "i", desc = "Project information" },
    { mode = "n", suffix = "I", desc = "Full project information" },
    { mode = "n", suffix = "t", desc = "Open table of contents" },
    { mode = "n", suffix = "T", desc = "Toggle table of contents" },
    { mode = "n", suffix = "q", desc = "VimTeX log" },
    { mode = "n", suffix = "v", desc = "View PDF / forward search" },
    { mode = "n", suffix = "l", desc = "Toggle continuous compile" },
    { mode = "n", suffix = "L", desc = "Compile selected lines" },
    { mode = "x", suffix = "L", desc = "Compile selected lines" },
    { mode = "n", suffix = "S", desc = "Compile once" },
    { mode = "n", suffix = "k", desc = "Stop compilation" },
    { mode = "n", suffix = "K", desc = "Stop all compilations" },
    { mode = "n", suffix = "e", desc = "Show compile errors" },
    { mode = "n", suffix = "o", desc = "Show compiler output" },
    { mode = "n", suffix = "g", desc = "Show compile status" },
    { mode = "n", suffix = "G", desc = "Show all project statuses" },
    { mode = "n", suffix = "c", desc = "Clean auxiliary files" },
    { mode = "n", suffix = "C", desc = "Clean all generated files" },
    { mode = "n", suffix = "m", desc = "List math insert mappings" },
    { mode = "n", suffix = "x", desc = "Reload VimTeX" },
    { mode = "n", suffix = "X", desc = "Reload project state" },
    { mode = "n", suffix = "s", desc = "Toggle main file" },
    { mode = "n", suffix = "a", desc = "Citation context menu" },
}

local function vimtex_group_clue()
    if vim.bo.filetype ~= "tex" or not vim.b.vimtex then
        return {}
    end

    return {
        mode = "n",
        keys = vim.g.vimtex_mappings_prefix or "<localleader>l",
        desc = "+VimTeX",
    }
end

return {
    "echasnovski/mini.clue",
    event = "VeryLazy",
    init = function()
        local group = vim.api.nvim_create_augroup("mini_clue_vimtex", { clear = true })
        vim.api.nvim_create_autocmd("User", {
            group = group,
            pattern = "VimtexEventInitPost",
            callback = function(args)
                if vim.bo[args.buf].filetype ~= "tex" then
                    return
                end

                local miniclue = require("mini.clue")
                local prefix = vim.g.vimtex_mappings_prefix or "<localleader>l"
                local lhs_prefix = vim.api.nvim_replace_termcodes(prefix, true, true, true)
                for _, mapping in ipairs(vimtex_mappings) do
                    local lhs = lhs_prefix .. mapping.suffix
                    if vim.fn.maparg(lhs, mapping.mode, false, true).lhs then
                        miniclue.set_mapping_desc(mapping.mode, lhs, mapping.desc)
                    end
                end
            end,
        })
    end,
    config = function()
        local miniclue = require("mini.clue")
        miniclue.setup({
            clues = {
                vimtex_group_clue,
                { mode = "n", keys = "<Leader>b", desc = "+Buffer" },
                { mode = "n", keys = "<leader><tab>", desc = "+Tab" },
                { mode = "n", keys = "<leader>a", desc = "+Aerial" },
                { mode = "n", keys = "<leader>c", desc = "+Colorscheme" },
                { mode = "n", keys = "<leader>f", desc = "+Find" },
                { mode = "n", keys = "<leader>o", desc = "+Open" },
                { mode = "n", keys = "<leader>g", desc = "+Git" },
                { mode = "n", keys = "<leader>gt", desc = "+Toggle" },
                miniclue.gen_clues.builtin_completion(),
                miniclue.gen_clues.g(),
                miniclue.gen_clues.marks(),
                miniclue.gen_clues.registers(),
                miniclue.gen_clues.windows(),
                miniclue.gen_clues.z(),
            },
            triggers = {
                { mode = "n", keys = "<Leader>" }, -- Leader triggers
                { mode = "x", keys = "<Leader>" },
                { mode = "n", keys = "[" }, -- mini.bracketed
                { mode = "n", keys = "]" },
                { mode = "x", keys = "[" },
                { mode = "x", keys = "]" },
                { mode = "i", keys = "<C-x>" }, -- Built-in completion
                { mode = "n", keys = "g" }, -- `g` key
                { mode = "x", keys = "g" },
                { mode = "n", keys = "'" }, -- Marks
                { mode = "n", keys = "`" },
                { mode = "x", keys = "'" },
                { mode = "x", keys = "`" },
                { mode = "n", keys = '"' }, -- Registers
                { mode = "x", keys = '"' },
                { mode = "i", keys = "<C-r>" },
                { mode = "c", keys = "<C-r>" },
                { mode = "n", keys = "<C-w>" }, -- Window commands
                { mode = "n", keys = "z" }, -- `z` key
                { mode = "x", keys = "z" },
            },
            window = {
                delay = 400,
                config = {
                    width = "auto",
                    border = "rounded",
                },
            },
        })
    end,
}
