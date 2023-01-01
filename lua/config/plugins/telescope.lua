local actions = require("utils").require("telescope.actions")
local telescope = require("utils").require("telescope")

if not actions or not telescope then
    return
end

local nmap = require("core.keymap").nmap
nmap("<C-p>", ":Telescope current_buffer_fuzzy_find<CR>", { desc = "find current buffer" })
nmap("<leader>gs", ":Telescope git_status<CR>", { desc = "git status and diff" })
nmap("<leader>gc", ":Telescope git_commits<CR>", { desc = "commit history" })
nmap("<leader>gC", ":Telescope git_bcommits<CR>", { desc = "buffer commit history" })

nmap("<leader>fw", ":Telescope live_grep<CR>", { desc = "search words" })
nmap("<leader>ff", ":Telescope find_files<CR>", { desc = "search files" })
nmap("<leader>fr", ":Telescope oldfiles<CR>", { desc = "search recent files" })
nmap("<leader>fb", ":Telescope buffers<CR>", { desc = "search buffers" })
nmap("<leader>fh", ":Telescope help_tags<CR>", { desc = "search help tags" })
nmap("<leader>fu", ":Telescope resume<CR>", { desc = "resume last picker" })

telescope.setup({
    defaults = {
        vimgrep_arguments = {
            "rg",
            "-L",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
        },
        prompt_prefix = "   ",
        selection_caret = "  ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
            horizontal = {
                prompt_position = "top",
                preview_width = 0.55,
                results_width = 0.8,
            },
            vertical = {
                mirror = false,
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
        },
        file_sorter = require("telescope.sorters").get_fuzzy_file,
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        path_display = { "truncate" },
        winblend = 0,
        border = {},
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
        mappings = {
            n = {
                ["q"] = actions.close,
            },
        },
        file_ignore_patterns = {
            "./node_modules",
            ".*~",
            "vimcdoc",
            "/usr/share/nvim/runtime/doc",
            "COMMIT_EDITMSG",
        },
    },
})
