local function do_builtin(builtin, opts)
    return function()
        builtin = builtin
        opts = vim.tbl_deep_extend("force", { cwd = require("utils").get_root() }, opts or {})
        require("telescope.builtin")[builtin](opts)
    end
end

local M = {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "kyazdani42/nvim-web-devicons",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    cmd = "Telescope",
    keys = {
        {
            "<leader>fs",
            do_builtin("lsp_document_symbols", {
                symbols = {
                    "Class",
                    "Function",
                    "Method",
                    "Constructor",
                    "Interface",
                    "Module",
                    "Struct",
                    "Trait",
                    "Field",
                    "Property",
                },
            }),
            desc = "Search symbol",
        },
        { "<leader>fm", "<cmd>Telescope man_pages<CR>", desc = "Search man pages" },
        { "<leader>fu", "<cmd>Telescope resume<CR>", desc = "Resume last picker" },
        { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Search help tags" },
        { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Search buffers" },
        { "<leader>fr", "<cmd>Telescope oldfiles<CR>", desc = "Search recent files" },
        { "<leader>ff", do_builtin("find_files"), desc = "Search files" },
        { "<leader>fw", do_builtin("live_grep"), desc = "Search words" },
        { "<leader>gC", "<cmd>Telescope git_bcommits<CR>", desc = "Buffer commit history" },
        { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "Search commit history" },
        { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "Search git status" },
        { "<leader>cp", "<cmd>Telescope themes<CR>", desc = "Change colorscheme with preview" },
        { "z=", "<cmd>Telescope spell_suggest<CR>", desc = "Spell suggest" },
    },
    opts = {
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
            path_display = { "truncate" },
            winblend = 0,
            border = {},
            borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
            color_devicons = true,
            set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
            file_previewer = function(...)
                return require("telescope.previewers").vim_buffer_cat.new(...)
            end,
            grep_previewer = function(...)
                return require("telescope.previewers").vim_buffer_vimgrep.new(...)
            end,
            qflist_previewer = function(...)
                return require("telescope.previewers").vim_buffer_qflist.new(...)
            end,
            -- Developer configurations: Not meant for general override
            buffer_previewer_maker = function(...)
                return require("telescope.previewers").buffer_previewer_maker(...)
            end,
            mappings = {
                n = {
                    ["q"] = function(...)
                        return require("telescope.actions").close(...)
                    end,
                    ["-"] = function(...)
                        return require("telescope.actions").file_split(...)
                    end,
                    ["|"] = function(...)
                        return require("telescope.actions").file_vsplit(...)
                    end,
                    ["\\"] = function(...)
                        return require("telescope.actions").file_vsplit(...)
                    end,
                },
            },
            file_ignore_patterns = {
                "./node_modules",
                ".*~",
                "/usr/share/nvim/runtime/doc",
                "COMMIT_EDITMSG",
            },
        },
    },
}

M.config = function(_, opts)
    local telescope = require("telescope")

    telescope.setup(opts)
    for _, extension in ipairs({ "themes", "fzf" }) do
        telescope.load_extension(extension)
    end
end

return M
