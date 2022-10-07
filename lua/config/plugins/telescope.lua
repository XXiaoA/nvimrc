local actions = require("utils").require_plugin("telescope.actions")
local telescope = require("utils").require_plugin("telescope")

if not actions or not telescope then
    return
end

local nmap = require("core.keymap").nmap
nmap("<leader>/", ":Telescope current_buffer_fuzzy_find<CR>", { desc = "find current buffer" })
nmap("<leader>gs", ":Telescope git_status<CR>", { desc = "git status and diff" })
nmap("<leader>gc", ":Telescope git_commits<CR>", { desc = "commit history" })
nmap("<leader>gC", ":Telescope git_bcommits<CR>", { desc = "buffer commit history" })

nmap("<leader>fw", ":Telescope live_grep<CR>", { desc = "search words" })
nmap("<leader>ff", ":Telescope find_files<CR>", { desc = "search files" })
nmap("<leader>fr", ":Telescope oldfiles<CR>", { desc = "search recent files" })
nmap("<leader>fb", ":Telescope buffers<CR>", { desc = "search buffers" })
nmap("<leader>fh", ":Telescope help_tags<CR>", { desc = "search help tags" })

telescope.setup({
    defaults = {
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

    extensions = {
        fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        },
    },
})
