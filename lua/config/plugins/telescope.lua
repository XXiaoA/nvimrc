local actions = require("utils").requirePlugin("telescope.actions")
local telescope = require("utils").requirePlugin("telescope")

-- Global remapping
------------------------------
if not actions or not telescope then
    return
end

telescope.load_extension("zoxide")

telescope.setup({
    defaults = {
        mappings = {
            n = {
                ["q"] = actions.close,
                ["l"] = actions.file_edit,
            },
        },
        file_ignore_patterns = { "./node_modules" },
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

--按键设置
vim.api.nvim_set_keymap("n", "<leader>ff", [[<cmd>lua require('telescope.builtin').find_files()<cr>]], {})
vim.api.nvim_set_keymap("n", "<leader>fg", [[<cmd>lua require('telescope.builtin').live_grep()<cr>]], {})
vim.api.nvim_set_keymap("n", "<leader>fb", [[<cmd>lua require('telescope.builtin').buffers()<cr>]], {})
vim.api.nvim_set_keymap("n", "<leader>fh", [[<cmd>lua require('telescope.builtin').help_tags()<cr>]], {})
-- vim.api.nvim_set_keymap("n", "<leader>sf", [[<cmd>lua require('telescope.builtin').file_browser()<cr>]], {})
vim.api.nvim_set_keymap("n", "<leader>/", [[<cmd>lua require'telescope.builtin'.current_buffer_fuzzy_find{}<CR>]], {})
