local actions = require("utils").requirePlugin("telescope.actions")
local telescope = require("utils").requirePlugin("telescope")

if not actions or not telescope then
    return
end

telescope.setup({
    defaults = {
        mappings = {
            n = {
                ["q"] = actions.close,
            },
        },
        file_ignore_patterns = { "./node_modules", ".*~" },
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
